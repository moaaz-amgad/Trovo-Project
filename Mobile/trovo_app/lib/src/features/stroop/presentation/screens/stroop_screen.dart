import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trovo_app/src/core/di/injection_container.dart';
import 'package:trovo_app/src/core/services/game_sound_player.dart';
import 'package:trovo_app/src/features/stroop/data/models/stroop_round.dart';
import 'package:trovo_app/src/features/stroop/presentation/cubit/stroop_cubit.dart';
import 'package:trovo_app/src/features/stroop/presentation/cubit/stroop_state.dart';

const Color _kBgColor = Color(0xFF042F40);
const Color _kCardLight = Color(0xFFF2F2F2);
const Color _kPillColor = Color(0xFFD9D9D9);
const Color _kTextDark = Color(0xFF042F40);
const Color _kTextLight = Color(0xFFF2F2F2);
const Color _kMenuBorder = Color(0xFF82979F);
const Color _kFlashCorrect = Color(0xFF2EC451);
const Color _kFlashWrong = Color(0xFFC42C2F);
const String _kFontFamily = 'Poppins';

const Duration _kFeedbackDuration = Duration(milliseconds: 380);

enum _Stage { start, instructions, countdown, playing, paused, result }

class StroopScreen extends StatelessWidget {
  const StroopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StroopCubit>(
      create: (_) => sl<StroopCubit>(),
      child: const _StroopView(),
    );
  }
}

class _StroopView extends StatefulWidget {
  const _StroopView();

  @override
  State<_StroopView> createState() => _StroopViewState();
}

class _StroopViewState extends State<_StroopView>
    with TickerProviderStateMixin {
  _Stage _stage = _Stage.start;
  final int _selectedLevel = 2;
  int _countdown = 3;
  int _trackedRoundIndex = -1;
  Timer? _countdownTimer;
  Timer? _elapsedTimer;
  Timer? _roundTimer;
  Timer? _feedbackTimer;
  DateTime? _sessionStartedAt;
  Duration _elapsed = Duration.zero;
  Duration _accumulated = Duration.zero;
  _Stage _stageBeforePause = _Stage.playing;

  late final AnimationController _progressController;
  final GameSoundPlayer _sound = GameSoundPlayer();

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _elapsedTimer?.cancel();
    _roundTimer?.cancel();
    _feedbackTimer?.cancel();
    _progressController.dispose();
    _sound.dispose();
    super.dispose();
  }

  void _exitToMain() {
    _resetTimersAndState();
    context.read<StroopCubit>().reset();
    // Leave the game entirely, back out to the main screen.
    Navigator.of(context).maybePop();
  }

  void _showInstructions() {
    setState(() => _stage = _Stage.instructions);
  }

  void _beginCountdown() {
    _countdownTimer?.cancel();
    setState(() {
      _stage = _Stage.countdown;
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
    _sessionStartedAt = DateTime.now();
    context.read<StroopCubit>().start(level: _selectedLevel);
    _startElapsedTimer();
    setState(() => _stage = _Stage.playing);
  }

  void _onPausePressed() {
    if (_stage == _Stage.playing) {
      _pause();
    } else if (_stage == _Stage.paused) {
      _resume();
    }
  }

  void _pause() {
    _stageBeforePause = _stage;
    _stopElapsedTimer();
    _roundTimer?.cancel();
    _progressController.stop();
    if (_sessionStartedAt != null) {
      _accumulated += DateTime.now().difference(_sessionStartedAt!);
    }
    _sessionStartedAt = null;
    setState(() => _stage = _Stage.paused);
  }

  void _resume() {
    setState(() => _stage = _stageBeforePause);
    if (_stage == _Stage.playing) {
      _sessionStartedAt = DateTime.now();
      _startElapsedTimer();
      // resume the round timer with remaining time
      final remainingFraction = 1 - _progressController.value;
      final cubitState = context.read<StroopCubit>().state;
      if (cubitState is StroopInProgress &&
          cubitState.feedback == StroopFeedback.none) {
        final totalMs = cubitState.roundTimeLimit.inMilliseconds;
        final remaining = Duration(
          milliseconds: (totalMs * remainingFraction).round(),
        );
        _scheduleTimeout(remaining);
        _progressController.forward(from: _progressController.value);
      }
    }
  }

  void _restart() {
    _resetTimersAndState();
    context.read<StroopCubit>().reset();
    _beginCountdown();
  }

  void _quit() {
    _resetTimersAndState();
    context.read<StroopCubit>().reset();
    setState(() => _stage = _Stage.start);
  }

  void _resetTimersAndState() {
    _countdownTimer?.cancel();
    _roundTimer?.cancel();
    _feedbackTimer?.cancel();
    _stopElapsedTimer();
    _progressController.stop();
    _progressController.value = 0;
    _trackedRoundIndex = -1;
    _accumulated = Duration.zero;
    _elapsed = Duration.zero;
    _sessionStartedAt = null;
  }

  void _stopElapsedTimer() {
    _elapsedTimer?.cancel();
    _elapsedTimer = null;
  }

  void _startElapsedTimer() {
    _elapsedTimer?.cancel();
    _elapsedTimer = Timer.periodic(const Duration(milliseconds: 250), (_) {
      if (!mounted || _sessionStartedAt == null) return;
      setState(() {
        _elapsed = _accumulated + DateTime.now().difference(_sessionStartedAt!);
      });
    });
  }

  void _onNewRound(StroopInProgress state) {
    if (state.roundIndex == _trackedRoundIndex) return;
    _trackedRoundIndex = state.roundIndex;
    _feedbackTimer?.cancel();
    _roundTimer?.cancel();
    _progressController
      ..stop()
      ..duration = state.roundTimeLimit
      ..value = 0
      ..forward();
    _scheduleTimeout(state.roundTimeLimit);
  }

  void _scheduleTimeout(Duration duration) {
    _roundTimer?.cancel();
    _roundTimer = Timer(duration, () {
      if (!mounted) return;
      context.read<StroopCubit>().timeout();
    });
  }

  void _onFeedback(StroopInProgress state) {
    _roundTimer?.cancel();
    _progressController.stop();
    _feedbackTimer?.cancel();
    _feedbackTimer = Timer(_kFeedbackDuration, () {
      if (!mounted) return;
      context.read<StroopCubit>().advance();
    });
  }

  void _onAnswer(bool yes) {
    if (_stage != _Stage.playing) return;
    context.read<StroopCubit>().answer(answerYes: yes);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StroopCubit, StroopState>(
      listener: (context, state) {
        switch (state) {
          case StroopInitial():
            _trackedRoundIndex = -1;
            _accumulated = Duration.zero;
            _elapsed = Duration.zero;
            _sessionStartedAt = null;
            _stopElapsedTimer();
            _progressController.value = 0;
          case StroopInProgress():
            if (_stage != _Stage.playing && _stage != _Stage.paused) {
              setState(() => _stage = _Stage.playing);
            }
            if (state.feedback == StroopFeedback.none) {
              _onNewRound(state);
            } else {
              if (state.feedback == StroopFeedback.correct) {
                _sound.correct();
              } else {
                _sound.wrong();
              }
              _onFeedback(state);
            }
          case StroopCompleted():
            _resetTimersAndState();
            setState(() => _stage = _Stage.result);
        }
      },
      child: Scaffold(
        backgroundColor: _kBgColor,
        body: BlocBuilder<StroopCubit, StroopState>(
          builder: (context, state) {
            return _Layout(
              stage: _stage,
              cubitState: state,
              elapsed: _elapsed,
              countdown: _countdown,
              progress: _progressController,
              onPausePressed: _onPausePressed,
              onCardTap: _stage == _Stage.start ? _showInstructions : null,
              onInstructionsContinue: _beginCountdown,
              onResume: _resume,
              onRestart: _restart,
              onQuit: _exitToMain,
              onHowToPlay: _showInstructions,
              onYes: () => _onAnswer(true),
              onNo: () => _onAnswer(false),
              onPlayAgain: () {
                _resetTimersAndState();
                _accumulated = Duration.zero;
                _sessionStartedAt = DateTime.now();
                context.read<StroopCubit>().restart();
                _startElapsedTimer();
                setState(() => _stage = _Stage.playing);
              },
              onChooseAnotherLevel: _exitToMain,
            );
          },
        ),
      ),
    );
  }
}

class _Layout extends StatelessWidget {
  const _Layout({
    required this.stage,
    required this.cubitState,
    required this.elapsed,
    required this.countdown,
    required this.progress,
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

  final _Stage stage;
  final StroopState cubitState;
  final Duration elapsed;
  final int countdown;
  final AnimationController progress;
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
    if (stage == _Stage.result && cubitState is StroopCompleted) {
      return _ResultBody(
        result: cubitState as StroopCompleted,
        onPlayAgain: onPlayAgain,
        onChooseAnotherLevel: onChooseAnotherLevel,
      );
    }

    StroopRound? round;
    int score = 0;
    StroopFeedback feedback = StroopFeedback.none;
    if (cubitState is StroopInProgress) {
      final s = cubitState as StroopInProgress;
      round = s.currentRound;
      score = s.score;
      feedback = s.feedback;
    }

    final bool canAnswer =
        stage == _Stage.playing &&
        round != null &&
        feedback == StroopFeedback.none;
    final bool dimmed =
        stage == _Stage.start ||
        stage == _Stage.instructions ||
        stage == _Stage.countdown ||
        stage == _Stage.paused;

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
                  paused: stage == _Stage.paused,
                  onPausePressed: onPausePressed,
                ),
              ),
              const SizedBox(height: 8),
              _ProgressBar(
                controller: progress,
                visible: stage == _Stage.playing && round != null,
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: _QuestionText(),
              ),
              Expanded(
                child: Center(
                  child: _CardStack(
                    stage: stage,
                    round: round,
                    onCardTap: onCardTap,
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
        if (dimmed && stage != _Stage.start) const _ScrimOverlay(opacity: 0.4),
        if (stage == _Stage.start) const _StartOverlay(),
        if (stage == _Stage.countdown) _CountdownBubble(value: countdown),
        if (stage == _Stage.instructions)
          _InstructionsModal(onContinue: onInstructionsContinue),
        if (stage == _Stage.paused)
          _PauseMenu(
            onResume: onResume,
            onRestart: onRestart,
            onQuit: onQuit,
            onHowToPlay: onHowToPlay,
          ),
        if (feedback == StroopFeedback.correct)
          const _FlashOverlay(color: _kFlashCorrect),
        if (feedback == StroopFeedback.wrong ||
            feedback == StroopFeedback.timeout)
          const _FlashOverlay(color: _kFlashWrong),
      ],
    );
  }
}

class _ScrimOverlay extends StatelessWidget {
  const _ScrimOverlay({required this.opacity});
  final double opacity;
  @override
  Widget build(BuildContext context) => IgnorePointer(
    child: Container(color: Colors.black.withValues(alpha: opacity)),
  );
}

class _FlashOverlay extends StatelessWidget {
  const _FlashOverlay({required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) =>
      IgnorePointer(child: Container(color: color.withValues(alpha: 0.28)));
}

class _StartOverlay extends StatelessWidget {
  const _StartOverlay();
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        color: Colors.black.withValues(alpha: 0.4),
        alignment: Alignment.center,
        child: const Text(
          'Start',
          style: TextStyle(
            fontFamily: _kFontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 40,
            color: _kTextLight,
          ),
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.controller, required this.visible});

  final AnimationController controller;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        height: 6,
        child: AnimatedOpacity(
          opacity: visible ? 1 : 0,
          duration: const Duration(milliseconds: 200),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                final value = (1 - controller.value).clamp(0.0, 1.0);
                return Stack(
                  children: [
                    Container(color: Colors.white.withValues(alpha: 0.18)),
                    FractionallySizedBox(
                      widthFactor: value,
                      child: Container(color: _kCardLight),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
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
    final m = duration.inMinutes;
    final s = duration.inSeconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
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
    final paint = Paint()..color = _kTextLight;
    final barW = size.width * 0.18;
    final barH = size.height * 0.62;
    final gap = size.width * 0.18;
    final y = (size.height - barH) / 2;
    final xStart = (size.width - (barW * 2 + gap)) / 2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(xStart, y, barW, barH),
        const Radius.circular(2),
      ),
      paint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(xStart + barW + gap, y, barW, barH),
        const Radius.circular(2),
      ),
      paint,
    );
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
      'Does the meaning match the\ntext color?',
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

class _CardStack extends StatelessWidget {
  const _CardStack({
    required this.stage,
    required this.round,
    required this.onCardTap,
  });

  final _Stage stage;
  final StroopRound? round;
  final VoidCallback? onCardTap;

  @override
  Widget build(BuildContext context) {
    final bool isActive = stage == _Stage.playing && round != null;
    return GestureDetector(
      onTap: onCardTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _LabeledCard(
              label: 'meaning',
              labelOnTop: true,
              active: isActive,
              child: isActive
                  ? _ColorWord(text: round!.meaning.label, color: Colors.black)
                  : null,
            ),
            const SizedBox(height: 36),
            _LabeledCard(
              label: 'text color',
              labelOnTop: false,
              active: isActive,
              child: isActive
                  ? _ColorWord(
                      text: round!.displayedWord.label,
                      color: round!.displayedColor.color,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _LabeledCard extends StatelessWidget {
  const _LabeledCard({
    required this.label,
    required this.labelOnTop,
    required this.active,
    this.child,
  });

  final String label;
  final bool labelOnTop;
  final bool active;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final tooltip = _Tooltip(label: label, pointDown: labelOnTop);
    final card = Container(
      width: 230,
      height: 110,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active ? _kCardLight : _kCardLight.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: labelOnTop
          ? [tooltip, const SizedBox(height: 0), card]
          : [card, const SizedBox(height: 0), tooltip],
    );
  }
}

class _Tooltip extends StatelessWidget {
  const _Tooltip({required this.label, required this.pointDown});

  final String label;
  final bool pointDown;

  @override
  Widget build(BuildContext context) {
    final pill = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _kPillColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: _kFontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: Colors.black,
        ),
      ),
    );
    final arrow = SizedBox(
      width: 18,
      height: 8,
      child: CustomPaint(painter: _ArrowPainter(pointDown: pointDown)),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: pointDown ? [pill, arrow] : [arrow, pill],
    );
  }
}

class _ArrowPainter extends CustomPainter {
  _ArrowPainter({required this.pointDown});
  final bool pointDown;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = _kPillColor;
    final path = Path();
    if (pointDown) {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width / 2, size.height);
    } else {
      path.moveTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width / 2, 0);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ColorWord extends StatelessWidget {
  const _ColorWord({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: _kFontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 44,
        color: color,
      ),
    );
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
          width: 340,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
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
          child: const Text.rich(
            TextSpan(
              style: TextStyle(
                fontFamily: _kFontFamily,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Colors.black,
                height: 1.45,
              ),
              children: [
                TextSpan(
                  text:
                      'Determine whether the text color matches the meaning of the word. Select ',
                ),
                TextSpan(
                  text: 'Yes',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(text: ' if they match and '),
                TextSpan(
                  text: 'No',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(
                  text:
                      ' if they do not, focusing only on the color of the text.',
                ),
              ],
            ),
            textAlign: TextAlign.center,
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
            style: const TextStyle(
              fontFamily: _kFontFamily,
              fontWeight: FontWeight.w700,
              fontSize: 32,
              color: _kTextDark,
            ),
          ),
        ),
      ),
    );
  }
}

class _ResultBody extends StatelessWidget {
  const _ResultBody({
    required this.result,
    required this.onPlayAgain,
    required this.onChooseAnotherLevel,
  });

  final StroopCompleted result;
  final VoidCallback onPlayAgain;
  final VoidCallback onChooseAnotherLevel;

  @override
  Widget build(BuildContext context) {
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
