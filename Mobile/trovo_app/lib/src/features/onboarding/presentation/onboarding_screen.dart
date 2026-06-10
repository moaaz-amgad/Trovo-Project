import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_theme.dart';
import '../../auth/presentation/screens/login_screen.dart';
import '../models/onboarding_page_model.dart';
import '../widgets/onboarding_dot_indicator.dart';
import '../widgets/onboarding_illustration.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<OnboardingPageModel> _pages = const [
    OnboardingPageModel(
      title: 'Understand your mind',
      description:
          'Start with a quick diagnosis to discover how screen time and habits affect your focus and energy.',
      assetPath: 'assets/images/onboarding_1.png',
    ),
    OnboardingPageModel(
      title: 'Get your\npersonalized plan',
      description:
          'Receive a daily program with games, tips, and exercises designed to restore your focus and balance.',
      assetPath: 'assets/images/onboarding_2.png',
    ),
    OnboardingPageModel(
      title: 'Start your journey to\nclarity',
      description:
          'Begin your personalized path to focus and balance — one calm step at a time.',
      assetPath: 'assets/images/onboarding_3.png',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_currentIndex == _pages.length - 1) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
      );
      return;
    }

    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _skip() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color onboardingBg = Color(0xFFF2F2F2);
    const Color onboardingPrimary = Color(0xFF042F3F);
    const Color onboardingBody = Color(0xFF042F40);

    const titleStyle = TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      height: 1.35,
      letterSpacing: -0.2,
      color: onboardingPrimary,
    );

    const descriptionStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      height: 1.5,
      color: onboardingBody,
    );

    return Scaffold(
      backgroundColor: onboardingBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _skip,
                  style: TextButton.styleFrom(
                    foregroundColor: onboardingPrimary,
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                  ),
                  child: Text(
                    'skip',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.1,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (index) =>
                      setState(() => _currentIndex = index),
                  itemBuilder: (context, index) {
                    final item = _pages[index];
                    return AnimatedPadding(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.only(top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.title, style: titleStyle),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 338,
                            child: OnboardingIllustration(
                              assetPath: item.assetPath,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(item.description, style: descriptionStyle),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: OnboardingDotIndicator(
                  currentIndex: _currentIndex,
                  itemCount: _pages.length,
                ),
              ),
              const SizedBox(height: 18),
              Align(
                alignment: Alignment.bottomRight,
                child: _NextButton(onTap: _goNext),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.deepTeal,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: const SizedBox(
          width: 63,
          height: 63,
          child: Icon(Icons.arrow_forward, size: 36, color: Colors.white),
        ),
      ),
    );
  }
}
