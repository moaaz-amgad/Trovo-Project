/// A single stimulus in the Attention Span (Go / No-Go) test.
///
/// One letter is shown per round. The player must tap the screen as fast as
/// possible when a *target* letter appears, and withhold the tap for any
/// other letter.
class AttentionRound {
  const AttentionRound({
    required this.index,
    required this.letter,
    required this.isTarget,
    this.tapped,
    this.isCorrect,
    this.reactionTimeMs,
  });

  final int index;
  final String letter;
  final bool isTarget;

  /// Whether the player tapped during this round (`null` until resolved).
  final bool? tapped;

  /// Whether the player's response was correct (`null` until resolved).
  final bool? isCorrect;

  /// Reaction time in milliseconds for a tap, when one occurred.
  final int? reactionTimeMs;

  bool get isResolved => isCorrect != null;

  AttentionRound copyWith({
    bool? tapped,
    bool? isCorrect,
    int? reactionTimeMs,
  }) {
    return AttentionRound(
      index: index,
      letter: letter,
      isTarget: isTarget,
      tapped: tapped ?? this.tapped,
      isCorrect: isCorrect ?? this.isCorrect,
      reactionTimeMs: reactionTimeMs ?? this.reactionTimeMs,
    );
  }
}
