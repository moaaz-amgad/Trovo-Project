import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trovo_app/src/core/di/injection_container.dart';
import 'package:trovo_app/src/core/services/game_sound_player.dart';
import 'package:trovo_app/src/features/memory_sequence/data/models/memory_round.dart';
import 'package:trovo_app/src/features/memory_sequence/data/models/memory_symbol.dart';
import 'package:trovo_app/src/features/memory_sequence/presentation/cubit/memory_sequence_cubit.dart';

const Color _kBgColor = Color(0xFF042F40);
const Color _kCardLight = Color(0xFFF2F2F2);
const Color _kPillColor = Color(0xFFD9D9D9);
const Color _kTextDark = Color(0xFF042F40);
const Color _kTextLight = Color(0xFFF2F2F2);
const Color _kMenuBorder = Color(0xFF82979F);
const String _kFontFamily = 'Poppins';

enum _FlowStage { start, instructions, countdown, playing, paused, result }

class MemorySequenceScreen extends StatelessWidget {
  const MemorySequenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MemorySequenceCubit>(
      create: (_) => sl<MemorySequenceCubit>(),
      child: const _MemorySequenceView(),
    );
  }
}

class _MemorySequenceView extends StatefulWidget {
  const _MemorySequenceView();

  @override
  State<_MemorySequenceView> createState() => _MemorySequenceViewState();
}

class _MemorySequenceViewState extends State<_MemorySequenceView> {
  _FlowStage _stage = _FlowStage.start;
  final int _selectedLevel = 1;
  int _countdown = 3;
  int _trackedRoundIndex = -1;
  Timer? _countdownTimer;
  Timer? _elapsedTimer;
  Timer? _autoSkipTimer;
  DateTime? _roundStartedAt;
  Duration _elapsed = Duration.zero;
  Duration _accumulated = Duration.zero;
  _FlowStage _stageBeforePause = _FlowStage.playing;
  bool _pendingSkipForCurrentRound = false;

  final GameSoundPlayer _sound = GameSoundPlayer();
  int _answeredSounded = 0;

  static const Duration _prefixDisplayDuration = Duration(milliseconds: 1200);

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _elapsedTimer?.cancel();
    _autoSkipTimer?.cancel();
    _sound.dispose();
    super.dispose();
  }

  /// Plays a sound the first time each answered round shows up in [rounds].
  void _maybePlayAnswerSound(List<MemoryRound> rounds) {
    final answered = rounds.where((r) => r.isCorrect != null).toList();
    if (answered.length <= _answeredSounded) return;
    _answeredSounded = answered.length;
    if (answered.last.isCorrect == true) {
      _sound.correct();
    } else {
      _sound.wrong();
    }
  }

  void _exitToMain() {
    _countdownTimer?.cancel();
    _stopElapsedTimer();
    _autoSkipTimer?.cancel();
    context.read<MemorySequenceCubit>().reset();
    // Leave the game entirely, back out to the main screen.
    Navigator.of(context).maybePop();
  }

  void _showInstructions() {
    setState(() => _stage = _FlowStage.instructions);
  }

  void _beginCountdown() {
    _countdownTimer?.cancel();
    setState(() {
      _stage = _FlowStage.countdown;
      _countdown = 3;
    });
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_countdown <= 1) {
        timer.cancel();
        _countdownTimer = null;
        _startGame();
        return;
      }
      setState(() => _countdown -= 1);
    });
  }

  void _startGame() {
    _accumulated = Duration.zero;
    _answeredSounded = 0;
    context.read<MemorySequenceCubit>().start(level: _selectedLevel);
    setState(() => _stage = _FlowStage.playing);
  }

  void _pause() {
    _stageBeforePause = _stage;
    _stopElapsedTimer();
    _autoSkipTimer?.cancel();
    if (_roundStartedAt != null) {
      _accumulated += DateTime.now().difference(_roundStartedAt!);
    }
    _roundStartedAt = null;
    setState(() => _stage = _FlowStage.paused);
  }

  void _resume() {
    setState(() => _stage = _stageBeforePause);
    if (_stage == _FlowStage.playing) {
      _roundStartedAt = DateTime.now();
      _startElapsedTimer();
      if (_pendingSkipForCurrentRound) {
        _scheduleAutoSkip();
      }
    }
  }

  void _restart() {
    _countdownTimer?.cancel();
    _stopElapsedTimer();
    _autoSkipTimer?.cancel();
    _pendingSkipForCurrentRound = false;
    _trackedRoundIndex = -1;
    _accumulated = Duration.zero;
    _elapsed = Duration.zero;
    _roundStartedAt = null;
    context.read<MemorySequenceCubit>().reset();
    _beginCountdown();
  }

  void _quit() {
    _countdownTimer?.cancel();
    _stopElapsedTimer();
    _autoSkipTimer?.cancel();
    _pendingSkipForCurrentRound = false;
    _trackedRoundIndex = -1;
    _accumulated = Duration.zero;
    _elapsed = Duration.zero;
    _roundStartedAt = null;
    context.read<MemorySequenceCubit>().reset();
    setState(() => _stage = _FlowStage.start);
  }

  void _scheduleAutoSkip() {
    _autoSkipTimer?.cancel();
    _autoSkipTimer = Timer(_prefixDisplayDuration, () {
      if (!mounted) return;
      _pendingSkipForCurrentRound = false;
      context.read<MemorySequenceCubit>().skipRound();
    });
  }

  void _stopElapsedTimer() {
    _elapsedTimer?.cancel();
    _elapsedTimer = null;
  }

  void _startElapsedTimer() {
    _elapsedTimer?.cancel();
    _elapsedTimer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      if (!mounted || _roundStartedAt == null) return;
      setState(() {
        _elapsed = _accumulated + DateTime.now().difference(_roundStartedAt!);
      });
    });
  }

  void _syncRoundTimer(int roundIndex) {
    if (roundIndex == _trackedRoundIndex) return;
    _trackedRoundIndex = roundIndex;
    if (_stage == _FlowStage.paused) return;
    _roundStartedAt = DateTime.now();
    _startElapsedTimer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MemorySequenceCubit, MemorySequenceState>(
      listener: (context, state) {
        state.whenOrNull(
          initial: () {
            _trackedRoundIndex = -1;
            _roundStartedAt = null;
            _elapsed = Duration.zero;
            _accumulated = Duration.zero;
            _pendingSkipForCurrentRound = false;
            _answeredSounded = 0;
            _autoSkipTimer?.cancel();
            _stopElapsedTimer();
          },
          inProgress:
              (
                level,
                roundIndex,
                totalRounds,
                currentSymbol,
                canAnswer,
                score,
                correctCount,
                streak,
                maxStreak,
                fastThresholdMs,
                rounds,
              ) {
                if (_stage != _FlowStage.playing &&
                    _stage != _FlowStage.paused) {
                  setState(() => _stage = _FlowStage.playing);
                }
                _syncRoundTimer(roundIndex);
                _maybePlayAnswerSound(rounds);
                final bool isPrefix = !canAnswer;
                _pendingSkipForCurrentRound = isPrefix;
                _autoSkipTimer?.cancel();
                if (isPrefix && _stage == _FlowStage.playing) {
                  _scheduleAutoSkip();
                }
              },
          completed:
              (
                level,
                score,
                correctCount,
                totalRounds,
                accuracy,
                avgReactionTimeMs,
                maxStreak,
                rounds,
              ) {
                _trackedRoundIndex = -1;
                _roundStartedAt = null;
                _elapsed = Duration.zero;
                _accumulated = Duration.zero;
                _pendingSkipForCurrentRound = false;
                _autoSkipTimer?.cancel();
                _stopElapsedTimer();
                _maybePlayAnswerSound(rounds);
                setState(() => _stage = _FlowStage.result);
              },
        );
      },
      child: Scaffold(
        backgroundColor: _kBgColor,
        body: BlocBuilder<MemorySequenceCubit, MemorySequenceState>(
          builder: (context, state) {
            return _GameLayout(
              stage: _stage,
              cubitState: state,
              elapsed: _elapsed,
              countdown: _countdown,
              onPausePressed: _onPausePressed,
              onCardTap: _stage == _FlowStage.start ? _showInstructions : null,
              onInstructionsContinue: _beginCountdown,
              onResume: _resume,
              onRestart: _restart,
              onQuit: _exitToMain,
              onHowToPlay: _showInstructions,
              onYes: () =>
                  context.read<MemorySequenceCubit>().answer(answerYes: true),
              onNo: () =>
                  context.read<MemorySequenceCubit>().answer(answerYes: false),
              onPlayAgain: () {
                _accumulated = Duration.zero;
                _elapsed = Duration.zero;
                _answeredSounded = 0;
                context.read<MemorySequenceCubit>().restart();
                setState(() => _stage = _FlowStage.playing);
              },
              onChooseAnotherLevel: _exitToMain,
            );
          },
        ),
      ),
    );
  }

  void _onPausePressed() {
    if (_stage == _FlowStage.playing) {
      _pause();
    } else if (_stage == _FlowStage.paused) {
      _resume();
    }
  }
}

class _GameLayout extends StatelessWidget {
  const _GameLayout({
    required this.stage,
    required this.cubitState,
    required this.elapsed,
    required this.countdown,
    required this.onPausePressed,
    required this.onCardTap,
    required this.onInstructionsContinue,
    required this.onResume,
    required this.onRestart,
    required this.onQuit,
    required this.onHowToPlay,
    required this.onYes,
    required this.onNo,
    required this.onPlayAgain,
    required this.onChooseAnotherLevel,
  });

  final _FlowStage stage;
  final MemorySequenceState cubitState;
  final Duration elapsed;
  final int countdown;
  final VoidCallback onPausePressed;
  final VoidCallback? onCardTap;
  final VoidCallback onInstructionsContinue;
  final VoidCallback onResume;
  final VoidCallback onRestart;
  final VoidCallback onQuit;
  final VoidCallback onHowToPlay;
  final VoidCallback onYes;
  final VoidCallback onNo;
  final VoidCallback onPlayAgain;
  final VoidCallback onChooseAnotherLevel;

  @override
  Widget build(BuildContext context) {
    if (stage == _FlowStage.result) {
      return _ResultBody(
        state: cubitState,
        onPlayAgain: onPlayAgain,
        onChooseAnotherLevel: onChooseAnotherLevel,
      );
    }

    final MemorySymbol? symbol = cubitState.maybeWhen(
      inProgress: (_, _, _, currentSymbol, _, _, _, _, _, _, _) =>
          currentSymbol,
      orElse: () => null,
    );
    final int score = cubitState.maybeWhen(
      inProgress: (_, _, _, _, _, score, _, _, _, _, _) => score,
      orElse: () => 0,
    );
    final bool canAnswer =
        stage == _FlowStage.playing &&
        cubitState.maybeWhen(
          inProgress: (_, _, _, _, canAnswer, _, _, _, _, _, _) => canAnswer,
          orElse: () => false,
        );

    final bool dimmed =
        stage == _FlowStage.start ||
        stage == _FlowStage.instructions ||
        stage == _FlowStage.countdown ||
        stage == _FlowStage.paused;

    return Stack(
      fit: StackFit.expand,
      children: [
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _TopBar(
                  score: score,
                  time: elapsed,
                  paused: stage == _FlowStage.paused,
                  onPausePressed: onPausePressed,
                ),
              ),
              const SizedBox(height: 28),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: _QuestionText(),
              ),
              Expanded(
                child: Center(
                  child: _CenterCard(
                    stage: stage,
                    symbol: symbol,
                    countdown: countdown,
                    onTap: onCardTap,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
                child: _AnswerRow(enabled: canAnswer, onYes: onYes, onNo: onNo),
              ),
            ],
          ),
        ),
        if (dimmed && stage != _FlowStage.start)
          const _ScrimOverlay(opacity: 0.4),
        if (stage == _FlowStage.countdown) _CountdownBubble(value: countdown),
        if (stage == _FlowStage.instructions)
          _InstructionsModal(onContinue: onInstructionsContinue),
        if (stage == _FlowStage.paused)
          _PauseMenu(
            onResume: onResume,
            onRestart: onRestart,
            onQuit: onQuit,
            onHowToPlay: onHowToPlay,
          ),
      ],
    );
  }
}

class _ScrimOverlay extends StatelessWidget {
  const _ScrimOverlay({required this.opacity});

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(color: Colors.black.withValues(alpha: opacity)),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.score,
    required this.time,
    required this.paused,
    required this.onPausePressed,
  });

  final int score;
  final Duration time;
  final bool paused;
  final VoidCallback onPausePressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _PauseButton(paused: paused, onPressed: onPausePressed),
        const Spacer(),
        _MetricChip(label: 'TIME', value: _formatTime(time)),
        const SizedBox(width: 8),
        _MetricChip(label: 'SCORE', value: '$score'),
      ],
    );
  }

  String _formatTime(Duration duration) {
    final int minutes = duration.inMinutes;
    final int seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}

class _PauseButton extends StatelessWidget {
  const _PauseButton({required this.paused, required this.onPressed});

  final bool paused;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: CustomPaint(painter: _PausePainter()),
          ),
          if (paused) ...[
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: _kPillColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Paused',
                style: TextStyle(
                  fontFamily: _kFontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PausePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = _kTextLight;
    final double barW = size.width * 0.18;
    final double barH = size.height * 0.62;
    final double gap = size.width * 0.18;
    final double y = (size.height - barH) / 2;
    final double xStart = (size.width - (barW * 2 + gap)) / 2;
    final RRect leftBar = RRect.fromRectAndRadius(
      Rect.fromLTWH(xStart, y, barW, barH),
      const Radius.circular(2),
    );
    final RRect rightBar = RRect.fromRectAndRadius(
      Rect.fromLTWH(xStart + barW + gap, y, barW, barH),
      const Radius.circular(2),
    );
    canvas.drawRRect(leftBar, paint);
    canvas.drawRRect(rightBar, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 29,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: _kPillColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: _kFontFamily,
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: Colors.black,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(
              fontFamily: _kFontFamily,
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionText extends StatelessWidget {
  const _QuestionText();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Does this symbol match the\nprevious symbol?',
      style: TextStyle(
        fontFamily: _kFontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 20,
        color: _kTextLight,
        height: 1.2,
      ),
    );
  }
}

class _CenterCard extends StatelessWidget {
  const _CenterCard({
    required this.stage,
    required this.symbol,
    required this.countdown,
    required this.onTap,
  });

  final _FlowStage stage;
  final MemorySymbol? symbol;
  final int countdown;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double size = math.min(width * 0.55, 220).toDouble();

    final bool isActive = stage == _FlowStage.playing && symbol != null;
    final bool isStart = stage == _FlowStage.start;
    final bool isCountdown = stage == _FlowStage.countdown;

    final Color cardColor = isActive
        ? _kCardLight
        : _kCardLight.withValues(alpha: 0.5);

    Widget child;
    if (isActive) {
      final double symbolSize = size * _symbolScale(symbol!.shape);
      child = Center(
        child: CustomPaint(
          size: Size(symbolSize, symbolSize),
          painter: _SymbolPainter(shape: symbol!.shape, color: symbol!.color),
        ),
      );
    } else if (isStart) {
      child = const Center(
        child: Text(
          'Start',
          style: TextStyle(
            fontFamily: _kFontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 40,
            color: _kTextLight,
          ),
        ),
      );
    } else if (isCountdown) {
      child = const SizedBox.shrink();
    } else {
      child = const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: child,
      ),
    );
  }

  double _symbolScale(MemoryShape shape) {
    switch (shape) {
      case MemoryShape.circle:
        return 0.78;
      case MemoryShape.square:
        return 0.78;
      case MemoryShape.star:
        return 0.78;
      case MemoryShape.triangle:
        return 0.74;
      case MemoryShape.flower:
        return 0.66;
    }
  }
}

class _CountdownBubble extends StatelessWidget {
  const _CountdownBubble({required this.value});

  final int value;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '$value',
            style: const TextStyle(
              fontFamily: _kFontFamily,
              fontWeight: FontWeight.w700,
              fontSize: 40,
              color: _kTextDark,
            ),
          ),
        ),
      ),
    );
  }
}

class _InstructionsModal extends StatelessWidget {
  const _InstructionsModal({required this.onContinue});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onContinue,
        child: Container(
          width: 320,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE5E5E5)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: const Text(
            'This game balances accuracy and speed. Respond as quickly as possible while avoiding mistakes.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: _kFontFamily,
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Colors.black,
              height: 1.4,
            ),
          ),
        ),
      ),
    );
  }
}

class _PauseMenu extends StatelessWidget {
  const _PauseMenu({
    required this.onResume,
    required this.onRestart,
    required this.onQuit,
    required this.onHowToPlay,
  });

  final VoidCallback onResume;
  final VoidCallback onRestart;
  final VoidCallback onQuit;
  final VoidCallback onHowToPlay;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _MenuButton(
              icon: Icons.play_arrow_rounded,
              label: 'Resume',
              onPressed: onResume,
            ),
            const SizedBox(height: 16),
            _MenuButton(
              icon: Icons.refresh_rounded,
              label: 'Restart',
              onPressed: onRestart,
            ),
            const SizedBox(height: 16),
            _MenuButton(icon: Icons.close, label: 'Quit', onPressed: onQuit),
            const SizedBox(height: 16),
            _MenuButton(
              icon: Icons.help_outline_rounded,
              label: 'How To Play',
              onPressed: onHowToPlay,
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _kMenuBorder, width: 0.5),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: _kTextDark),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(
                fontFamily: _kFontFamily,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: _kTextDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnswerRow extends StatelessWidget {
  const _AnswerRow({
    required this.enabled,
    required this.onYes,
    required this.onNo,
  });

  final bool enabled;
  final VoidCallback onYes;
  final VoidCallback onNo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _AnswerButton(label: 'NO', enabled: enabled, onPressed: onNo),
        _AnswerButton(label: 'YES', enabled: enabled, onPressed: onYes),
      ],
    );
  }
}

class _AnswerButton extends StatefulWidget {
  const _AnswerButton({
    required this.label,
    required this.enabled,
    required this.onPressed,
  });

  final String label;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  State<_AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<_AnswerButton> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (!widget.enabled) return;
    if (_pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final bool enabled = widget.enabled;
    final Color background = enabled ? Colors.white : _kPillColor;
    final Color textColor = _kTextDark;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) {
        _setPressed(false);
        if (enabled) widget.onPressed();
      },
      onTapCancel: () => _setPressed(false),
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1,
        duration: const Duration(milliseconds: 110),
        child: Container(
          width: 132,
          height: 78,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(999),
            boxShadow: enabled
                ? const [
                    BoxShadow(
                      color: Color(0x55FFFFFF),
                      blurRadius: 24,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Color(0x33000000),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ]
                : const [
                    BoxShadow(
                      color: Color(0x33000000),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontFamily: _kFontFamily,
              fontWeight: FontWeight.w700,
              fontSize: 32,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}

class _ResultBody extends StatelessWidget {
  const _ResultBody({
    required this.state,
    required this.onPlayAgain,
    required this.onChooseAnotherLevel,
  });

  final MemorySequenceState state;
  final VoidCallback onPlayAgain;
  final VoidCallback onChooseAnotherLevel;

  @override
  Widget build(BuildContext context) {
    final result = state.maybeWhen(
      completed:
          (
            level,
            score,
            correctCount,
            totalRounds,
            accuracy,
            avgReactionTimeMs,
            maxStreak,
            rounds,
          ) => (
            score: score,
            accuracy: accuracy,
            avgReactionTimeMs: avgReactionTimeMs,
            maxStreak: maxStreak,
          ),
      orElse: () =>
          (score: 0, accuracy: 0.0, avgReactionTimeMs: 0, maxStreak: 0),
    );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            const Text(
              'Session Complete',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: _kFontFamily,
                fontWeight: FontWeight.w700,
                fontSize: 28,
                color: _kTextLight,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Score ${result.score}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: _kFontFamily,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: _kTextLight,
              ),
            ),
            const SizedBox(height: 32),
            _StatTile(
              label: 'Accuracy',
              value: '${(result.accuracy * 100).toStringAsFixed(1)}%',
            ),
            const SizedBox(height: 12),
            _StatTile(
              label: 'Avg Reaction',
              value: '${result.avgReactionTimeMs}ms',
            ),
            const SizedBox(height: 12),
            _StatTile(label: 'Best Streak', value: '${result.maxStreak}'),
            const Spacer(),
            _PrimaryButton(label: 'Play Again', onPressed: onPlayAgain),
            const SizedBox(height: 12),
            _PrimaryButton(
              label: 'Back',
              onPressed: onChooseAnotherLevel,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kMenuBorder, width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: _kFontFamily,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: _kTextDark,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: _kFontFamily,
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: _kTextDark,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _kMenuBorder, width: 0.5),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: _kFontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: _kTextDark,
          ),
        ),
      ),
    );
  }
}

class _SymbolPainter extends CustomPainter {
  _SymbolPainter({required this.shape, required this.color});

  final MemoryShape shape;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..isAntiAlias = true;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.shortestSide / 2;

    switch (shape) {
      case MemoryShape.circle:
        canvas.drawCircle(center, radius, paint);
        break;
      case MemoryShape.square:
        final rect = Rect.fromCenter(
          center: center,
          width: size.width,
          height: size.height,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(radius * 0.18)),
          paint,
        );
        break;
      case MemoryShape.triangle:
        final path = Path()
          ..moveTo(center.dx, center.dy - radius)
          ..lineTo(center.dx - radius * 0.92, center.dy + radius * 0.95)
          ..lineTo(center.dx + radius * 0.92, center.dy + radius * 0.95)
          ..close();
        canvas.drawPath(path, paint);
        break;
      case MemoryShape.star:
        canvas.drawPath(_starPath(center, radius, 5, 0.40), paint);
        break;
      case MemoryShape.flower:
        canvas.drawPath(_flowerPath(center, radius * 0.95), paint);
        break;
    }
  }

  Path _starPath(Offset center, double radius, int points, double innerScale) {
    final Path path = Path();
    final double innerRadius = radius * innerScale;
    final double step = math.pi / points;
    for (int i = 0; i < points * 2; i++) {
      final double r = i.isEven ? radius : innerRadius;
      final double angle = -math.pi / 2 + step * i;
      final Offset point = Offset(
        center.dx + r * math.cos(angle),
        center.dy + r * math.sin(angle),
      );
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();
    return path;
  }

  Path _flowerPath(Offset center, double radius) {
    const int petals = 6;
    final double outer = radius;
    final double inner = radius * 0.55;
    final Path path = Path();

    for (int i = 0; i < petals; i++) {
      final double angle = (math.pi * 2 * i) / petals - math.pi / 2;
      final double nextAngle = (math.pi * 2 * (i + 1)) / petals - math.pi / 2;
      final Offset outerPoint = Offset(
        center.dx + outer * math.cos(angle),
        center.dy + outer * math.sin(angle),
      );
      final Offset nextOuterPoint = Offset(
        center.dx + outer * math.cos(nextAngle),
        center.dy + outer * math.sin(nextAngle),
      );
      final double midAngle = (angle + nextAngle) / 2;
      final Offset controlPoint = Offset(
        center.dx + inner * math.cos(midAngle),
        center.dy + inner * math.sin(midAngle),
      );

      if (i == 0) {
        path.moveTo(outerPoint.dx, outerPoint.dy);
      }
      path.quadraticBezierTo(
        controlPoint.dx,
        controlPoint.dy,
        nextOuterPoint.dx,
        nextOuterPoint.dy,
      );
    }

    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant _SymbolPainter oldDelegate) {
    return oldDelegate.shape != shape || oldDelegate.color != color;
  }
}
