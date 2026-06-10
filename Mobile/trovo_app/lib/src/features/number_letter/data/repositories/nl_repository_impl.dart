import 'dart:math';

import '../models/nl_round.dart';
import 'nl_repository.dart';

class NlRepositoryImpl implements NlRepository {
  NlRepositoryImpl({Random? random}) : _random = random ?? Random();

  final Random _random;

  static const int _totalRounds = 12;
  static const Duration _roundDuration = Duration(seconds: 4);

  static const List<String> _consonants = [
    'b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm',
    'n', 'p', 'q', 'r', 's', 't', 'v', 'w', 'x', 'y', 'z',
  ];
  static const List<String> _vowels = ['a', 'e', 'i', 'o', 'u'];

  @override
  int totalRoundsForSession() => _totalRounds;

  @override
  Duration roundTimeLimit() => _roundDuration;

  @override
  NlRound nextRound({required int level, required int index}) {
    final rule = _ruleForIndex(index);
    final number = _randomNumber();
    final letter = _randomLetter(rule, level);

    return NlRound(
      index: index,
      rule: rule,
      number: number,
      letter: letter,
    );
  }

  // Distribute rules evenly: 4 rounds each (A, B, C) for 12 total
  NlRule _ruleForIndex(int index) {
    return NlRule.values[index % 3];
  }

  int _randomNumber() => _random.nextInt(9) + 1; // 1–9

  String _randomLetter(NlRule rule, int level) {
    if (level == 1) {
      // Level 1: mix vowels and consonants
      return _random.nextBool()
          ? _vowels[_random.nextInt(_vowels.length)]
          : _consonants[_random.nextInt(_consonants.length)];
    }
    // Higher levels: random mix
    final all = [..._vowels, ..._consonants];
    return all[_random.nextInt(all.length)];
  }
}
