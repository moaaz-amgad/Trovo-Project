import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'skip',
                    style: TextStyle(
                      color: Color(0xFF0D3B4C),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Understand your mind',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color(0xFF0D3B4C),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 280,
                      height: 280,
                      decoration: const BoxDecoration(
                        color: Color(0xFFC7E2F3),
                        shape: BoxShape.circle,
                      ),
                    ),
                    // Illustration placeholder - Use an Image.asset or NetworkImage here
                    Image.asset("images/photo 1comp 1.png",
                    
                    )
                  ],
                ),
              ),
              const Spacer(),
              const Text(
                'Start with a quick diagnosis to discover how screen time and habits affect your focus and energy.',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xFF0D3B4C),
                  fontSize: 18,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    
                    children: [
                      _buildPageIndicator(true),
                      _buildPageIndicator(false),
                      _buildPageIndicator(false),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Color(0xFF0D3B4C),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator(bool isActive) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF0D3B4C) : const Color(0xFFD1D9DB),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
