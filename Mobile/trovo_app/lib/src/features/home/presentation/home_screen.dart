import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/di/injection_container.dart';
import '../../profile/presentation/screens/profile_screen.dart';
import '../../time_focus/presentation/time_focus_screen.dart';
import '../../mini_game/presentation/cubit/mini_game_cubit.dart';
import '../../progress/presentation/cubit/progress_cubit.dart';
import '../../user/presentation/cubit/user_cubit.dart';
import 'layout_screen.dart';

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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.embedded = false});

  /// When hosted inside the app shell, the screen hides its own bottom
  /// navigation bar so the shell's shared nav is used instead.
  final bool embedded;

  static const Color pageBg = Color(0xFFF2F2F2);
  static const Color basis = Color(0xFF042F40);
  static const Color softText = Color(0x99042F40);
  static const Color cardWhite = Color(0xFFF3F4F5);
  static const double bottomNavHeight = 96;
  static const double bottomNavTopOverlap = 48;

  @override
  Widget build(BuildContext context) {
    final double bottomPadding =
        24 +
        bottomNavHeight +
        bottomNavTopOverlap +
        MediaQuery.of(context).padding.bottom;

    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
          create: (_) => sl<UserCubit>()..loadProfile(),
        ),
        BlocProvider<ProgressCubit>(
          create: (_) => sl<ProgressCubit>()..load(),
        ),
        BlocProvider<MiniGameCubit>(
          create: (_) => sl<MiniGameCubit>()..loadStats(),
        ),
      ],
      child: _HomeBody(bottomPadding: bottomPadding, embedded: embedded),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({required this.bottomPadding, required this.embedded});

  final double bottomPadding;
  final bool embedded;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomeScreen.pageBg,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 430),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(16, 14, 16, bottomPadding),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _HomeHeader(),
                      SizedBox(height: 32),
                      _InsightCard(),
                      SizedBox(height: 26),
                      _FocusScoreCard(),
                      SizedBox(height: 24),
                      _BentoGrid(),
                      SizedBox(height: 24),
                      _SessionPerformanceCard(),
                      SizedBox(height: 24),
                      _MentalLoadCard(),
                    ],
                  ),
                ),
              ),
            ),
            if (!embedded)
              const Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _BottomNavigationBar(),
              ),
          ],
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final profile = state.maybeWhen(
          loaded: (p) => p,
          actionInProgress: (p) => p,
          actionSuccess: (p, _) => p,
          orElse: () => null,
        );
        final name = profile?.fullName?.split(' ').first;
        final avatarUrl = profile?.avatar;

        return Row(
          children: [
            GestureDetector(
              onTap: () =>
                  Navigator.of(context).push(_fadeRoute(const ProfileScreen())),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFFB5C8D1),
                backgroundImage:
                    avatarUrl != null ? NetworkImage(avatarUrl) : null,
                child: avatarUrl == null
                    ? const Icon(
                        Icons.person,
                        size: 22,
                        color: HomeScreen.basis,
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                name != null ? '$_greeting, $name' : _greeting,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: HomeScreen.basis,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  height: 1.17,
                  letterSpacing: -0.2,
                ),
              ),
            ),
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Color(0xFFC3CBCF),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: SizedBox(
            width: 16,
            height: 20,
            child: SvgPicture.asset(
              'assets/images/home_icon_bell.svg',
              colorFilter: const ColorFilter.mode(
                HomeScreen.basis,
                BlendMode.srcIn,
              ),
            ),
          ),
          ),
          ],
        );
      },
    );
  }
}

class _InsightCard extends StatelessWidget {
  const _InsightCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: HomeScreen.cardWhite,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            top: 18,
            bottom: 18,
            child: Container(
              width: 4,
              decoration: BoxDecoration(
                color: const Color(0x73042F40),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(92, 20, 24, 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Mindful Insight',
                  style: TextStyle(
                    color: HomeScreen.basis,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                    letterSpacing: -0.15,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '"The best way to sharpen your\nfocus is to embrace the silence\nbetween tasks. Take 3 deep\nbreaths before starting your next\nsession."',
                  style: TextStyle(
                    color: Color(0xFF41484B),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.62,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 22,
            top: 42,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFDCE5EA),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: SizedBox(
                width: 18,
                height: 18,
                child: SvgPicture.asset(
                  'assets/images/home_icon_bulb.svg',
                  colorFilter: const ColorFilter.mode(
                    HomeScreen.basis,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FocusScoreCard extends StatelessWidget {
  const _FocusScoreCard();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProgressCubit, ProgressState>(
      builder: (context, state) {
        final summary = state.maybeWhen(
          loaded: (s, _) => s,
          orElse: () => null,
        );

        final focusScore = summary?.overallScore?.toInt() ?? 0;
        final isOptimal = focusScore >= 80;
        final scoreLabel = isOptimal ? 'OPTIMAL' : (focusScore > 0 ? 'AVERAGE' : 'NO DATA');
        final streak = summary?.streak ?? 0;
        final sessions = summary?.totalSessions ?? 0;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Color(0x40000000),
                blurRadius: 50,
                offset: Offset(0, 25),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CURRENT STATE',
                        style: TextStyle(
                          color: Color(0x9902161F),
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Focus Score',
                        style: TextStyle(
                          color: HomeScreen.basis,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          height: 1.33,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),
                  if (focusScore > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC8EFFF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'ACTIVE',
                        style: TextStyle(
                          color: Color(0xFF042F3E),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          height: 1.33,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 192,
                  height: 192,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(
                        size: const Size(192, 192),
                        painter: _GradientRingPainter(
                          trackColor: const Color(0xFFD7E4EA),
                          gradientColors: const [
                            Color(0xFF042F40),
                            Color(0xFF91B8CA),
                            Color(0xFFC8EFFF),
                          ],
                          strokeWidth: 14,
                          value: focusScore > 0 ? (focusScore / 100).clamp(0.0, 1.0) : 0,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '$focusScore',
                            style: const TextStyle(
                              color: HomeScreen.basis,
                              fontSize: 48,
                              fontWeight: FontWeight.w800,
                              height: 1,
                              letterSpacing: -2.4,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            scoreLabel,
                            style: const TextStyle(
                              color: Color(0x99042F40),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: 1.33,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _MetricBadge(
                      label: 'STREAK',
                      value: '$streak',
                      backgroundColor: HomeScreen.basis,
                      valueColor: const Color(0xFFF2F2F2),
                      labelColor: const Color(0xFFC8EFFF),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _MetricBadge(
                      label: 'SESSIONS',
                      value: '$sessions',
                      backgroundColor: HomeScreen.basis,
                      valueColor: const Color(0xFFF2F2F2),
                      labelColor: const Color(0xFFC8EFFF),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MetricBadge extends StatelessWidget {
  const _MetricBadge({
    required this.label,
    required this.value,
    required this.backgroundColor,
    required this.valueColor,
    required this.labelColor,
  });

  final String label;
  final String value;
  final Color backgroundColor;
  final Color valueColor;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              color: labelColor,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              height: 1.2,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Bento Grid ─────────────────────────────────────────────────────────────

class _BentoGrid extends StatelessWidget {
  const _BentoGrid();

  static const Color _basis = HomeScreen.basis;
  static const Color _accent = Color(0xFFC8EFFF);
  static const Color _greenish = Color(0xFF7EC8A0);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MiniGameCubit, MiniGameDashboardState>(
      builder: (context, state) {
        final stats = state.maybeWhen(
          loaded: (d, s, _) => s,
          orElse: () => null,
        );

        final reactionMs = stats?.averageReactionTimeMs?.toInt() ?? 0;
        final accuracy = stats?.averageAccuracy?.toInt() ?? 0;
        final bestScore = stats?.bestScore?.toInt() ?? 0;
        final totalGames = stats?.totalSessions ?? 0;

        // Mastery level based on total games
        final masteryLevel = totalGames >= 50
            ? 10
            : totalGames >= 30
                ? 8
                : totalGames >= 15
                    ? 5
                    : totalGames >= 5
                        ? 3
                        : 1;
        final masteryLabel = masteryLevel >= 8
            ? 'ELITE'
            : masteryLevel >= 5
                ? 'ADVANCED'
                : 'BEGINNER';

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left column
            Expanded(
              child: Column(
                children: [
                  _BentoCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _bentoCategoryRow(Icons.flash_on_rounded, 'REACTION'),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '$reactionMs',
                              style: GoogleFonts.nunito(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: _basis,
                                height: 1,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Text(
                                'ms',
                                style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: _basis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          reactionMs > 0 && reactionMs < 300 ? 'FAST' : (reactionMs > 0 ? 'NORMAL' : 'NO DATA'),
                          style: GoogleFonts.nunito(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: _greenish,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  _BentoCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _bentoCategoryRow(Icons.star_rounded, 'MASTERY LEVEL'),
                        const SizedBox(height: 12),
                        Text(
                          'LVL $masteryLevel',
                          style: GoogleFonts.nunito(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: _basis,
                            height: 1,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _accent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            masteryLabel,
                            style: GoogleFonts.nunito(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF042F3E),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Right column
            Expanded(
              child: Column(
                children: [
                  _BentoCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _bentoCategoryRow(Icons.repeat_rounded, 'ACCURACY'),
                        const SizedBox(height: 12),
                        Text(
                          '$accuracy%',
                          style: GoogleFonts.nunito(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: _greenish,
                            height: 1,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _MiniBarChart(
                          bars: [
                            accuracy > 0 ? (accuracy / 100).clamp(0.0, 1.0) : 0.1,
                            0.55,
                            0.45,
                            0.7,
                            accuracy > 0 ? (accuracy / 100).clamp(0.0, 1.0) : 0.1,
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  _BentoCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _bentoCategoryRow(
                          Icons.emoji_events_rounded,
                          'BEST SCORE',
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '$bestScore',
                              style: GoogleFonts.nunito(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: _basis,
                                height: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Text(
                                ' pts',
                                style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: _basis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '$totalGames games',
                          style: GoogleFonts.nunito(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: _greenish,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  static Widget _bentoCategoryRow(IconData icon, String label) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: const Color(0xFF042F40),
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 12, color: const Color(0xFFC8EFFF)),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.nunito(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: HomeScreen.basis,
              letterSpacing: 0.5,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _BentoCard extends StatelessWidget {
  const _BentoCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x20000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SessionPerformanceCard extends StatelessWidget {
  const _SessionPerformanceCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'SESSION PERFORMANCE',
            style: TextStyle(
              color: HomeScreen.softText,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              height: 1.5,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 16),
          _SessionRow(
            iconAsset: 'assets/images/home_icon_focus.svg',
            title: 'Deep Work Block',
            subtitle: 'Today • 10:30 AM',
            value: '+8.5',
            valueLabel: 'Score Impact',
          ),
          const SizedBox(height: 16),
          Container(height: 1, color: const Color(0x1A042F40)),
          const SizedBox(height: 16),
          _SessionRow(
            iconAsset: 'assets/images/home_icon_mastery.svg',
            title: 'Sprint Analysis',
            subtitle: 'Today • 2:15 PM',
            value: '+3.2',
            valueLabel: 'Score Impact',
          ),
        ],
      ),
    );
  }
}

class _SessionRow extends StatelessWidget {
  const _SessionRow({
    required this.iconAsset,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.valueLabel,
  });

  final String iconAsset;
  final String title;
  final String subtitle;
  final String value;
  final String valueLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: HomeScreen.basis,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: SizedBox(
                width: 18,
                height: 18,
                child: SvgPicture.asset(
                  iconAsset,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFFC8EFFF),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: HomeScreen.basis,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 1.43,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: HomeScreen.softText,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF040B40),
                fontSize: 14,
                fontWeight: FontWeight.w700,
                height: 1.43,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              valueLabel,
              style: const TextStyle(
                color: HomeScreen.softText,
                fontSize: 10,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MentalLoadCard extends StatelessWidget {
  const _MentalLoadCard();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProgressCubit, ProgressState>(
      builder: (context, state) {
        final summary = state.maybeWhen(
          loaded: (s, _) => s,
          orElse: () => null,
        );

        final addictionLevel = summary?.currentLevel?.toDouble() ?? 0;
        final trend = summary?.currentTrend ?? 'unknown';
        // Clamp between 0 and 100 for display
        final addictionPct = addictionLevel.clamp(0.0, 100.0);
        final addictionLabel = addictionPct <= 30
            ? 'Low'
            : addictionPct <= 60
                ? 'Mod'
                : 'High';

        final trendLabel = trend == 'improving'
            ? 'Improving ↓'
            : trend == 'worsening'
                ? 'Worsening ↑'
                : 'Stable →';

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'MENTAL LOAD INDICATORS',
                style: TextStyle(
                  color: HomeScreen.softText,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 20),
              _IndicatorRow(
                label: 'Addiction Score',
                value: '$addictionLabel (${addictionPct.toStringAsFixed(0)}%)',
                progress: addictionPct / 100,
              ),
              const SizedBox(height: 20),
              _IndicatorRow(
                label: 'Current Trend',
                value: trendLabel,
                progress: trend == 'improving'
                    ? 0.3
                    : trend == 'worsening'
                        ? 0.8
                        : 0.5,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _IndicatorRow extends StatelessWidget {
  const _IndicatorRow({
    required this.label,
    required this.value,
    required this.progress,
  });

  final String label;
  final String value;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: HomeScreen.basis,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                height: 1.33,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: HomeScreen.basis,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                height: 1.33,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: 8,
            child: Stack(
              children: [
                const Positioned.fill(
                  child: ColoredBox(color: Color(0x66042F40)),
                ),
                FractionallySizedBox(
                  widthFactor: progress.clamp(0.0, 1.0),
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF042F40), Color(0xFFC8EFFF)],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SizedBox(
        height: HomeScreen.bottomNavHeight + HomeScreen.bottomNavTopOverlap,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: HomeScreen.bottomNavHeight,
                decoration: const BoxDecoration(
                  color: HomeScreen.basis,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(48)),
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
                    const SizedBox(width: 64, height: 16),
                    _BottomNavItem(
                      iconAsset: 'assets/images/home_icon_games.svg',
                      onTap: () {
                        Navigator.of(
                          context,
                        ).pushReplacement(_fadeRoute(const LayoutScreen()));
                      },
                    ),
                    _BottomNavItem(
                      iconAsset: 'assets/images/home_icon_timer.svg',
                      onTap: () {
                        Navigator.of(
                          context,
                        ).pushReplacement(_fadeRoute(const TimeFocusScreen()));
                      },
                    ),
                    const _BottomNavItem(
                      iconAsset: 'assets/images/home_icon_library.svg',
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 32,
              top: 0,
              child: Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: HomeScreen.pageBg,
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
                child: SizedBox(
                  width: 20,
                  height: 23,
                  child: SvgPicture.asset(
                    'assets/images/home_icon_home.svg',
                    colorFilter: const ColorFilter.mode(
                      HomeScreen.basis,
                      BlendMode.srcIn,
                    ),
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

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({required this.iconAsset, this.onTap});

  final String iconAsset;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: InkResponse(
        onTap: onTap,
        radius: 28,
        child: Center(
          child: SvgPicture.asset(
            iconAsset,
            colorFilter: const ColorFilter.mode(
              Color(0xFFF2F2F2),
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}

class _MiniBarChart extends StatelessWidget {
  const _MiniBarChart({required this.bars});

  final List<double> bars;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (var i = 0; i < bars.length; i++) ...[
            if (i != 0) const SizedBox(width: 4),
            Expanded(
              child: FractionallySizedBox(
                heightFactor: bars[i].clamp(0.0, 1.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: i == bars.length - 1
                        ? HomeScreen.basis
                        : const Color(0xFFD7E4EA),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _GradientRingPainter extends CustomPainter {
  const _GradientRingPainter({
    required this.trackColor,
    required this.gradientColors,
    required this.strokeWidth,
    required this.value,
  });

  final Color trackColor;
  final List<Color> gradientColors;
  final double strokeWidth;
  final double value;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = (size.shortestSide - strokeWidth) / 2;
    final Rect rect = Rect.fromCircle(center: center, radius: radius);

    final Paint trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    final Paint progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        colors: gradientColors,
        stops: const [0.0, 0.75, 1.0],
        startAngle: -1.5707963267948966,
        endAngle: 4.71238898038469,
      ).createShader(rect);

    const double startAngle = -1.5707963267948966;
    final double sweepAngle = 6.283185307179586 * value.clamp(0.0, 1.0);
    canvas.drawArc(rect, startAngle, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant _GradientRingPainter oldDelegate) {
    return oldDelegate.trackColor != trackColor ||
        oldDelegate.gradientColors != gradientColors ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.value != value;
  }
}
