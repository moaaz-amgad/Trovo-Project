import 'package:flutter/material.dart';

class StroopCard extends StatelessWidget {
  final String text;
  final Color textColor;

  const StroopCard({
    Key? key,
    required this.text,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: textColor,
          letterSpacing: 2,
        ),
      ),
    );
  }
}

class LabelBubble extends StatelessWidget {
  final String text;
  final bool isPointingDown;

  const LabelBubble({
    Key? key,
    required this.text,
    this.isPointingDown = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!isPointingDown) _buildTriangle(isPointingDown),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFA0948D), // Brownish gray
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF4A3E38), // Dark brown
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        if (isPointingDown) _buildTriangle(isPointingDown),
      ],
    );
  }

  Widget _buildTriangle(bool isDown) {
    return CustomPaint(
      size: const Size(12, 8),
      painter: TrianglePainter(
        color: const Color(0xFFA0948D),
        isDown: isDown,
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;
  final bool isDown;

  TrianglePainter({required this.color, required this.isDown});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = color;
    var path = Path();
    if (isDown) {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width / 2, size.height);
    } else {
      path.moveTo(size.width / 2, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
