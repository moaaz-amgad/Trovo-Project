import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../mini_game/data/models/mini_game_session.dart';
import '../../../mini_game/data/repositories/mini_game_repository.dart';
import '../../data/models/memory_round.dart';
import '../../data/models/memory_symbol.dart';
import '../../data/repositories/memory_sequence_repository.dart';

part 'memory_sequence_cubit.freezed.dart';

@freezed
class MemorySequenceState with _$MemorySequenceState {
  const factory MemorySequenceState.initial() = _MemorySequenceInitial;
  const factory MemorySequenceState.inProgress({
    required int level,
    required int roundIndex,
    required int totalRounds,
    required MemorySymbol currentSymbol,
    required bool canAnswer,
    required int score,
    required int correctCount,
    required int streak,
    required int maxStreak,
    required int fastThresholdMs,
    required List<MemoryRound> rounds,
  }) = _MemorySequenceInProgress;
  const factory MemorySequenceState.completed({
    required int level,
    required int score,
    required int correctCount,
    required int totalRounds,
    required double accuracy,
    required int avgReactionTimeMs,
    required int maxStreak,
    required List<MemoryRound> rounds,
  }) = _MemorySequenceCompleted;
}

class MemorySequenceCubit extends Cubit<MemorySequenceState> {
  MemorySequenceCubit({
    required MemorySequenceRepository repository,
    MiniGameRepository? miniGame,
  }) : _repository = repository,
       _miniGame = miniGame,
       super(const MemorySequenceState.initial());

  static const int _totalRounds = 15;
  static const int _baseFastThresholdMs = 1500;

  final MemorySequenceRepository _repository;
  final MiniGameRepository? _miniGame;
  final Stopwatch _session = Stopwatch();
  final Random _random = Random();

  final List<MemorySymbol> _symbols = [];
  final List<MemoryRound> _rounds = [];

  int _level = 1;
  int _score = 0;
  int _correctCount = 0;
  int _streak = 0;
  int _maxStreak = 0;
  DateTime? _roundStart;

  void start({required int level}) {
    if (level < 1) {
      _level = 1;
    } else if (level > 3) {
      _level = 3;
    } else {
      _level = level;
    }
    _symbols.clear();
    _rounds.clear();
    _score = 0;
    _correctCount = 0;
    _streak = 0;
    _maxStreak = 0;
    _session
      ..reset()
      ..start();
    _startRound();
  }

  void restart() {
    start(level: _level);
  }

  void reset() {
    _symbols.clear();
    _rounds.clear();
    _score = 0;
    _correctCount = 0;
    _streak = 0;
    _maxStreak = 0;
    _roundStart = null;
    emit(const MemorySequenceState.initial());
  }

  void answer({required bool answerYes}) {
    if (state is! _MemorySequenceInProgress) return;

    final currentIndex = _symbols.length - 1;
    if (!_canAnswer(currentIndex)) return;

    final compareIndex = currentIndex - _repository.nBackForLevel(_level);
    if (compareIndex < 0 || compareIndex >= _symbols.length) return;

    final currentSymbol = _symbols[currentIndex];
    final compareSymbol = _symbols[compareIndex];
    final isMatch = _repository.isMatch(
      current: currentSymbol,
      compare: compareSymbol,
      level: _level,
    );
    final isCorrect = answerYes == isMatch;
    final reactionMs = _roundStart == null
        ? null
        : DateTime.now().difference(_roundStart!).inMilliseconds;

    final fastThreshold = _fastThresholdMs();

    if (isCorrect) {
      _score += 10;
      _correctCount += 1;
      _streak += 1;
      if (_streak > _maxStreak) {
        _maxStreak = _streak;
      }
      if (reactionMs != null && reactionMs <= fastThreshold) {
        _score += 5;
      }
    } else {
      _streak = 0;
      if (_level == 3) {
        _score -= 5;
      }
    }

    _rounds.add(
      MemoryRound(
        index: currentIndex + 1,
        symbol: currentSymbol,
        answeredYes: answerYes,
        isCorrect: isCorrect,
        reactionTimeMs: reactionMs,
      ),
    );

    if (_isLastRound(currentIndex)) {
      _complete();
      return;
    }

    _startRound();
  }

  void skipRound() {
    if (state is! _MemorySequenceInProgress) return;

    final currentIndex = _symbols.length - 1;
    if (_canAnswer(currentIndex)) return;

    _rounds.add(
      MemoryRound(
        index: currentIndex + 1,
        symbol: _symbols[currentIndex],
        answeredYes: null,
        isCorrect: null,
        reactionTimeMs: null,
      ),
    );

    if (_isLastRound(currentIndex)) {
      _complete();
      return;
    }

    _startRound();
  }

  bool _canAnswer(int index) {
    final nBack = _repository.nBackForLevel(_level);
    return index >= nBack;
  }

  bool _isLastRound(int index) => index + 1 >= _totalRounds;

  void _startRound() {
    final shouldMatch = _shouldMatchNext();
    final symbol = _repository.nextSymbol(
      history: _symbols,
      level: _level,
      shouldMatch: shouldMatch,
    );
    _symbols.add(symbol);
    _roundStart = DateTime.now();
    _emitInProgress();
  }

  bool _shouldMatchNext() {
    final nextIndex = _symbols.length;
    final nBack = _repository.nBackForLevel(_level);
    if (nextIndex < nBack) {
      return false;
    }
    return _random.nextDouble() < 0.35;
  }

  int _fastThresholdMs() {
    final times = _rounds
        .where((round) => round.reactionTimeMs != null)
        .map((round) => round.reactionTimeMs!)
        .toList();

    if (times.isEmpty) {
      return _baseFastThresholdMs;
    }

    final avg = times.reduce((a, b) => a + b) / times.length;
    final int threshold = (avg * 0.75).round();
    if (threshold < 600) return 600;
    if (threshold > 2200) return 2200;
    return threshold;
  }

  void _emitInProgress() {
    final index = _symbols.length - 1;
    emit(
      MemorySequenceState.inProgress(
        level: _level,
        roundIndex: index,
        totalRounds: _totalRounds,
        currentSymbol: _symbols[index],
        canAnswer: _canAnswer(index),
        score: _score,
        correctCount: _correctCount,
        streak: _streak,
        maxStreak: _maxStreak,
        fastThresholdMs: _fastThresholdMs(),
        rounds: List.unmodifiable(_rounds),
      ),
    );
  }

  void _complete() {
    final answered = _rounds
        .where((round) => round.reactionTimeMs != null)
        .toList();
    final answeredCount = answered.length;
    final correctCount = answered
        .where((round) => round.isCorrect == true)
        .length;
    final double accuracy = answeredCount == 0
        ? 0
        : correctCount / answeredCount;
    final int avgMs = answeredCount == 0
        ? 0
        : (answered
                      .map((round) => round.reactionTimeMs!)
                      .reduce((a, b) => a + b) /
                  answeredCount)
              .round();

    _session.stop();
    emit(
      MemorySequenceState.completed(
        level: _level,
        score: _score,
        correctCount: _correctCount,
        totalRounds: _totalRounds,
        accuracy: accuracy,
        avgReactionTimeMs: avgMs,
        maxStreak: _maxStreak,
        rounds: List.unmodifiable(_rounds),
      ),
    );

    _miniGame?.submitSession(
      MiniGameSession(
        gameType: MiniGameType.memorySequence,
        score: _score < 0 ? 0 : _score,
        reactionTimeMs: avgMs,
        accuracyPercentage: accuracy * 100,
        difficultyLevel: _level.toString(),
        durationSeconds: _session.elapsed.inSeconds,
      ),
    );
  }
}
