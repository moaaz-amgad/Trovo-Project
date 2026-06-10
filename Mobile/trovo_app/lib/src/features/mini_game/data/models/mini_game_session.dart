/// Identifiers for the cognitive mini-games, matching the `game_type` values
/// the backend expects.
class MiniGameType {
  MiniGameType._();

  static const String stroop = 'stroop';
  static const String numberLetter = 'number_letter';
  static const String memorySequence = 'memory_sequence';
  static const String attentionSpan = 'attention_span';
}

/// Request payload for `POST /api/mini-game`.
class MiniGameSession {
  const MiniGameSession({
    required this.gameType,
    required this.score,
    required this.reactionTimeMs,
    required this.accuracyPercentage,
    required this.difficultyLevel,
    required this.durationSeconds,
  });

  final String gameType;
  final int score;
  final int reactionTimeMs;
  final double accuracyPercentage;
  final String difficultyLevel;
  final int durationSeconds;

  Map<String, String> toFields() => {
    'game_type': gameType,
    'score': score.toString(),
    'reaction_time_ms': reactionTimeMs.toString(),
    'accuracy_percentage': accuracyPercentage.toStringAsFixed(2),
    'difficulty_level': difficultyLevel,
    'duration_seconds': durationSeconds.toString(),
  };
}
