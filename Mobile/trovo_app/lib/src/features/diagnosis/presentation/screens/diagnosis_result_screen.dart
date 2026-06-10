import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:trovo_app/src/core/di/injection_container.dart';
import 'package:trovo_app/src/core/routing/app_router_paths.dart';
import '../cubit/diagnosis_cubit.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Domain helpers
// ─────────────────────────────────────────────────────────────────────────────

enum _Level { low, middle, high }

extension _LevelX on _Level {
  static _Level fromScore(int score) {
    if (score <= 4) return _Level.low;
    if (score <= 7) return _Level.middle;
    return _Level.high;
  }

  int get step => switch (this) {
    _Level.low => 1,
    _Level.middle => 2,
    _Level.high => 3,
  };

  String get levelLabel => switch (this) {
    _Level.low => 'You Are Low Level',
    _Level.middle => 'You Are Middle Level',
    _Level.high => 'You Are High Level',
  };

  String get slothAsset => switch (this) {
    _Level.low => 'assets/images/result_sloth.png',
    _Level.middle => 'assets/images/result_sloth_moderate.png',
    _Level.high => 'assets/images/result_sloth_severe.png',
  };

  Alignment get slothAlignment => switch (this) {
    _Level.low => Alignment.centerRight,
    _Level.middle => Alignment.centerLeft,
    _Level.high => Alignment.center,
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// Public entry-point
// ─────────────────────────────────────────────────────────────────────────────

class DiagnosisResultScreen extends StatelessWidget {
  const DiagnosisResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DiagnosisCubit>(
      create: (_) => sl<DiagnosisCubit>()..generateDiagnosis(),
      child: const _DiagnosisBody(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Body — state-driven
// ─────────────────────────────────────────────────────────────────────────────

class _DiagnosisBody extends StatelessWidget {
  const _DiagnosisBody();

  static double _extractScore(Map<String, dynamic>? data) {
    if (data == null) return 0.0;
    final raw = data['addiction_level'] ?? data['addiction_score'] ?? data['score'] ?? 0;
    if (raw is num) return raw.toDouble().clamp(0.0, 10.0);
    return 0.0;
  }

  static String _extractStage(Map<String, dynamic>? data) {
    if (data == null) return '';
    return data['brainrot_stage'] as String? ?? '';
  }

  static String _extractIntro(Map<String, dynamic>? data) {
    if (data == null) return '';
    return data['analysis_intro'] as String? ?? '';
  }

  static List<String> _extractFactors(Map<String, dynamic>? data) {
    if (data == null) return [];
    final factors = data['top_factors'];
    if (factors is List) return factors.map((e) => e.toString()).toList();
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiagnosisCubit, DiagnosisState>(
      builder: (context, state) {
        return state.when(
          initial: () => const _LoadingView(),
          loading: () => const _LoadingView(),
          generated: (data) => _ResultView(
            score: _extractScore(data.data),
            stage: _extractStage(data.data),
            intro: _extractIntro(data.data),
            factors: _extractFactors(data.data),
          ),
          history: (data) => _ResultView(
            score: _extractScore(data.data),
            stage: _extractStage(data.data),
            intro: _extractIntro(data.data),
            factors: _extractFactors(data.data),
          ),
          error: (message) => _ErrorView(
            message: message,
            onRetry: () => context.read<DiagnosisCubit>().generateDiagnosis(),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Loading
// ─────────────────────────────────────────────────────────────────────────────

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: Center(
        child: CircularProgressIndicator(color: Color(0xFF042F40)),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Error
// ─────────────────────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF042F40),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF042F40),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Try Again'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => context.go(AppRoutePaths.layoutScreen),
                child: const Text(
                  'Skip for now',
                  style: TextStyle(color: Color(0xFF888888)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Result
// ─────────────────────────────────────────────────────────────────────────────

class _ResultView extends StatelessWidget {
  const _ResultView({
    required this.score,
    required this.stage,
    required this.intro,
    required this.factors,
  });

  final double score;
  final String stage;
  final String intro;
  final List<String> factors;

  @override
  Widget build(BuildContext context) {
    final level = _LevelX.fromScore(score.toInt());
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 28),
                    const Text(
                      'Your Test Result',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF042F40),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Your Addiction Score',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF042F40),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _ScoreGauge(score: score),
                    const SizedBox(height: 18),
                    Text(
                      level.levelLabel,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF042F40),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _LevelIndicator(level: level),
                    const SizedBox(height: 28),
                    _InfoSection(
                      level: level,
                      stage: stage,
                      intro: intro,
                      factors: factors,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                24,
                0,
                24,
                MediaQuery.viewPaddingOf(context).bottom + 16,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 44,
                child: FilledButton(
                  onPressed: () => context.go(AppRoutePaths.phoneUsageScreen),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF042F40),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  child: const Text('Start Your Plan'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Score gauge
// ─────────────────────────────────────────────────────────────────────────────

class _ScoreGauge extends StatelessWidget {
  const _ScoreGauge({required this.score});

  final double score;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 130,
      child: CustomPaint(
        painter: _GaugePainter(),
        child: Center(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: score.toStringAsFixed(1),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                const TextSpan(
                  text: '/10',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerR = size.width / 2;
    final innerR = outerR * 0.70;

    canvas.drawCircle(
      center,
      outerR,
      Paint()..color = const Color(0xFF042F40),
    );

    const tickCount = 60;
    for (var i = 0; i < tickCount; i++) {
      final angle = (i / tickCount) * 2 * math.pi;
      final isMajor = i % 5 == 0;
      final tickLen = isMajor ? 8.0 : 4.5;
      final paint = Paint()
        ..color = Colors.white.withValues(alpha: isMajor ? 0.65 : 0.30)
        ..strokeWidth = isMajor ? 1.4 : 0.9
        ..strokeCap = StrokeCap.round;
      final outer = Offset(
        center.dx + (outerR - 1.5) * math.cos(angle),
        center.dy + (outerR - 1.5) * math.sin(angle),
      );
      final inner = Offset(
        center.dx + (outerR - 1.5 - tickLen) * math.cos(angle),
        center.dy + (outerR - 1.5 - tickLen) * math.sin(angle),
      );
      canvas.drawLine(inner, outer, paint);
    }

    canvas.drawCircle(
      center,
      innerR,
      Paint()..color = const Color(0xFF021A24),
    );

    canvas.drawCircle(
      center,
      innerR + 1,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.12)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
  }

  @override
  bool shouldRepaint(_GaugePainter old) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
// Level indicator
// ─────────────────────────────────────────────────────────────────────────────

class _LevelIndicator extends StatelessWidget {
  const _LevelIndicator({required this.level});

  final _Level level;

  static const _green = Color(0xFF28A745);
  static const _yellow = Color(0xFFFFC107);
  static const _red = Color(0xFFDC3545);
  static const _base = Color(0xFF042F40);

  @override
  Widget build(BuildContext context) {
    final step = level.step;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LevelNode(
          number: 1,
          label: 'Low',
          fillColor: _green,
          active: true,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Container(
              height: 2,
              color: step >= 2 ? _green : _base.withValues(alpha: 0.2),
            ),
          ),
        ),
        _LevelNode(
          number: 2,
          label: 'Middle',
          fillColor: _yellow,
          active: step >= 2,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Container(
              height: 2,
              color: step >= 3 ? _yellow : _base.withValues(alpha: 0.2),
            ),
          ),
        ),
        _LevelNode(
          number: 3,
          label: 'High',
          fillColor: _red,
          active: step >= 3,
        ),
      ],
    );
  }
}

class _LevelNode extends StatelessWidget {
  const _LevelNode({
    required this.number,
    required this.label,
    required this.fillColor,
    required this.active,
  });

  final int number;
  final String label;
  final Color fillColor;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: active
                ? fillColor
                : fillColor.withValues(alpha: 0.18),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$number',
              style: TextStyle(
                color: active
                    ? Colors.white
                    : const Color(0xFF042F40).withValues(alpha: 0.35),
                fontSize: 22,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            color: active
                ? fillColor
                : const Color(0xFF042F40).withValues(alpha: 0.25),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Info section  (sloth + card)
// ─────────────────────────────────────────────────────────────────────────────

class _InfoSection extends StatelessWidget {
  const _InfoSection({
    required this.level,
    required this.stage,
    required this.intro,
    required this.factors,
  });

  final _Level level;
  final String stage;
  final String intro;
  final List<String> factors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: level.slothAlignment,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Image.asset(
              level.slothAsset,
              height: 110,
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => const SizedBox.shrink(),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F5),
            borderRadius: BorderRadius.circular(32),
            border: const Border(
              left: BorderSide(color: Color(0x99042F40), width: 4),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(20, 16, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Stage: $stage',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF042F40),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$intro${factors.isNotEmpty ? '\n\nMain Factors:\n${factors.join(' · ')}' : ''}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF41484B),
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
