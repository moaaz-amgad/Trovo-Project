import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../attention_span/presentation/screens/attention_span_screen.dart';
import '../../../memory_sequence/presentation/screens/memory_sequence_screen.dart';
import '../../../number_letter/presentation/screens/nl_screen.dart';
import '../../../stroop/presentation/screens/stroop_screen.dart';

const Color _kBasis = Color(0xFF042F40);
const Color _kCardBorder = Color(0xFFC8EFFF);
const Color _kIconBg = Color(0xFFCDEBFA);
const Color _kSoftText = Color(0x99000000);

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

/// The "Digital Antidote" games catalogue — the Games tab of the app shell.
class GamesListScreen extends StatelessWidget {
  const GamesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double bottomPadding =
        140 + MediaQuery.viewPaddingOf(context).bottom;

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16, 16, 16, bottomPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _HeroCard(),
            const SizedBox(height: 24),
            _GameCard(
              icon: const Icon(
                Icons.emoji_events_rounded,
                color: Color(0xFFF5A623),
                size: 22,
              ),
              title: 'Number & Letter Challenge',
              description:
                  'Train your brain by quickly switching between numbers '
                  'and letters decisions.',
              onTap: () =>
                  Navigator.of(context).push(_fadeRoute(const NlScreen())),
            ),
            const SizedBox(height: 16),
            _GameCard(
              icon: const Text('🧠', style: TextStyle(fontSize: 18)),
              title: 'Attention Span & deTest',
              description:
                  'Test your focus by reacting only to specific letters '
                  'while ignoring distractions.',
              onTap: () => Navigator.of(
                context,
              ).push(_fadeRoute(const AttentionSpanScreen())),
            ),
            const SizedBox(height: 16),
            _GameCard(
              icon: const Text('🎮', style: TextStyle(fontSize: 18)),
              title: 'Memory Sequence',
              description:
                  'Remember and repeat the correct sequence to improve '
                  'working memory.',
              onTap: () => Navigator.of(
                context,
              ).push(_fadeRoute(const MemorySequenceScreen())),
            ),
            const SizedBox(height: 16),
            _GameCard(
              icon: const Text('🔥', style: TextStyle(fontSize: 18)),
              title: 'Stroop Test',
              description:
                  'Train your brain by quickly switching between numbers '
                  'and letters decisions.',
              onTap: () =>
                  Navigator.of(context).push(_fadeRoute(const StroopScreen())),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Color(0xFFF0F8FF)],
        ),
        border: Border.all(color: const Color(0xFFC8EFFF)),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'The Digital Antidote',
              style: GoogleFonts.nunito(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: _kBasis,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Advanced cognitive exercises designed to rewire your brain '
            'for focus and clarity.',
            style: GoogleFonts.nunito(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _kSoftText,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _GameCard extends StatelessWidget {
  const _GameCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final Widget icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: _kCardBorder),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1F000000),
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: _kIconBg,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: icon,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: _kBasis,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: GoogleFonts.nunito(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _kSoftText,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
