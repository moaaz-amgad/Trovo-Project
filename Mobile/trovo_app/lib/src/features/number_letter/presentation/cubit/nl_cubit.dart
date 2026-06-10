import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../mini_game/data/models/mini_game_session.dart';
import '../../../mini_game/data/repositories/mini_game_repository.dart';
import '../../data/models/nl_round.dart';
import '../../data/repositories/nl_repository.dart';
import 'nl_state.dart';

class NlCubit extends Cubit<NlState> {
  NlCubit({required NlRepository repository, MiniGameRepository? miniGame})
    : _repository = repository,
      _miniGame = miniGame,
      super(const NlInitial());

  final NlRepository _repository;
  final MiniGameRepository? _miniGame;
  final Stopwatch _session = Stopwatch();

  int _level = 1;
  int _score = 0;
  int _correctCount = 0;
  final List<NlRound> _rounds = [];
  NlRound? _currentRound;
  DateTime? _roundStart;

  void start({required int level}) {
    _level = level.clamp(1, 3);
    _score = 0;
    _correctCount = 0;
    _rounds.clear();
    _session
      ..reset()
      ..start();
    _startRound(0);
  }

  void restart() => start(level: _level);

  void reset() {
    _score = 0;
    _correctCount = 0;
    _rounds.clear();
    _currentRound = null;
    _roundStart = null;
    emit(const NlInitial());
  }

  void answer({required bool answerYes}) {
    final round = _currentRound;
    if (round == null) return;
    if (state is! NlInProgress) return;
    final inProgress = state as NlInProgress;
    if (inProgress.feedback != NlFeedback.none) return;

    final isCorrect = answerYes == round.correctAnswer;
    _finalizeRound(round, answeredYes: answerYes, isCorrect: isCorrect, timedOut: false);
  }

  void timeout() {
    final round = _currentRound;
    if (round == null) return;
    if (state is! NlInProgress) return;
    final inProgress = state as NlInProgress;
    if (inProgress.feedback != NlFeedback.none) return;
    _finalizeRound(round, answeredYes: null, isCorrect: false, timedOut: true);
  }

  void advance() {
    final nextIndex = _rounds.length;
    if (nextIndex >= _repository.totalRoundsForSession()) {
      _complete();
      return;
    }
    _startRound(nextIndex);
  }

  void _finalizeRound(
    NlRound round, {
    required bool? answeredYes,
    required bool isCorrect,
    required bool timedOut,
  }) {
    final reactionMs = _roundStart == null
        ? null
        : DateTime.now().difference(_roundStart!).inMilliseconds;

    if (isCorrect) {
      _score += 10;
      final fast = reactionMs != null && reactionMs < 2000;
      if (fast) _score += 5;
      _correctCount += 1;
    } else {
      if (_level == 3) {
        _score -= 5;
        if (_score < 0) _score = 0;
      }
    }

    final completed = round.copyWith(
      answeredYes: answeredYes,
      isCorrect: isCorrect,
      reactionTimeMs: reactionMs,
      timedOut: timedOut,
    );
    _rounds.add(completed);
    _currentRound = completed;

    final feedback = isCorrect
        ? NlFeedback.correct
        : timedOut
        ? NlFeedback.timeout
        : NlFeedback.wrong;
    _emitInProgress(feedback);
  }

  void _startRound(int index) {
    final round = _repository.nextRound(level: _level, index: index);
    _currentRound = round;
    _roundStart = DateTime.now();
    _emitInProgress(NlFeedback.none);
  }

  void _emitInProgress(NlFeedback feedback) {
    final current = _currentRound;
    if (current == null) return;
    emit(
      NlInProgress(
        level: _level,
        roundIndex: current.index,
        totalRounds: _repository.totalRoundsForSession(),
        currentRound: current,
        score: _score,
        correctCount: _correctCount,
        roundTimeLimit: _repository.roundTimeLimit(),
        rounds: List.unmodifiable(_rounds),
        feedback: feedback,
      ),
    );
  }

  void _complete() {
    final answered = _rounds.where((r) => r.reactionTimeMs != null).toList();
    final accuracy = _rounds.isEmpty ? 0.0 : _correctCount / _rounds.length;
    final avgMs = answered.isEmpty
        ? 0
        : (answered.map((r) => r.reactionTimeMs!).reduce((a, b) => a + b) /
              answered.length)
            .round();

    double ruleAccuracy(NlRule rule) {
      final ruleRounds = _rounds.where((r) => r.rule == rule).toList();
      if (ruleRounds.isEmpty) return 0.0;
      final correct = ruleRounds.where((r) => r.isCorrect == true).length;
      return correct / ruleRounds.length;
    }

    _session.stop();
    emit(
      NlCompleted(
        level: _level,
        score: _score,
        correctCount: _correctCount,
        totalRounds: _repository.totalRoundsForSession(),
        accuracy: accuracy,
        ruleAAccuracy: ruleAccuracy(NlRule.a),
        ruleBAccuracy: ruleAccuracy(NlRule.b),
        ruleCAccuracy: ruleAccuracy(NlRule.c),
        avgReactionTimeMs: avgMs,
        rounds: List.unmodifiable(_rounds),
      ),
    );

    _miniGame?.submitSession(
      MiniGameSession(
        gameType: MiniGameType.numberLetter,
        score: _score < 0 ? 0 : _score,
        reactionTimeMs: avgMs,
        accuracyPercentage: accuracy * 100,
        difficultyLevel: _level.toString(),
        durationSeconds: _session.elapsed.inSeconds,
      ),
    );
  }
}
