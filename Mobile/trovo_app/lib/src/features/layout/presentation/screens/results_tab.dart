import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/di/injection_container.dart';
import '../../../diagnosis/presentation/cubit/diagnosis_cubit.dart';
import '../../../diagnosis/presentation/screens/diagnosis_result_screen.dart';
import '../../../progress/data/models/progress_summary.dart';
import '../../../progress/presentation/cubit/progress_cubit.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Palette (consistent with app)
// ─────────────────────────────────────────────────────────────────────────────

const Color _kBg = Color(0xFFF2F2F2);
const Color _kBasis = Color(0xFF042F40);
const Color _kSoft = Color(0x99042F40);
const Color _kAccent = Color(0xFFC8EFFF);
const Color _kGreen = Color(0xFF7EC8A0);
const Color _kRed = Color(0xFFE57373);
const Color _kCardWhite = Colors.white;

/// The "Results" tab that replaces the old Library tab.
/// Shows the latest diagnosis, historical stats, and a "Retake" button.
class ResultsTab extends StatelessWidget {
  const ResultsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProgressCubit>(
          create: (_) => sl<ProgressCubit>()..load(),
        ),
        BlocProvider<DiagnosisCubit>(
          create: (_) => sl<DiagnosisCubit>()..fetchHistory(),
        ),
      ],
      child: const _ResultsBody(),
    );
  }
}

class _ResultsBody extends StatelessWidget {
  const _ResultsBody();

  @override
  Widget build(BuildContext context) {
    final bottomPadding = 120.0 + MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: _kBg,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: BlocBuilder<ProgressCubit, ProgressState>(
              builder: (context, progressState) {
                return BlocBuilder<DiagnosisCubit, DiagnosisState>(
                  builder: (context, diagState) {
                    return RefreshIndicator(
                      color: _kBasis,
                      onRefresh: () async {
                        context.read<ProgressCubit>().load();
                        context.read<DiagnosisCubit>().fetchHistory();
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        padding: EdgeInsets.fromLTRB(16, 20, 16, bottomPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeader(),
                            const SizedBox(height: 24),
                            _buildLatestResult(progressState),
                            const SizedBox(height: 16),
                            _buildStatsRow(progressState),
                            const SizedBox(height: 16),
                            _buildRetakeButton(context),
                            const SizedBox(height: 24),
                            _buildHistorySection(progressState, diagState),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(
            color: _kBasis,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.bar_chart_rounded,
            color: _kAccent,
            size: 22,
          ),
        ),
        const SizedBox(width: 14),
        Text(
          'Your Results',
          style: GoogleFonts.nunito(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: _kBasis,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildLatestResult(ProgressState progressState) {
    final summary = progressState.maybeWhen(
      loaded: (s, _) => s,
      orElse: () => null,
    );

    final level = summary?.currentLevel?.toDouble() ?? 0;
    final stage = summary?.currentStage ?? 'Unknown';
    final trend = summary?.currentTrend ?? 'unknown';
    final hasDiagnosis = summary != null && summary.totalDiagnoses > 0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _kCardWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x15000000),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: hasDiagnosis
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'LATEST DIAGNOSIS',
                      style: GoogleFonts.nunito(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: _kSoft,
                        letterSpacing: 1,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: trend == 'improving'
                            ? _kGreen.withOpacity(0.15)
                            : trend == 'worsening'
                                ? _kRed.withOpacity(0.15)
                                : _kAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        trend == 'improving'
                            ? '↓ Improving'
                            : trend == 'worsening'
                                ? '↑ Worsening'
                                : '→ Stable',
                        style: GoogleFonts.nunito(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: trend == 'improving'
                              ? _kGreen
                              : trend == 'worsening'
                                  ? _kRed
                                  : _kBasis,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: _AdictionGauge(
                    value: level.clamp(0, 10),
                    stage: stage,
                  ),
                ),
              ],
            )
          : Column(
              children: [
                const Icon(
                  Icons.analytics_outlined,
                  size: 48,
                  color: _kSoft,
                ),
                const SizedBox(height: 12),
                Text(
                  'No Diagnosis Yet',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: _kBasis,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Complete a diagnosis to see your results here.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: _kSoft,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildStatsRow(ProgressState progressState) {
    final summary = progressState.maybeWhen(
      loaded: (s, _) => s,
      orElse: () => null,
    );

    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.assignment_turned_in_rounded,
            label: 'Total',
            value: '${summary?.totalDiagnoses ?? 0}',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _StatCard(
            icon: Icons.local_fire_department_rounded,
            label: 'Streak',
            value: '${summary?.streakDays ?? 0}d',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _StatCard(
            icon: Icons.trending_up_rounded,
            label: 'Change',
            value: _formatChange(summary?.overallChange),
          ),
        ),
      ],
    );
  }

  String _formatChange(num? change) {
    if (change == null) return '--';
    final sign = change > 0 ? '+' : '';
    return '$sign${change.toStringAsFixed(1)}';
  }

  Widget _buildRetakeButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const DiagnosisResultScreen(),
            ),
          );
        },
        icon: const Icon(Icons.refresh_rounded, size: 20),
        label: Text(
          'Retake Diagnosis',
          style: GoogleFonts.nunito(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: _kBasis,
          foregroundColor: _kAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 4,
          shadowColor: _kBasis.withOpacity(0.3),
        ),
      ),
    );
  }

  Widget _buildHistorySection(
    ProgressState progressState,
    DiagnosisState diagState,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DIAGNOSIS HISTORY',
          style: GoogleFonts.nunito(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: _kSoft,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        _buildHistoryList(progressState),
      ],
    );
  }

  Widget _buildHistoryList(ProgressState progressState) {
    return progressState.maybeWhen(
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(color: _kBasis),
        ),
      ),
      error: (msg) => Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            msg,
            style: GoogleFonts.nunito(color: _kSoft, fontSize: 14),
          ),
        ),
      ),
      loaded: (summary, history) {
        if (history.isEmpty) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: _kCardWhite,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'No history available yet.\nComplete your first diagnosis to start tracking.',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _kSoft,
                ),
              ),
            ),
          );
        }

        return Column(
          children: [
            for (var i = 0; i < history.length; i++) ...[
              _HistoryCard(
                index: i + 1,
                score: history[i].score?.toDouble() ?? 0,
                date: history[i].date ?? '',
                label: history[i].label ?? 'Diagnosis',
              ),
              if (i < history.length - 1) const SizedBox(height: 8),
            ],
          ],
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Addiction Gauge Widget
// ─────────────────────────────────────────────────────────────────────────────

class _AdictionGauge extends StatelessWidget {
  const _AdictionGauge({required this.value, required this.stage});

  final double value;
  final String stage;

  @override
  Widget build(BuildContext context) {
    final pct = (value / 10).clamp(0.0, 1.0);
    final color = pct <= 0.4
        ? _kGreen
        : pct <= 0.7
            ? const Color(0xFFFFA726)
            : _kRed;

    return Column(
      children: [
        SizedBox(
          width: 160,
          height: 160,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 160,
                height: 160,
                child: CircularProgressIndicator(
                  value: pct,
                  strokeWidth: 12,
                  backgroundColor: const Color(0xFFE8EEF2),
                  color: color,
                  strokeCap: StrokeCap.round,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    value.toStringAsFixed(1),
                    style: GoogleFonts.nunito(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: _kBasis,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '/ 10',
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _kSoft,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            stage.isNotEmpty ? stage : 'Unknown Stage',
            style: GoogleFonts.nunito(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Stat Card
// ─────────────────────────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: _kCardWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: _kBasis, size: 22),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.nunito(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: _kBasis,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.nunito(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: _kSoft,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// History Card
// ─────────────────────────────────────────────────────────────────────────────

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({
    required this.index,
    required this.score,
    required this.date,
    required this.label,
  });

  final int index;
  final double score;
  final String date;
  final String label;

  @override
  Widget build(BuildContext context) {
    final color = score <= 4
        ? _kGreen
        : score <= 7
            ? const Color(0xFFFFA726)
            : _kRed;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCardWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '#$index',
              style: GoogleFonts.nunito(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _kBasis,
                  ),
                ),
                if (date.isNotEmpty)
                  Text(
                    _formatDate(date),
                    style: GoogleFonts.nunito(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: _kSoft,
                    ),
                  ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              score.toStringAsFixed(1),
              style: GoogleFonts.nunito(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String raw) {
    try {
      final dt = DateTime.parse(raw);
      final months = [
        '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
      ];
      return '${months[dt.month]} ${dt.day}, ${dt.year}';
    } catch (_) {
      return raw;
    }
  }
}
