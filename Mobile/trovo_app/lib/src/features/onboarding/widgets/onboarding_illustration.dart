import 'package:flutter/material.dart';

class OnboardingIllustration extends StatelessWidget {
  const OnboardingIllustration({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  final String assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;

  Widget _placeholder() {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: Color(0x11000000),
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          color: Color(0x66000000),
          size: 40,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset(
        assetPath,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => Image.asset(
          'assets/images/splash_icon.png',
          fit: BoxFit.contain,
          errorBuilder: (context, fallbackError, fallbackStackTrace) =>
              _placeholder(),
        ),
      ),
    );
  }
}
