import '../models/memory_symbol.dart';

abstract class MemorySequenceRepository {
  int nBackForLevel(int level);

  bool isMatch({
    required MemorySymbol current,
    required MemorySymbol compare,
    required int level,
  });

  MemorySymbol nextSymbol({
    required List<MemorySymbol> history,
    required int level,
    required bool shouldMatch,
  });
}
