import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../memory_sequence/presentation/screens/memory_sequence_screen.dart';
import '../../stroop/presentation/screens/stroop_screen.dart';
import '../../diagnosis/presentation/screens/diagnosis_history_screen.dart';
import 'home_screen.dart';

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

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  static const Color pageBg = Color(0xFFF2F2F2);
  static const Color basis = Color(0xFF042F40);
  static const Color cardBorder = Color(0xFFC8EFFF);
  static const Color softText = Color(0x99042F40);

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
      backgroundColor: pageBg,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(16, 16, 16, bottomPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Hero card — "The Digital Antidote"
                  const _HeroCard(),
                  const SizedBox(height: 32),
                  // Game cards list
                  _GameCard(
                    leadingWidget: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        width: 36,
                        height: 36,
                        color: cardBorder,
                        alignment: Alignment.center,
                        child: const Icon(Icons.tag, size: 20, color: basis),
                      ),
                    ),
                    title: 'Number & Letter Challenge',
                    description:
                        'Train your brain by quickly switching between numbers and letters decisions.',
                    onTap: null, // NumberLetterScreen coming soon
                  ),
                  const SizedBox(height: 32),
                  _GameCard(
                    leadingWidget: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: cardBorder,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      alignment: Alignment.center,
                      child: const Text('🧠', style: TextStyle(fontSize: 18)),
                    ),
                    title: 'Attention Span & deTest',
                    description:
                        'Test your focus by reacting only to specific letters while ignoring distractions.',
                    onTap: null,
                  ),
                  const SizedBox(height: 32),
                  _GameCard(
                    leadingWidget: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: cardBorder,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      alignment: Alignment.center,
                      child: const Text('🎮', style: TextStyle(fontSize: 18)),
                    ),
                    title: 'Memory Sequence',
                    description:
                        'Remember and repeat the correct sequence to improve working memory.',
                    onTap: () {
                      Navigator.of(
                        context,
                      ).push(_fadeRoute(const MemorySequenceScreen()));
                    },
                  ),
                  const SizedBox(height: 32),
                  _GameCard(
                    leadingWidget: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: cardBorder,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      alignment: Alignment.center,
                      child: const Text('🔥', style: TextStyle(fontSize: 18)),
                    ),
                    title: 'Stroop Test',
                    description:
                        'Train your brain by quickly switching between numbers and letters decisions.',
                    onTap: () {
                      Navigator.of(
                        context,
                      ).push(_fadeRoute(const StroopScreen()));
                    },
                  ),
                ],
              ),
            ),
            // Bottom Navigation Bar
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _LayoutBottomNavBar(
                onHomeTap: () {
                  Navigator.of(
                    context,
                  ).pushReplacement(_fadeRoute(const HomeScreen()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Hero Card ─────────────────────────────────────────────────────────────

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Color(0xFFF0F8FF)],
          stops: [0.0, 1.0],
        ),
        border: Border.all(color: const Color(0xFF94A5AD), width: 1),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'The Digital Antidote ',
            style: GoogleFonts.nunito(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF042F40),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'Advanced cognitive exercises designed to rewire your brain for focus and clarity.',
            style: GoogleFonts.nunito(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: const Color(0x99000000),
              height: 1.5,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}

// ─── Game Card ──────────────────────────────────────────────────────────────

class _GameCard extends StatelessWidget {
  const _GameCard({
    required this.leadingWidget,
    required this.title,
    required this.description,
    this.onTap,
  });

  final Widget leadingWidget;
  final String title;
  final String description;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFC8EFFF), width: 1),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0x4D000000),
              blurRadius: 5,
              offset: Offset(2, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                leadingWidget,
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF042F40),
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: GoogleFonts.nunito(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: const Color(0x99000000),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Bottom Navigation Bar ───────────────────────────────────────────────────

class _LayoutBottomNavBar extends StatelessWidget {
  const _LayoutBottomNavBar({this.onHomeTap});

  final VoidCallback? onHomeTap;

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
                color: const Color(0xFFF2F2F2),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 96,
                decoration: const BoxDecoration(
                  color: Color(0xFF042F40),
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
                    // Home placeholder (left)
                    const SizedBox(width: 64),
                    // Games icon (active — this screen)
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: Center(
                        child: Icon(
                          Icons.sports_esports_outlined,
                          color: const Color(0xFFC8EFFF),
                          size: 28,
                        ),
                      ),
                    ),
                    // Timer icon
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: Center(
                        child: Icon(
                          Icons.timer_outlined,
                          color: const Color(0xFFF2F2F2),
                          size: 28,
                        ),
                      ),
                    ),
                    // Diagnosis icon
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(_fadeRoute(
                          const DiagnosisHistoryScreen(),
                        ));
                      },
                      child: const SizedBox(
                        width: 48,
                        height: 48,
                        child: Center(
                          child: Icon(
                            Icons.analytics_outlined,
                            color: Color(0xFFF2F2F2),
                            size: 28,
                          ),
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
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F2),
                    shape: BoxShape.circle,
                    boxShadow: const [
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
                    color: Color(0xFF042F40),
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
