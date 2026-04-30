import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';

class AnimatedFeedbackIcon extends StatefulWidget {
  final FeedbackState feedbackState;

  const AnimatedFeedbackIcon({Key? key, required this.feedbackState}) : super(key: key);

  @override
  _AnimatedFeedbackIconState createState() => _AnimatedFeedbackIconState();
}

class _AnimatedFeedbackIconState extends State<AnimatedFeedbackIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
  }

  @override
  void didUpdateWidget(covariant AnimatedFeedbackIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.feedbackState != oldWidget.feedbackState) {
      if (widget.feedbackState != FeedbackState.none) {
        _controller.forward(from: 0.0);
      } else {
        _controller.reset();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.feedbackState == FeedbackState.none) {
      return const SizedBox(width: 60, height: 60);
    }

    final isCorrect = widget.feedbackState == FeedbackState.correct;
    final color = isCorrect ? const Color(0xFF5AB644) : const Color(0xFFE53935);
    final icon = isCorrect ? Icons.check : Icons.close;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        );
      },
    );
  }
}
