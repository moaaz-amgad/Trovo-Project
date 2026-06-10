import 'dart:math' as math;

import 'package:flutter/material.dart';

class QuestionnaireHorizontalPicker extends StatefulWidget {
  const QuestionnaireHorizontalPicker({
    super.key,
    required this.min,
    required this.max,
    required this.value,
    required this.onChanged,
  });

  final int min;
  final int max;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  State<QuestionnaireHorizontalPicker> createState() =>
      _QuestionnaireHorizontalPickerState();
}

class _QuestionnaireHorizontalPickerState
    extends State<QuestionnaireHorizontalPicker> {
  static const double _itemWidth = 22;
  static const double _itemGap = 54.75;
  static const double _itemStride = _itemWidth + _itemGap;

  late final ScrollController _controller;
  late int _selected;

  @override
  void initState() {
    super.initState();
    _selected = _clamp(widget.value);
    _controller = ScrollController(
      initialScrollOffset: math.max(
        0,
        ((_selected - widget.min) - 2) * _itemStride,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant QuestionnaireHorizontalPicker old) {
    super.didUpdateWidget(old);
    final clamped = _clamp(widget.value);
    if (clamped == _selected) return;
    _selected = clamped;
    _scrollToSelected();
  }

  int _clamp(int v) => v.clamp(widget.min, widget.max);

  void _scrollToSelected() {
    if (!_controller.hasClients) return;
    final desired = math.max(
      0.0,
      ((_selected - widget.min) - 2) * _itemStride,
    );
    _controller.animateTo(
      desired.clamp(0, _controller.position.maxScrollExtent),
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.max - widget.min + 1;
    return SizedBox(
      height: 88,
      child: ListView.separated(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: count,
        separatorBuilder: (_, _) => const SizedBox(width: _itemGap),
        itemBuilder: (context, index) {
          final itemValue = widget.min + index;
          final isSelected = itemValue == _selected;

          return InkWell(
            onTap: () {
              if (itemValue == _selected) return;
              setState(() => _selected = itemValue);
              widget.onChanged(itemValue);
              _scrollToSelected();
            },
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: _itemWidth,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$itemValue',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF042F40).withValues(
                        alpha: isSelected ? 1.0 : 0.4,
                      ),
                    ),
                  ),
                  SizedBox(height: isSelected ? 9 : 4),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 8,
                    height: isSelected ? 50 : 30,
                    decoration: BoxDecoration(
                      color: const Color(0xFF042F40).withValues(
                        alpha: isSelected ? 1.0 : 0.4,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
