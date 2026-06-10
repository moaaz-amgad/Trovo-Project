import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection_container.dart';
import '../../../core/routing/app_router_paths.dart';
import '../../../core/services/secure_storage_service.dart';
import '../../../core/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  bool _animateIn = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() => _animateIn = true);
    });

    _timer = Timer(const Duration(seconds: 2), () async {
      if (!mounted) return;
      final hasToken = await sl<SecureStorageService>().hasAccessToken();
      if (!mounted) return;
      context.go(
        hasToken ? AppRoutePaths.layoutScreen : AppRoutePaths.loginScreen,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F1),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            const _BackdropBlobs(),
            Center(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 450),
                opacity: _animateIn ? 1 : 0,
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 450),
                  offset: _animateIn ? Offset.zero : const Offset(0, 0.08),
                  curve: Curves.easeOutCubic,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 220,
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.94),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0x14042F40),
                            width: 1,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x1A042F40),
                              blurRadius: 48,
                              offset: Offset(0, 22),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Image.asset(
                            'assets/images/sloth.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        'TROVO',
                        style: TextStyle(
                          color: AppTheme.deepTeal,
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Take back your focus.',
                        style: TextStyle(
                          color: Color(0xB3042F40),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          height: 1.3,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 24,
              right: 24,
              bottom: 28,
              child: IgnorePointer(
                child: Text(
                  'A calm reset for your attention.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0x8A042F40),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                    letterSpacing: 0.2,
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

class _BackdropBlobs extends StatelessWidget {
  const _BackdropBlobs();

  @override
  Widget build(BuildContext context) {
    return const IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -110,
            left: -92,
            child: _Blob(size: 228, color: Color(0x1A0B3A4A)),
          ),
          Positioned(
            top: 86,
            right: -74,
            child: _Blob(size: 168, color: Color(0x120B3A4A)),
          ),
          Positioned(
            bottom: 78,
            left: -46,
            child: _Blob(size: 112, color: Color(0x100B3A4A)),
          ),
        ],
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
