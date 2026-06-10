import '../models/attention_round.dart';

/// Supplies the stimulus stream for the Attention Span (Go / No-Go) test.
abstract class AttentionRepository {
  /// The letters the player must react to.
  List<String> get targetLetters;

  /// Total number of rounds in a single session.
  int totalRoundsForSession();

  /// How long a single letter stays on screen before it times out.
  Duration stimulusWindow();

  /// Builds the round at [index].
  AttentionRound nextRound(int index);
}
