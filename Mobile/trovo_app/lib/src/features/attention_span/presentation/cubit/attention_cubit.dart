import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../mini_game/data/models/mini_game_session.dart';
import '../../../mini_game/data/repositories/mini_game_repository.dart';
import '../../data/models/attention_round.dart';
import '../../data/repositories/attention_repository.dart';
import 'attention_state.dart';

/// Drives the Attention Span (Go / No-Go) test.
///
/// The widget layer owns the timers (stimulus window, feedback flash and
/// advance) and calls into the cubit to record outcomes, mirroring the
/// existing game cubits in the codebase.
class AttentionCubit extends Cubit<AttentionState> {
  AttentionCubit({
    required AttentionRepository repository,
    MiniGameRepository? miniGame,
  }) : _repository = repository,
       _miniGame = miniGame,
       super(const AttentionInitial());

  final AttentionRepository _repository;
  final MiniGameRepository? _miniGame;
  final Stopwatch _session = Stopwatch();

  int _correctCount = 0;
  int _mistakeCount = 0;
  final List<AttentionRound> _rounds = [];
  AttentionRound? _currentRound;
  DateTime? _roundStart;

  // ── reaction-time training ──
  // The response window tightens as the player reacts faster to D / G and
  // eases back when a target is missed, so the game trains reaction time.
  static const Duration _floorWindow = Duration(milliseconds: 700);
  late final Duration _baseWindow = _repository.stimulusWindow();
  late Duration _window = _baseWindow;
  int _bestReactionMs = 0;

  void start() {
    _correctCount = 0;
    _mistakeCount = 0;
    _bestReactionMs = 0;
    _window = _baseWindow;
    _rounds.clear();
    _session
      ..reset()
      ..start();
    _startRound(0);
  }

  void reset() {
    _correctCount = 0;
    _mistakeCount = 0;
    _bestReactionMs = 0;
    _window = _baseWindow;
    _rounds.clear();
    _currentRound = null;
    _roundStart = null;
    emit(const AttentionInitial());
  }

  /// The player tapped the screen during the active round.
  void tap() {
    final round = _currentRound;
    if (round == null || state is! AttentionInProgress) return;
    if ((state as AttentionInProgress).feedback != AttentionFeedback.none) {
      return;
    }
    // Tapping is correct only for target letters.
    _resolveRound(round, tapped: true, isCorrect: round.isTarget);
  }

  /// The stimulus window elapsed with no tap.
  void timeout() {
    final round = _currentRound;
    if (round == null || state is! AttentionInProgress) return;
    if ((state as AttentionInProgress).feedback != AttentionFeedback.none) {
      return;
    }
    // Withholding the tap is correct only for non-target letters.
    _resolveRound(round, tapped: false, isCorrect: !round.isTarget);
  }

  void advance() {
    final nextIndex = _rounds.length;
    if (nextIndex >= _repository.totalRoundsForSession()) {
      _complete();
      return;
    }
    _startRound(nextIndex);
  }

  void _resolveRound(
    AttentionRound round, {
    required bool tapped,
    required bool isCorrect,
  }) {
    final reactionMs = tapped && _roundStart != null
        ? DateTime.now().difference(_roundStart!).inMilliseconds
        : null;

    if (isCorrect) {
      _correctCount += 1;
    } else {
      _mistakeCount += 1;
    }

    // Reaction-time training: a fast, correct hit on D / G tightens the next
    // window; a missed target relaxes it.
    if (isCorrect && tapped && reactionMs != null) {
      if (_bestReactionMs == 0 || reactionMs < _bestReactionMs) {
        _bestReactionMs = reactionMs;
      }
      final next = (reactionMs * 1.5).round();
      _window = Duration(
        milliseconds: next.clamp(
          _floorWindow.inMilliseconds,
          _baseWindow.inMilliseconds,
        ),
      );
    } else if (round.isTarget && !tapped) {
      final eased = _window.inMilliseconds + 200;
      _window = Duration(
        milliseconds: eased.clamp(
          _floorWindow.inMilliseconds,
          _baseWindow.inMilliseconds,
        ),
      );
    }

    final resolved = round.copyWith(
      tapped: tapped,
      isCorrect: isCorrect,
      reactionTimeMs: reactionMs,
    );
    _rounds.add(resolved);
    _currentRound = resolved;

    _emitInProgress(
      isCorrect ? AttentionFeedback.correct : AttentionFeedback.mistake,
    );
  }

  void _startRound(int index) {
    _currentRound = _repository.nextRound(index);
    _roundStart = DateTime.now();
    _emitInProgress(AttentionFeedback.none);
  }

  void _emitInProgress(AttentionFeedback feedback) {
    final current = _currentRound;
    if (current == null) return;
    emit(
      AttentionInProgress(
        roundIndex: current.index,
        totalRounds: _repository.totalRoundsForSession(),
        currentRound: current,
        correctCount: _correctCount,
        mistakeCount: _mistakeCount,
        stimulusWindow: _window,
        targetLetters: _repository.targetLetters,
        feedback: feedback,
      ),
    );
  }

  void _complete() {
    final taps = _rounds.where((r) => r.reactionTimeMs != null).toList();
    final accuracy = _rounds.isEmpty ? 0.0 : _correctCount / _rounds.length;
    final avgMs = taps.isEmpty
        ? 0
        : (taps.map((r) => r.reactionTimeMs!).reduce((a, b) => a + b) /
                  taps.length)
              .round();

    _session.stop();
    emit(
      AttentionCompleted(
        totalRounds: _repository.totalRoundsForSession(),
        correctCount: _correctCount,
        mistakeCount: _mistakeCount,
        accuracy: accuracy,
        avgReactionTimeMs: avgMs,
        bestReactionTimeMs: _bestReactionMs,
        rounds: List.unmodifiable(_rounds),
      ),
    );

    _miniGame?.submitSession(
      MiniGameSession(
        gameType: MiniGameType.attentionSpan,
        score: _correctCount * 10,
        reactionTimeMs: avgMs,
        accuracyPercentage: accuracy * 100,
        difficultyLevel: 'standard',
        durationSeconds: _session.elapsed.inSeconds,
      ),
    );
  }
}
