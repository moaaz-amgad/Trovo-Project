import 'stroop_color.dart';

class StroopRound {
  const StroopRound({
    required this.index,
    required this.meaning,
    required this.displayedWord,
    required this.displayedColor,
    this.answeredYes,
    this.isCorrect,
    this.reactionTimeMs,
    this.timedOut = false,
  });

  final int index;
  final StroopColor meaning;
  final StroopColor displayedWord;
  final StroopColor displayedColor;
  final bool? answeredYes;
  final bool? isCorrect;
  final int? reactionTimeMs;
  final bool timedOut;

  bool get isMatch => meaning == displayedColor;

  bool get isAnswered => answeredYes != null || timedOut;

  StroopRound copyWith({
    bool? answeredYes,
    bool? isCorrect,
    int? reactionTimeMs,
    bool? timedOut,
  }) {
    return StroopRound(
      index: index,
      meaning: meaning,
      displayedWord: displayedWord,
      displayedColor: displayedColor,
      answeredYes: answeredYes ?? this.answeredYes,
      isCorrect: isCorrect ?? this.isCorrect,
      reactionTimeMs: reactionTimeMs ?? this.reactionTimeMs,
      timedOut: timedOut ?? this.timedOut,
    );
  }
}
