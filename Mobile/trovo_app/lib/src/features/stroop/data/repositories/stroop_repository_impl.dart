import 'dart:math';

import '../models/stroop_color.dart';
import '../models/stroop_round.dart';
import 'stroop_repository.dart';

class StroopRepositoryImpl implements StroopRepository {
  StroopRepositoryImpl({Random? random}) : _random = random ?? Random();

  final Random _random;

  static const int _totalRounds = 10;
  static const Duration _roundDuration = Duration(seconds: 3);

  @override
  int totalRoundsForSession() => _totalRounds;

  @override
  Duration roundTimeLimit() => _roundDuration;

  @override
  StroopRound nextRound({required int level, required int index}) {
    final StroopColor meaning = _randomColor();
    final bool shouldMatch = _shouldMatch(level);
    final StroopColor displayedColor = shouldMatch
        ? meaning
        : _randomColor(exclude: meaning);
    final StroopColor displayedWord = level == 1
        ? meaning
        : _randomColor();

    return StroopRound(
      index: index,
      meaning: meaning,
      displayedWord: displayedWord,
      displayedColor: displayedColor,
    );
  }

  bool _shouldMatch(int level) {
    switch (level) {
      case 1:
        return true;
      case 2:
        return _random.nextBool();
      case 3:
      default:
        return _random.nextDouble() < 0.2;
    }
  }

  StroopColor _randomColor({StroopColor? exclude}) {
    final values = StroopColor.values;
    if (exclude == null) {
      return values[_random.nextInt(values.length)];
    }
    StroopColor pick = values[_random.nextInt(values.length)];
    int guard = 0;
    while (pick == exclude && guard < 10) {
      pick = values[_random.nextInt(values.length)];
      guard++;
    }
    return pick;
  }
}
