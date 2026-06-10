import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../mini_game/data/models/mini_game_session.dart';
import '../../../mini_game/data/repositories/mini_game_repository.dart';
import '../../data/models/stroop_round.dart';
import '../../data/repositories/stroop_repository.dart';
import 'stroop_state.dart';

class StroopCubit extends Cubit<StroopState> {
  StroopCubit({required StroopRepository repository, MiniGameRepository? miniGame})
    : _repository = repository,
      _miniGame = miniGame,
      super(const StroopInitial());

  final StroopRepository _repository;
  final MiniGameRepository? _miniGame;
  final Stopwatch _session = Stopwatch();

  int _level = 1;
  int _score = 0;
  int _correctCount = 0;
  int _streak = 0;
  int _maxStreak = 0;
  final List<StroopRound> _rounds = [];
  StroopRound? _currentRound;
  DateTime? _roundStart;

  void start({required int level}) {
    _level = level.clamp(1, 3);
    _score = 0;
    _correctCount = 0;
    _streak = 0;
    _maxStreak = 0;
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
    _streak = 0;
    _maxStreak = 0;
    _rounds.clear();
    _currentRound = null;
    _roundStart = null;
    emit(const StroopInitial());
  }

  void answer({required bool answerYes}) {
    final round = _currentRound;
    if (round == null) return;
    if (state is! StroopInProgress) return;
    final inProgress = state as StroopInProgress;
    if (inProgress.feedback != StroopFeedback.none) return;
    final isCorrect = answerYes == round.isMatch;
    _finalizeRound(
      round,
      answeredYes: answerYes,
      isCorrect: isCorrect,
      timedOut: false,
    );
  }

  void timeout() {
    final round = _currentRound;
    if (round == null) return;
    if (state is! StroopInProgress) return;
    final inProgress = state as StroopInProgress;
    if (inProgress.feedback != StroopFeedback.none) return;
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
    StroopRound round, {
    required bool? answeredYes,
    required bool isCorrect,
    required bool timedOut,
  }) {
    final reactionMs = _roundStart == null
        ? null
        : DateTime.now().difference(_roundStart!).inMilliseconds;

    if (isCorrect) {
      _score += 10;
      _correctCount += 1;
      _streak += 1;
      if (_streak > _maxStreak) _maxStreak = _streak;
    } else {
      _streak = 0;
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
        ? StroopFeedback.correct
        : timedOut
        ? StroopFeedback.timeout
        : StroopFeedback.wrong;
    _emitInProgress(feedback);
  }

  void _startRound(int index) {
    final round = _repository.nextRound(level: _level, index: index);
    _currentRound = round;
    _roundStart = DateTime.now();
    _emitInProgress(StroopFeedback.none);
  }

  void _emitInProgress(StroopFeedback feedback) {
    final current = _currentRound;
    if (current == null) return;
    emit(
      StroopInProgress(
        level: _level,
        roundIndex: current.index,
        totalRounds: _repository.totalRoundsForSession(),
        currentRound: current,
        score: _score,
        correctCount: _correctCount,
        streak: _streak,
        maxStreak: _maxStreak,
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
    _session.stop();
    emit(
      StroopCompleted(
        level: _level,
        score: _score,
        correctCount: _correctCount,
        totalRounds: _repository.totalRoundsForSession(),
        accuracy: accuracy,
        avgReactionTimeMs: avgMs,
        maxStreak: _maxStreak,
        rounds: List.unmodifiable(_rounds),
      ),
    );

    _miniGame?.submitSession(
      MiniGameSession(
        gameType: MiniGameType.stroop,
        score: _score < 0 ? 0 : _score,
        reactionTimeMs: avgMs,
        accuracyPercentage: accuracy * 100,
        difficultyLevel: _level.toString(),
        durationSeconds: _session.elapsed.inSeconds,
      ),
    );
  }
}
