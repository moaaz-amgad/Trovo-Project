import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A single destination in the app's bottom navigation bar.
class AppNavDestination {
  const AppNavDestination({required this.iconAsset, required this.label});

  final String iconAsset;
  final String label;
}

/// The shared bottom navigation bar used by the main app shell.
///
/// The active destination is lifted into a floating white circle that sits
/// above the bar, matching the Trovo design system.
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.destinations,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<AppNavDestination> destinations;

  static const Color _basis = Color(0xFF042F40);
  static const Color _bg = Color(0xFFF2F2F2);
  static const Color _inactiveIcon = Color(0xFFF2F2F2);
  static const double _barHeight = 96;
  static const double _raise = 28;

  @override
  Widget build(BuildContext context) {
    final double bottomInset = MediaQuery.viewPaddingOf(context).bottom;

    return SizedBox(
      height: _barHeight + _raise + bottomInset,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: _barHeight + bottomInset,
              padding: EdgeInsets.only(bottom: bottomInset),
              decoration: const BoxDecoration(
                color: _basis,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x40000000),
                    blurRadius: 20,
                    offset: Offset(0, -8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  for (var i = 0; i < destinations.length; i++)
                    Expanded(
                      child: _NavSlot(
                        destination: destinations[i],
                        active: i == currentIndex,
                        onTap: () => onTap(i),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavSlot extends StatelessWidget {
  const _NavSlot({
    required this.destination,
    required this.active,
    required this.onTap,
  });

  final AppNavDestination destination;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        height: double.infinity,
        child: Center(
          child: active
              ? Transform.translate(
                  offset: const Offset(0, -AppBottomNavBar._raise),
                  child: _RaisedIcon(iconAsset: destination.iconAsset),
                )
              : SvgPicture.asset(
                  destination.iconAsset,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppBottomNavBar._inactiveIcon,
                    BlendMode.srcIn,
                  ),
                ),
        ),
      ),
    );
  }
}

class _RaisedIcon extends StatelessWidget {
  const _RaisedIcon({required this.iconAsset});

  final String iconAsset;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: const BoxDecoration(
        color: AppBottomNavBar._bg,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        iconAsset,
        width: 26,
        height: 26,
        colorFilter: const ColorFilter.mode(
          AppBottomNavBar._basis,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
