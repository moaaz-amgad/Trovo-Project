import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../home/presentation/home_screen.dart';
import '../../../mini_game/presentation/cubit/mini_game_cubit.dart';
import '../../../progress/presentation/cubit/progress_cubit.dart';
import '../../../time_focus/presentation/time_focus_screen.dart';
import '../widgets/app_bottom_nav_bar.dart';
import 'games_list_screen.dart';
import 'results_tab.dart';

const Color _kBg = Color(0xFFF2F2F2);
const Color _kBasis = Color(0xFF042F40);

/// The main app shell: hosts the primary destinations behind a single
/// shared bottom navigation bar.
class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key, this.initialIndex = 0});

  /// Defaults to the Home tab.
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
      iconAsset: 'assets/images/home_icon_results.svg',
      label: 'Progress',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MiniGameCubit>(
          create: (_) => sl<MiniGameCubit>()..loadStats(),
        ),
        BlocProvider<ProgressCubit>(
          create: (_) => sl<ProgressCubit>()..load(),
        ),
      ],
      child: Scaffold(
        backgroundColor: _kBg,
        body: Stack(
          children: [
            Positioned.fill(
              child: IndexedStack(
                index: _index,
                children: const [
                  ResultsTab(),
                  GamesListScreen(),
                  TimeFocusScreen(embedded: true),
                  HomeScreen(embedded: true),
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
      ),
    );
  }
}

