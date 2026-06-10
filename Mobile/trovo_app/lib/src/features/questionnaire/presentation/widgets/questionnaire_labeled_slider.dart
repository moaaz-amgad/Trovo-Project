import 'package:flutter/material.dart';

class QuestionnaireLabeledSlider extends StatelessWidget {
  const QuestionnaireLabeledSlider({
    super.key,
    required this.min,
    required this.max,
    required this.divisions,
    required this.value,
    required this.labels,
    required this.onChanged,
    this.labelFontSize = 12,
  });

  final double min;
  final double max;
  final int divisions;
  final double value;
  final List<String> labels;
  final ValueChanged<double> onChanged;
  final double labelFontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 8,
            activeTrackColor: const Color(0xFF042F40),
            inactiveTrackColor: const Color(0xFF9BAAB2),
            thumbShape: const _RingThumbShape(),
            overlayShape: SliderComponentShape.noOverlay,
          ),
          child: Slider(
            min: min,
            max: max,
            divisions: divisions,
            value: value.clamp(min, max),
            onChanged: onChanged,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: labels
              .map(
                (label) => Text(
                  label,
                  style: TextStyle(
                    fontSize: labelFontSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _RingThumbShape extends SliderComponentShape {
  const _RingThumbShape();

  static const double _radius = 12;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      const Size.fromRadius(_radius);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;
    canvas.drawCircle(center, _radius, Paint()..color = const Color(0xFF042F40));
    canvas.drawCircle(center, 6, Paint()..color = Colors.white);
  }
}
