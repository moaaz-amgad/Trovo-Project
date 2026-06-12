import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/routing/app_router_paths.dart';
import '../../../home/presentation/home_screen.dart';
import '../../../home/presentation/layout_screen.dart';
import '../../../time_focus/presentation/time_focus_screen.dart';
import '../cubit/diagnosis_cubit.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Constants
// ─────────────────────────────────────────────────────────────────────────────

const Color _pageBg = Color(0xFFF2F2F2);
const Color _basis = Color(0xFF042F40);
const Color _softText = Color(0x99042F40);
const Color _accent = Color(0xFFC8EFFF);
const Color _green = Color(0xFF28A745);
const Color _yellow = Color(0xFFFFC107);
const Color _red = Color(0xFFDC3545);

PageRouteBuilder<void> _fadeRoute(Widget page) {
  return PageRouteBuilder<void>(
    pageBuilder: (_, _, _) => page,
    transitionsBuilder: (_, animation, _, child) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        child: child,
      );
    },
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Public entry-point
// ─────────────────────────────────────────────────────────────────────────────

class DiagnosisHistoryScreen extends StatelessWidget {
  const DiagnosisHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DiagnosisCubit>(
      create: (_) => sl<DiagnosisCubit>()..fetchHistory(),
      child: const _DiagnosisHistoryBody(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Body
// ─────────────────────────────────────────────────────────────────────────────

class _DiagnosisHistoryBody extends StatelessWidget {
  const _DiagnosisHistoryBody();

  @override
  Widget build(BuildContext context) {
    const double bottomNavHeight = 96;
    const double bottomNavTopOverlap = 48;
    final double bottomPadding =
        24 +
        bottomNavHeight +
        bottomNavTopOverlap +
        MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: _pageBg,
      body: SafeArea(
        child: Stack(
          children: [
            BlocBuilder<DiagnosisCubit, DiagnosisState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const Center(
                    child:
                        CircularProgressIndicator(color: _basis),
                  ),
                  loading: () => const Center(
                    child:
                        CircularProgressIndicator(color: _basis),
                  ),
                  generated: (data) => _HistoryContent(
                    data: data.data,
                    bottomPadding: bottomPadding,
                    onReDiagnose: () =>
                        context.push(AppRoutePaths.phoneUsageScreen),
                  ),
                  history: (data) => _HistoryContent(
                    data: data.data,
                    bottomPadding: bottomPadding,
                    onReDiagnose: () =>
                        context.push(AppRoutePaths.phoneUsageScreen),
                  ),
                  error: (message) => _ErrorContent(
                    message: message,
                    onRetry: () =>
                        context.read<DiagnosisCubit>().fetchHistory(),
                  ),
                );
              },
            ),
            // Bottom Navigation Bar
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _DiagnosisBottomNavBar(
                onHomeTap: () {
                  Navigator.of(context)
                      .pushReplacement(_fadeRoute(const HomeScreen()));
                },
                onGamesTap: () {
                  Navigator.of(context)
                      .pushReplacement(_fadeRoute(const LayoutScreen()));
                },
                onTimerTap: () {
                  Navigator.of(context)
                      .pushReplacement(_fadeRoute(const TimeFocusScreen()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// History Content
// ─────────────────────────────────────────────────────────────────────────────

class _HistoryContent extends StatelessWidget {
  const _HistoryContent({
    required this.data,
    required this.bottomPadding,
    required this.onReDiagnose,
  });

  final Map<String, dynamic>? data;
  final double bottomPadding;
  final VoidCallback onReDiagnose;

  @override
  Widget build(BuildContext context) {
    // Parse data from the API response
    final historyList = _extractHistoryList(data);
    final latestScore = _extractLatestScore(data);
    final avgScore = _calculateAvgScore(historyList);
    final totalDiagnoses = historyList.length;
    final trend = _calculateTrend(historyList);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 430),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(16, 14, 16, bottomPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'Diagnosis History',
                style: TextStyle(
                  color: _basis,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Track your progress over time',
                style: TextStyle(
                  color: _softText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),

              // Score Overview Card
              _ScoreOverviewCard(
                latestScore: latestScore,
                avgScore: avgScore,
                totalDiagnoses: totalDiagnoses,
                trend: trend,
              ),
              const SizedBox(height: 20),

              // Progress Chart
              if (historyList.length >= 2) ...[
                _ProgressChartCard(history: historyList),
                const SizedBox(height: 20),
              ],

              // History List
              if (historyList.isNotEmpty) ...[
                const Text(
                  'PAST DIAGNOSES',
                  style: TextStyle(
                    color: _softText,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 12),
                ...historyList.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final item = entry.value;
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: idx < historyList.length - 1 ? 10 : 0,
                    ),
                    child: _DiagnosisHistoryTile(
                      index: totalDiagnoses - idx,
                      score: _scoreFromItem(item),
                      date: _dateFromItem(item),
                      stage: _stageFromItem(item),
                    ),
                  );
                }),
                const SizedBox(height: 24),
              ] else ...[
                _EmptyStateCard(),
                const SizedBox(height: 24),
              ],

              // Re-Diagnose Button
              _ReDiagnoseButton(onPressed: onReDiagnose),
            ],
          ),
        ),
      ),
    );
  }

  // ── Data extraction helpers ────────────────────────────────────────────

  List<dynamic> _extractHistoryList(Map<String, dynamic>? data) {
    if (data == null) return [];
    // The backend returns paginated data; check for 'data' array inside
    final innerData = data['data'];
    if (innerData is List) return innerData;
    // If data itself has pagination structure
    if (innerData is Map && innerData['data'] is List) {
      return innerData['data'] as List;
    }
    // Single diagnosis result (from generate)
    if (data.containsKey('addiction_level') ||
        data.containsKey('addiction_score')) {
      return [data];
    }
    return [];
  }

  double _extractLatestScore(Map<String, dynamic>? data) {
    final list = _extractHistoryList(data);
    if (list.isNotEmpty) return _scoreFromItem(list.first);
    if (data == null) return 0;
    final raw = data['addiction_level'] ??
        data['addiction_score'] ??
        data['score'] ??
        0;
    if (raw is num) return raw.toDouble().clamp(0.0, 10.0);
    return 0;
  }

  double _calculateAvgScore(List<dynamic> list) {
    if (list.isEmpty) return 0;
    double sum = 0;
    for (final item in list) {
      sum += _scoreFromItem(item);
    }
    return sum / list.length;
  }

  String _calculateTrend(List<dynamic> list) {
    if (list.length < 2) return 'stable';
    final latest = _scoreFromItem(list.first);
    final previous = _scoreFromItem(list[1]);
    if (latest < previous) return 'improving';
    if (latest > previous) return 'worsening';
    return 'stable';
  }

  double _scoreFromItem(dynamic item) {
    if (item is Map<String, dynamic>) {
      final raw = item['addiction_level'] ??
          item['addiction_score'] ??
          item['score'] ??
          0;
      if (raw is num) return raw.toDouble().clamp(0.0, 10.0);
    }
    return 0;
  }

  String _dateFromItem(dynamic item) {
    if (item is Map<String, dynamic>) {
      final d = item['diagnosed_at'] ?? item['created_at'] ?? '';
      if (d is String && d.isNotEmpty) {
        try {
          final dt = DateTime.parse(d);
          return '${dt.day}/${dt.month}/${dt.year}';
        } catch (_) {}
      }
    }
    return 'Unknown';
  }

  String _stageFromItem(dynamic item) {
    if (item is Map<String, dynamic>) {
      return item['brainrot_stage'] as String? ?? '';
    }
    return '';
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Score Overview Card
// ─────────────────────────────────────────────────────────────────────────────

class _ScoreOverviewCard extends StatelessWidget {
  const _ScoreOverviewCard({
    required this.latestScore,
    required this.avgScore,
    required this.totalDiagnoses,
    required this.trend,
  });

  final double latestScore;
  final double avgScore;
  final int totalDiagnoses;
  final String trend;

  Color get _trendColor {
    if (trend == 'improving') return _green;
    if (trend == 'worsening') return _red;
    return _yellow;
  }

  String get _trendLabel {
    if (trend == 'improving') return '↓ Improving';
    if (trend == 'worsening') return '↑ Worsening';
    return '→ Stable';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x20000000),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Score ring
          SizedBox(
            width: 160,
            height: 160,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size(160, 160),
                  painter: _ScoreRingPainter(
                    value: latestScore / 10,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      latestScore.toStringAsFixed(1),
                      style: const TextStyle(
                        color: _basis,
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        height: 1,
                        letterSpacing: -2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'out of 10',
                      style: TextStyle(
                        color: _softText,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Trend badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: _trendColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _trendLabel,
              style: TextStyle(
                color: _trendColor,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Stats row
          Row(
            children: [
              Expanded(
                child: _StatBadge(
                  label: 'AVERAGE',
                  value: avgScore.toStringAsFixed(1),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatBadge(
                  label: 'TOTAL',
                  value: '$totalDiagnoses',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  const _StatBadge({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: _basis,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: _accent,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFFF2F2F2),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Progress Chart
// ─────────────────────────────────────────────────────────────────────────────

class _ProgressChartCard extends StatelessWidget {
  const _ProgressChartCard({required this.history});
  final List<dynamic> history;

  @override
  Widget build(BuildContext context) {
    // Take last 7 entries reversed (oldest→newest)
    final entries = history.take(7).toList().reversed.toList();
    final scores = entries.map((e) {
      if (e is Map<String, dynamic>) {
        final raw = e['addiction_level'] ??
            e['addiction_score'] ??
            e['score'] ??
            0;
        if (raw is num) return raw.toDouble().clamp(0.0, 10.0);
      }
      return 0.0;
    }).toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PROGRESS OVERVIEW',
            style: TextStyle(
              color: _softText,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: CustomPaint(
              size: Size.infinite,
              painter: _ChartPainter(scores: scores),
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Oldest',
                style: TextStyle(
                  color: _softText,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Latest',
                style: TextStyle(
                  color: _softText,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  const _ChartPainter({required this.scores});
  final List<double> scores;

  @override
  void paint(Canvas canvas, Size size) {
    if (scores.isEmpty) return;

    final linePaint = Paint()
      ..color = _basis
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = _basis
      ..style = PaintingStyle.fill;

    final fillPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0x33042F40), Color(0x00042F40)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final gridPaint = Paint()
      ..color = const Color(0x15042F40)
      ..strokeWidth = 0.5;

    // Draw grid lines
    for (var i = 0; i <= 4; i++) {
      final y = size.height * (i / 4);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final path = Path();
    final fillPath = Path();
    final step =
        scores.length > 1 ? size.width / (scores.length - 1) : size.width;

    for (var i = 0; i < scores.length; i++) {
      final x = scores.length > 1 ? i * step : size.width / 2;
      final y = size.height - (scores[i] / 10) * size.height;
      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    // Fill
    final lastX =
        scores.length > 1 ? (scores.length - 1) * step : size.width / 2;
    fillPath.lineTo(lastX, size.height);
    fillPath.close();
    canvas.drawPath(fillPath, fillPaint);

    // Line
    canvas.drawPath(path, linePaint);

    // Dots
    for (var i = 0; i < scores.length; i++) {
      final x = scores.length > 1 ? i * step : size.width / 2;
      final y = size.height - (scores[i] / 10) * size.height;
      canvas.drawCircle(Offset(x, y), 4, dotPaint);
      canvas.drawCircle(
        Offset(x, y),
        2.5,
        Paint()..color = Colors.white,
      );
    }
  }

  @override
  bool shouldRepaint(_ChartPainter old) => true;
}

// ─────────────────────────────────────────────────────────────────────────────
// History Tile
// ─────────────────────────────────────────────────────────────────────────────

class _DiagnosisHistoryTile extends StatelessWidget {
  const _DiagnosisHistoryTile({
    required this.index,
    required this.score,
    required this.date,
    required this.stage,
  });

  final int index;
  final double score;
  final String date;
  final String stage;

  Color get _levelColor {
    if (score <= 4) return _green;
    if (score <= 7) return _yellow;
    return _red;
  }

  String get _levelLabel {
    if (score <= 4) return 'Low';
    if (score <= 7) return 'Medium';
    return 'High';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: _levelColor, width: 4),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Score circle
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _levelColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              score.toStringAsFixed(1),
              style: TextStyle(
                color: _levelColor,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Diagnosis #$index',
                  style: const TextStyle(
                    color: _basis,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  stage.isNotEmpty ? '$date · $stage' : date,
                  style: const TextStyle(
                    color: _softText,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _levelColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _levelLabel,
              style: TextStyle(
                color: _levelColor,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Empty State
// ─────────────────────────────────────────────────────────────────────────────

class _EmptyStateCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        children: [
          Icon(Icons.analytics_outlined, size: 56, color: _softText),
          SizedBox(height: 16),
          Text(
            'No diagnoses yet',
            style: TextStyle(
              color: _basis,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Complete a questionnaire to get\nyour first diagnosis result.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _softText,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Re-Diagnose Button
// ─────────────────────────────────────────────────────────────────────────────

class _ReDiagnoseButton extends StatelessWidget {
  const _ReDiagnoseButton({required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 54,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _basis,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40042F40),
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.refresh_rounded, color: Colors.white, size: 22),
            SizedBox(width: 10),
            Text(
              'Re-Diagnose',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Error Content
// ─────────────────────────────────────────────────────────────────────────────

class _ErrorContent extends StatelessWidget {
  const _ErrorContent({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 56,
              color: _softText,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: _basis,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: _basis,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              ),
              child: const Text(
                'Try Again',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Score Ring Painter
// ─────────────────────────────────────────────────────────────────────────────

class _ScoreRingPainter extends CustomPainter {
  const _ScoreRingPainter({required this.value});
  final double value; // 0.0 – 1.0

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;
    const strokeWidth = 12.0;

    // Track
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = const Color(0xFFD7E4EA)
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );

    // Progress arc
    final sweepAngle = 2 * math.pi * value.clamp(0.0, 1.0);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      Paint()
        ..shader = const SweepGradient(
          startAngle: -math.pi / 2,
          endAngle: 3 * math.pi / 2,
          colors: [
            Color(0xFF042F40),
            Color(0xFF91B8CA),
            Color(0xFFC8EFFF),
          ],
        ).createShader(Rect.fromCircle(center: center, radius: radius))
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_ScoreRingPainter old) => old.value != value;
}

// ─────────────────────────────────────────────────────────────────────────────
// Bottom Navigation Bar
// ─────────────────────────────────────────────────────────────────────────────

class _DiagnosisBottomNavBar extends StatelessWidget {
  const _DiagnosisBottomNavBar({
    this.onHomeTap,
    this.onGamesTap,
    this.onTimerTap,
  });

  final VoidCallback? onHomeTap;
  final VoidCallback? onGamesTap;
  final VoidCallback? onTimerTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SizedBox(
        height: 96 + 48,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: Container(
                color: _pageBg,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 96,
                decoration: const BoxDecoration(
                  color: _basis,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(48)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x66000000),
                      blurRadius: 16,
                      offset: Offset(0, -12),
                    ),
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(32, 18, 32, 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 64),
                    // Games icon
                    GestureDetector(
                      onTap: onGamesTap,
                      child: const SizedBox(
                        width: 48,
                        height: 48,
                        child: Center(
                          child: Icon(
                            Icons.sports_esports_outlined,
                            color: Color(0xFFF2F2F2),
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                    // Timer icon
                    GestureDetector(
                      onTap: onTimerTap,
                      child: const SizedBox(
                        width: 48,
                        height: 48,
                        child: Center(
                          child: Icon(
                            Icons.timer_outlined,
                            color: Color(0xFFF2F2F2),
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                    // Diagnosis icon (active on this screen)
                    const SizedBox(
                      width: 48,
                      height: 48,
                      child: Center(
                        child: Icon(
                          Icons.analytics_outlined,
                          color: _accent,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Home button (floating, top-left)
            Positioned(
              left: 32,
              top: 0,
              child: GestureDetector(
                onTap: onHomeTap,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: _pageBg,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x1A000000),
                        blurRadius: 16,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.home_outlined,
                    color: _basis,
                    size: 28,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
