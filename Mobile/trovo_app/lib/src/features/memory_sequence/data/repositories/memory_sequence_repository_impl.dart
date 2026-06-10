import 'dart:math';

import 'package:flutter/material.dart';

import '../models/memory_symbol.dart';
import 'memory_sequence_repository.dart';

class MemorySequenceRepositoryImpl implements MemorySequenceRepository {
  MemorySequenceRepositoryImpl({Random? random}) : _random = random ?? Random();

  final Random _random;

  static const List<MemoryShape> _shapes = [
    MemoryShape.circle,
    MemoryShape.square,
    MemoryShape.triangle,
    MemoryShape.star,
    MemoryShape.flower,
  ];

  static const Color _yellow = Color(0xFFF8C21A);
  static const Color _purple = Color(0xFF8B5CF6);
  static const Color _red = Color(0xFFF24B3B);
  static const Color _blue = Color(0xFF4C8CFF);
  static const Color _green = Color(0xFF4CAF50);

  static const List<Color> _colors = [_yellow, _purple, _red, _blue, _green];

  @override
  int nBackForLevel(int level) => level >= 3 ? 2 : 1;

  @override
  bool isMatch({
    required MemorySymbol current,
    required MemorySymbol compare,
    required int level,
  }) {
    if (level == 1) {
      return current.shape == compare.shape;
    }
    return current.shape == compare.shape && current.color == compare.color;
  }

  @override
  MemorySymbol nextSymbol({
    required List<MemorySymbol> history,
    required int level,
    required bool shouldMatch,
  }) {
    final nBack = nBackForLevel(level);
    final MemorySymbol? compare = history.length >= nBack
        ? history[history.length - nBack]
        : null;
    final MemorySymbol? last = history.isNotEmpty ? history.last : null;

    if (shouldMatch && compare != null) {
      if (level == 1) {
        final color = _randomColor(exclude: compare.color);
        return MemorySymbol(shape: compare.shape, color: color);
      }
      return MemorySymbol(shape: compare.shape, color: compare.color);
    }

    return _randomNonMatching(compare: compare, level: level, last: last);
  }

  MemorySymbol _randomNonMatching({
    required MemorySymbol? compare,
    required int level,
    required MemorySymbol? last,
  }) {
    for (int i = 0; i < 24; i++) {
      final symbol = _randomSymbol();
      if (compare != null &&
          isMatch(current: symbol, compare: compare, level: level)) {
        continue;
      }
      if (last != null && _isExactMatch(symbol, last)) {
        continue;
      }
      return symbol;
    }
    return _randomSymbol();
  }

  MemorySymbol _randomSymbol() {
    return MemorySymbol(shape: _randomShape(), color: _randomColor());
  }

  MemoryShape _randomShape() => _shapes[_random.nextInt(_shapes.length)];

  Color _randomColor({Color? exclude}) {
    if (exclude == null || _colors.length == 1) {
      return _colors[_random.nextInt(_colors.length)];
    }

    Color color = _colors[_random.nextInt(_colors.length)];
    int guard = 0;
    while (color == exclude && guard < 10) {
      color = _colors[_random.nextInt(_colors.length)];
      guard++;
    }
    return color;
  }

  bool _isExactMatch(MemorySymbol a, MemorySymbol b) {
    return a.shape == b.shape && a.color == b.color;
  }
}
