import '../../data/models/attention_round.dart';

enum AttentionFeedback { none, correct, mistake }

sealed class AttentionState {
  const AttentionState();
}

class AttentionInitial extends AttentionState {
  const AttentionInitial();
}

class AttentionInProgress extends AttentionState {
  const AttentionInProgress({
    required this.roundIndex,
    required this.totalRounds,
    required this.currentRound,
    required this.correctCount,
    required this.mistakeCount,
    required this.stimulusWindow,
    required this.targetLetters,
    required this.feedback,
  });

  final int roundIndex;
  final int totalRounds;
  final AttentionRound currentRound;
  final int correctCount;
  final int mistakeCount;
  final Duration stimulusWindow;
  final List<String> targetLetters;
  final AttentionFeedback feedback;
}

class AttentionCompleted extends AttentionState {
  const AttentionCompleted({
    required this.totalRounds,
    required this.correctCount,
    required this.mistakeCount,
    required this.accuracy,
    required this.avgReactionTimeMs,
    required this.bestReactionTimeMs,
    required this.rounds,
  });

  final int totalRounds;
  final int correctCount;
  final int mistakeCount;
  final double accuracy;
  final int avgReactionTimeMs;

  /// Fastest correct reaction to a target letter (0 when none recorded).
  final int bestReactionTimeMs;
  final List<AttentionRound> rounds;
}
