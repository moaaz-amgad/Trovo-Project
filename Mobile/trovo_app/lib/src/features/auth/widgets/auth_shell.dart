import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthShell extends StatelessWidget {
  const AuthShell({
    super.key,
    required this.child,
    this.topPadding = 110,
    this.slothTop = 52,
    this.slothHeight = 185,
    this.slothWidth,
    this.slothAlignment = Alignment.topCenter,
    this.showBackButton = false,
    this.onBack,
  });

  final Widget child;
  final double topPadding;
  final double slothTop;
  final double slothHeight;
  final double? slothWidth;
  final Alignment slothAlignment;
  final bool showBackButton;
  final VoidCallback? onBack;

  Widget _imageFallback() {
    return const DecoratedBox(
      decoration: BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Icon(Icons.pets_rounded, color: Colors.white, size: 56),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardOpen = MediaQuery.viewInsetsOf(context).bottom > 0;
    final double currentSlothHeight = isKeyboardOpen ? 0 : slothHeight;
    final double currentHeaderHeight = isKeyboardOpen ? 80 : 155;
    final double currentTopPadding = isKeyboardOpen ? 60 : topPadding;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Stack(
          children: [
            IgnorePointer(
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    height: currentHeaderHeight,
                    decoration: const BoxDecoration(
                      color: Color(0xFF042F3E),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x22000000),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
            if (showBackButton)
              Positioned(
                top: 10,
                left: 8,
                child: IconButton(
                  onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.arrow_back_rounded),
                  color: Colors.white,
                ),
              ),
            if (!isKeyboardOpen)
              Positioned(
                top: slothTop,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  child: Align(
                    alignment: slothAlignment,
                    child: SizedBox(
                      width: slothWidth,
                      height: currentSlothHeight,
                      child: Image.asset(
                        'assets/images/sloth.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            SvgPicture.asset(
                              'assets/images/sloth.svg',
                              fit: BoxFit.contain,
                              placeholderBuilder: (context) =>
                                  const SizedBox.shrink(),
                              errorBuilder: (context, error, stackTrace) =>
                                  _imageFallback(),
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              top: currentTopPadding,
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
