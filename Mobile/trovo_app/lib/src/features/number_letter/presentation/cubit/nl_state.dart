import '../../data/models/nl_round.dart';

enum NlFeedback { none, correct, wrong, timeout }

sealed class NlState {
  const NlState();
}

class NlInitial extends NlState {
  const NlInitial();
}

class NlInProgress extends NlState {
  const NlInProgress({
    required this.level,
    required this.roundIndex,
    required this.totalRounds,
    required this.currentRound,
    required this.score,
    required this.correctCount,
    required this.roundTimeLimit,
    required this.rounds,
    required this.feedback,
  });

  final int level;
  final int roundIndex;
  final int totalRounds;
  final NlRound currentRound;
  final int score;
  final int correctCount;
  final Duration roundTimeLimit;
  final List<NlRound> rounds;
  final NlFeedback feedback;
}

class NlCompleted extends NlState {
  const NlCompleted({
    required this.level,
    required this.score,
    required this.correctCount,
    required this.totalRounds,
    required this.accuracy,
    required this.ruleAAccuracy,
    required this.ruleBAccuracy,
    required this.ruleCAccuracy,
    required this.avgReactionTimeMs,
    required this.rounds,
  });

  final int level;
  final int score;
  final int correctCount;
  final int totalRounds;
  final double accuracy;
  final double ruleAAccuracy;
  final double ruleBAccuracy;
  final double ruleCAccuracy;
  final int avgReactionTimeMs;
  final List<NlRound> rounds;
}
