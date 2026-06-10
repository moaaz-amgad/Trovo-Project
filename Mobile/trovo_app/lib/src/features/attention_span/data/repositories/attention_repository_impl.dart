import 'dart:math';

import '../models/attention_round.dart';
import 'attention_repository.dart';

class AttentionRepositoryImpl implements AttentionRepository {
  AttentionRepositoryImpl({Random? random}) : _random = random ?? Random();

  final Random _random;

  static const int _totalRounds = 25;
  static const Duration _stimulusWindow = Duration(milliseconds: 1600);

  /// Roughly 40% of rounds present a target letter.
  static const double _targetProbability = 0.4;

  static const List<String> _targets = ['D', 'G'];
  static const List<String> _distractors = [
    'A', 'B', 'C', 'E', 'F', 'H', 'J', 'K', 'L', 'M',
    'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
  ];

  @override
  List<String> get targetLetters => _targets;

  @override
  int totalRoundsForSession() => _totalRounds;

  @override
  Duration stimulusWindow() => _stimulusWindow;

  @override
  AttentionRound nextRound(int index) {
    final bool isTarget = _random.nextDouble() < _targetProbability;
    final String letter = isTarget
        ? _targets[_random.nextInt(_targets.length)]
        : _distractors[_random.nextInt(_distractors.length)];

    return AttentionRound(index: index, letter: letter, isTarget: isTarget);
  }
}
