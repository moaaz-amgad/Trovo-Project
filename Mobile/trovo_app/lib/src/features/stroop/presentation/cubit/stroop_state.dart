import '../../data/models/stroop_round.dart';

enum StroopFeedback { none, correct, wrong, timeout }

sealed class StroopState {
  const StroopState();
}

class StroopInitial extends StroopState {
  const StroopInitial();
}

class StroopInProgress extends StroopState {
  const StroopInProgress({
    required this.level,
    required this.roundIndex,
    required this.totalRounds,
    required this.currentRound,
    required this.score,
    required this.correctCount,
    required this.streak,
    required this.maxStreak,
    required this.roundTimeLimit,
    required this.rounds,
    required this.feedback,
  });

  final int level;
  final int roundIndex;
  final int totalRounds;
  final StroopRound currentRound;
  final int score;
  final int correctCount;
  final int streak;
  final int maxStreak;
  final Duration roundTimeLimit;
  final List<StroopRound> rounds;
  final StroopFeedback feedback;
}

class StroopCompleted extends StroopState {
  const StroopCompleted({
    required this.level,
    required this.score,
    required this.correctCount,
    required this.totalRounds,
    required this.accuracy,
    required this.avgReactionTimeMs,
    required this.maxStreak,
    required this.rounds,
  });

  final int level;
  final int score;
  final int correctCount;
  final int totalRounds;
  final double accuracy;
  final int avgReactionTimeMs;
  final int maxStreak;
  final List<StroopRound> rounds;
}
