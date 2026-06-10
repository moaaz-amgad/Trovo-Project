import 'memory_symbol.dart';

class MemoryRound {
  const MemoryRound({
    required this.index,
    required this.symbol,
    this.answeredYes,
    this.isCorrect,
    this.reactionTimeMs,
  });

  final int index;
  final MemorySymbol symbol;
  final bool? answeredYes;
  final bool? isCorrect;
  final int? reactionTimeMs;

  bool get isAnswered => reactionTimeMs != null;
}
