enum NlRule { a, b, c }

class NlRound {
  const NlRound({
    required this.index,
    required this.rule,
    required this.number,
    required this.letter,
    this.answeredYes,
    this.isCorrect,
    this.reactionTimeMs,
    this.timedOut = false,
  });

  final int index;
  final NlRule rule;
  final int number;
  final String letter;
  final bool? answeredYes;
  final bool? isCorrect;
  final int? reactionTimeMs;
  final bool timedOut;

  bool get isNumberEven => number % 2 == 0;

  static const List<String> _vowels = ['a', 'e', 'i', 'o', 'u'];
  bool get isLetterVowel => _vowels.contains(letter.toLowerCase());

  bool get correctAnswer => switch (rule) {
    NlRule.a => isNumberEven,
    NlRule.b => isLetterVowel,
    NlRule.c => isNumberEven && isLetterVowel,
  };

  bool get isAnswered => answeredYes != null || timedOut;

  NlRound copyWith({
    bool? answeredYes,
    bool? isCorrect,
    int? reactionTimeMs,
    bool? timedOut,
  }) {
    return NlRound(
      index: index,
      rule: rule,
      number: number,
      letter: letter,
      answeredYes: answeredYes ?? this.answeredYes,
      isCorrect: isCorrect ?? this.isCorrect,
      reactionTimeMs: reactionTimeMs ?? this.reactionTimeMs,
      timedOut: timedOut ?? this.timedOut,
    );
  }
}
