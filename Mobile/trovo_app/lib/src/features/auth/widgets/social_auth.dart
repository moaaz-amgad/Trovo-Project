import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialAuth extends StatelessWidget {
  const SocialAuth({super.key, this.onGoogle, this.onApple});

  /// Invoked when the user taps the Google chip. Wire this to obtain an
  /// `id_token` (e.g. via google_sign_in) and call `AuthCubit.googleLogin`.
  final VoidCallback? onGoogle;
  final VoidCallback? onApple;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialChip(
          icon: SvgPicture.asset(
            'assets/images/apple-icon.svg',
            width: 34,
            height: 34,
          ),
          color: Colors.black,
          onPressed: onApple ?? () {},
        ),
        const SizedBox(width: 18),
        _SocialChip(
          icon: SvgPicture.asset(
            'assets/images/google-icon.svg',
            width: 34,
            height: 34,
          ),
          color: const Color(0xFF4285F4),
          onPressed: onGoogle ?? () {},
        ),
      ],
    );
  }
}

class _SocialChip extends StatelessWidget {
  const _SocialChip({
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  final Widget icon;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(width: 40, height: 40, child: Center(child: icon)),
    );
  }
}
