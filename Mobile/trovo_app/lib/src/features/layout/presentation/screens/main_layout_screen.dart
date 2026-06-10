import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../home/presentation/home_screen.dart';
import '../../../time_focus/presentation/time_focus_screen.dart';
import '../widgets/app_bottom_nav_bar.dart';
import 'games_list_screen.dart';

const Color _kBg = Color(0xFFF2F2F2);
const Color _kBasis = Color(0xFF042F40);

/// The main app shell: hosts the primary destinations behind a single
/// shared bottom navigation bar.
class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key, this.initialIndex = 1});

  /// Defaults to the Games tab, matching the design.
  final int initialIndex;

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  late int _index = widget.initialIndex;

  static const List<AppNavDestination> _destinations = [
    AppNavDestination(
      iconAsset: 'assets/images/home_icon_home.svg',
      label: 'Home',
    ),
    AppNavDestination(
      iconAsset: 'assets/images/home_icon_games.svg',
      label: 'Games',
    ),
    AppNavDestination(
      iconAsset: 'assets/images/home_icon_timer.svg',
      label: 'Timer',
    ),
    AppNavDestination(
      iconAsset: 'assets/images/home_icon_library.svg',
      label: 'Library',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: Stack(
        children: [
          Positioned.fill(
            child: IndexedStack(
              index: _index,
              children: const [
                HomeScreen(embedded: true),
                GamesListScreen(),
                TimeFocusScreen(embedded: true),
                _LibraryTab(),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AppBottomNavBar(
              currentIndex: _index,
              destinations: _destinations,
              onTap: (i) => setState(() => _index = i),
            ),
          ),
        ],
      ),
    );
  }
}

class _LibraryTab extends StatelessWidget {
  const _LibraryTab();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                color: Color(0xFFC8EFFF),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.menu_book_rounded,
                color: _kBasis,
                size: 32,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Library',
              style: GoogleFonts.nunito(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: _kBasis,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your insights & resources are coming soon.',
              style: GoogleFonts.nunito(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0x99042F40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
