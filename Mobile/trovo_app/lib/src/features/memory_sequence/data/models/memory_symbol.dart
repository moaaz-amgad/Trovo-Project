import 'package:flutter/material.dart';

enum MemoryShape { circle, square, triangle, star, flower }

extension MemoryShapeIcon on MemoryShape {
  IconData get icon {
    switch (this) {
      case MemoryShape.circle:
        return Icons.circle;
      case MemoryShape.square:
        return Icons.square;
      case MemoryShape.triangle:
        return Icons.change_history;
      case MemoryShape.star:
        return Icons.star;
      case MemoryShape.flower:
        return Icons.local_florist;
    }
  }

  String get label {
    switch (this) {
      case MemoryShape.circle:
        return 'Circle';
      case MemoryShape.square:
        return 'Square';
      case MemoryShape.triangle:
        return 'Triangle';
      case MemoryShape.star:
        return 'Star';
      case MemoryShape.flower:
        return 'Flower';
    }
  }
}

class MemorySymbol {
  const MemorySymbol({required this.shape, required this.color});

  final MemoryShape shape;
  final Color color;

  String get id => '${shape.name}-${color.toARGB32()}';
}
