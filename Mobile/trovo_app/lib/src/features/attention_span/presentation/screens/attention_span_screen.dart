import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:trovo_app/src/core/di/injection_container.dart';
import 'package:trovo_app/src/core/services/game_sound_player.dart';
import '../cubit/attention_cubit.dart';
import '../cubit/attention_state.dart';

// ─── design tokens ────────────────────────────────────────────────────────────

const Color _kBg = Color(0xFFF2F2F2);
const Color _kDark = Color(0xFF042F40);
const Color _kStimulus = Color(0xFF191C1E);
const Color _kCorrect = Color(0xFF28A745);
const Color _kMistake = Color(0xFFDC3545);
const Color _kLabel = Color(0xFF767586);
const Color _kCardBorder = Color(0x14464AD4); // rgba(70,72,212,0.08)
const Color _kDivider = Color(0x4DC7C4D7); // rgba(199,196,215,0.30)
const Color _kRingInnerBorder = Color(0xFFC8DFFF);

const Duration _kFeedback = Duration(milliseconds: 420);

enum _Stage { start, countdown, playing, paused, result }

TextStyle _nunito({
  required double size,
  FontWeight weight = FontWeight.w600,
  Color color = _kDark,
  double? letterSpacing,
  double height = 1.5,
}) {
  return GoogleFonts.nunito(
    fontSize: size,
    fontWeight: weight,
    color: color,
    letterSpacing: letterSpacing,
    height: height,
  );
}

// ─── entry point ──────────────────────────────────────────────────────────────

class AttentionSpanScreen extends StatelessWidget {
  const AttentionSpanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AttentionCubit>(
      create: (_) => sl<AttentionCubit>(),
      child: const _AttentionView(),
    );
  }
}

// ─── stateful view ──────────────────────────────────────────────────────────

class _AttentionView extends StatefulWidget {
  const _AttentionView();

  @override
  State<_AttentionView> createState() => _AttentionViewState();
}

class _AttentionViewState extends State<_AttentionView>
    with TickerProviderStateMixin {
  _Stage _stage = _Stage.start;
  bool _showInstructions = false;
  int _countdown = 3;
  int _trackedRoundIndex = -1;

  Timer? _countdownTimer;
  Timer? _elapsedTimer;
  Timer? _windowTimer;
  Timer? _feedbackTimer;
  DateTime? _sessionStartedAt;
  Duration _elapsed = Duration.zero;
  Duration _accumulated = Duration.zero;

  final GameSoundPlayer _sound = GameSoundPlayer();

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _elapsedTimer?.cancel();
    _windowTimer?.cancel();
    _feedbackTimer?.cancel();
    _sound.dispose();
    super.dispose();
  }

  void _playFeedback(AttentionFeedback feedback) {
    switch (feedback) {
      case AttentionFeedback.correct:
        _sound.correct();
      case AttentionFeedback.mistake:
        _sound.wrong();
      case AttentionFeedback.none:
        break;
    }
  }

  // ── timers ──

  void _startElapsedTimer() {
    _elapsedTimer?.cancel();
    _elapsedTimer = Timer.periodic(const Duration(milliseconds: 250), (_) {
      if (!mounted || _sessionStartedAt == null) return;
      setState(() {
        _elapsed = _accumulated + DateTime.now().difference(_sessionStartedAt!);
      });
    });
  }

  void _stopElapsedTimer() {
    _elapsedTimer?.cancel();
    _elapsedTimer = null;
  }

  void _scheduleWindow(Duration d) {
    _windowTimer?.cancel();
    _windowTimer = Timer(d, () {
      if (!mounted) return;
      context.read<AttentionCubit>().timeout();
    });
  }

  // ── flow ──

  void _beginCountdown() {
    _countdownTimer?.cancel();
    setState(() {
      _showInstructions = false;
      _stage = _Stage.countdown;
      _countdown = 3;
    });
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (_countdown <= 1) {
        t.cancel();
        _startGame();
        return;
      }
      setState(() => _countdown -= 1);
    });
  }

  void _startGame() {
    _accumulated = Duration.zero;
    _sessionStartedAt = DateTime.now();
    context.read<AttentionCubit>().start();
    _startElapsedTimer();
    setState(() => _stage = _Stage.playing);
  }

  void _pause() {
    if (_stage != _Stage.playing) return;
    _stopElapsedTimer();
    _windowTimer?.cancel();
    if (_sessionStartedAt != null) {
      _accumulated += DateTime.now().difference(_sessionStartedAt!);
    }
    _sessionStartedAt = null;
    setState(() => _stage = _Stage.paused);
  }

  void _resume() {
    setState(() => _stage = _Stage.playing);
    _sessionStartedAt = DateTime.now();
    _startElapsedTimer();
    final s = context.read<AttentionCubit>().state;
    if (s is AttentionInProgress && s.feedback == AttentionFeedback.none) {
      _scheduleWindow(s.stimulusWindow);
    }
  }

  void _restart() {
    _resetAll();
    context.read<AttentionCubit>().reset();
    _beginCountdown();
  }

  void _quit() {
    _resetAll();
    context.read<AttentionCubit>().reset();
    // Leave the game entirely, back out to the main screen.
    Navigator.of(context).maybePop();
  }

  void _resetAll() {
    _countdownTimer?.cancel();
    _windowTimer?.cancel();
    _feedbackTimer?.cancel();
    _stopElapsedTimer();
    _trackedRoundIndex = -1;
    _accumulated = Duration.zero;
    _elapsed = Duration.zero;
    _sessionStartedAt = null;
  }

  // ── round handling ──

  void _onNewRound(AttentionInProgress s) {
    if (s.roundIndex == _trackedRoundIndex) return;
    _trackedRoundIndex = s.roundIndex;
    _feedbackTimer?.cancel();
    _scheduleWindow(s.stimulusWindow);
  }

  void _onFeedback() {
    _windowTimer?.cancel();
    _feedbackTimer?.cancel();
    _feedbackTimer = Timer(_kFeedback, () {
      if (!mounted) return;
      context.read<AttentionCubit>().advance();
    });
  }

  void _onTap() {
    if (_stage != _Stage.playing) return;
    context.read<AttentionCubit>().tap();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AttentionCubit, AttentionState>(
      listener: (context, state) {
        switch (state) {
          case AttentionInitial():
            _trackedRoundIndex = -1;
          case AttentionInProgress():
            if (_stage != _Stage.playing && _stage != _Stage.paused) {
              setState(() => _stage = _Stage.playing);
            }
            if (state.feedback == AttentionFeedback.none) {
              _onNewRound(state);
            } else {
              // Only sound on an actual tap (D/G hit or a wrong tap) — never
              // on a timeout where the player correctly withheld the tap.
              if (state.currentRound.tapped == true) {
                _playFeedback(state.feedback);
              }
              _onFeedback();
            }
          case AttentionCompleted():
            _resetAll();
            setState(() => _stage = _Stage.result);
        }
      },
      child: Scaffold(
        backgroundColor: _kBg,
        body: BlocBuilder<AttentionCubit, AttentionState>(
          builder: (context, state) {
            if (_stage == _Stage.result && state is AttentionCompleted) {
              return _ResultBody(
                result: state,
                onPlayAgain: _restart,
                onBack: () => Navigator.of(context).maybePop(),
              );
            }
            return _GameBody(
              stage: _stage,
              state: state,
              elapsed: _elapsed,
              countdown: _countdown,
              showInstructions: _showInstructions,
              onTapScreen: _onTap,
              onPause: _pause,
              onResume: _resume,
              onRestart: _restart,
              onQuit: _quit,
              onStart: _beginCountdown,
              onOpenInstructions: () =>
                  setState(() => _showInstructions = true),
              onCloseInstructions: () =>
                  setState(() => _showInstructions = false),
            );
          },
        ),
      ),
    );
  }
}

// ─── game body ────────────────────────────────────────────────────────────────

class _GameBody extends StatelessWidget {
  const _GameBody({
    required this.stage,
    required this.state,
    required this.elapsed,
    required this.countdown,
    required this.showInstructions,
    required this.onTapScreen,
    required this.onPause,
    required this.onResume,
    required this.onRestart,
    required this.onQuit,
    required this.onStart,
    required this.onOpenInstructions,
    required this.onCloseInstructions,
  });

  final _Stage stage;
  final AttentionState state;
  final Duration elapsed;
  final int countdown;
  final bool showInstructions;
  final VoidCallback onTapScreen;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onRestart;
  final VoidCallback onQuit;
  final VoidCallback onStart;
  final VoidCallback onOpenInstructions;
  final VoidCallback onCloseInstructions;

  @override
  Widget build(BuildContext context) {
    final inProgress = state is AttentionInProgress
        ? state as AttentionInProgress
        : null;
    final feedback = inProgress?.feedback ?? AttentionFeedback.none;
    final dimmed = stage == _Stage.start || stage == _Stage.countdown;

    Color? flashColor;
    if (feedback == AttentionFeedback.correct) flashColor = _kCorrect;
    if (feedback == AttentionFeedback.mistake) flashColor = _kMistake;

    // The paused screen replaces the playfield entirely (see design).
    if (stage == _Stage.paused) {
      return Stack(
        children: [
          _PausedBody(
            onResume: onResume,
            onRestart: onRestart,
            onQuit: onQuit,
            onHowToPlay: onOpenInstructions,
          ),
          if (showInstructions)
            _InstructionsModal(onClose: onCloseInstructions),
        ],
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: stage == _Stage.playing ? onTapScreen : null,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (flashColor != null)
            Positioned.fill(
              child: IgnorePointer(
                child: ColoredBox(color: flashColor.withValues(alpha: 0.16)),
              ),
            ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _TopBar(
                    elapsed: elapsed,
                    paused: false,
                    onPause: onPause,
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _GameHud(
                    correct: inProgress?.correctCount ?? 0,
                    round: (inProgress?.roundIndex ?? 0) + 1,
                    total: inProgress?.totalRounds ?? 25,
                    mistakes: inProgress?.mistakeCount ?? 0,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: _CentralFocus(
                      letter: stage == _Stage.playing
                          ? inProgress?.currentRound.letter
                          : null,
                    ),
                  ),
                ),
                _InstructionText(targets: inProgress?.targetLetters),
                const SizedBox(height: 80),
              ],
            ),
          ),
          if (dimmed)
            const Positioned.fill(
              child: IgnorePointer(
                child: ColoredBox(color: Color(0x66000000)),
              ),
            ),
          if (stage == _Stage.start)
            _StartOverlay(
              onStart: onStart,
              onHowToPlay: onOpenInstructions,
            ),
          if (stage == _Stage.countdown) _CountdownBadge(value: countdown),
          if (showInstructions) _InstructionsModal(onClose: onCloseInstructions),
        ],
      ),
    );
  }
}

// ─── top bar (pause + time) ──────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.elapsed,
    required this.paused,
    required this.onPause,
  });

  final Duration elapsed;
  final bool paused;
  final VoidCallback onPause;

  String _fmt(Duration d) {
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: paused ? null : onPause,
          behavior: HitTestBehavior.opaque,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  paused ? Icons.play_arrow_rounded : Icons.pause_rounded,
                  size: 18,
                  color: _kDark,
                ),
              ),
              if (paused) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB9B9B9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Paused',
                    style: _nunito(
                      size: 14,
                      weight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: _kCardBorder),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Time ',
                style: _nunito(
                  size: 14,
                  weight: FontWeight.w700,
                  color: Colors.black,
                  height: 1.17,
                ),
              ),
              Text(
                _fmt(elapsed),
                style: _nunito(
                  size: 14,
                  weight: FontWeight.w700,
                  color: Colors.black,
                  height: 1.17,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── game HUD (correct / round / mistakes) ───────────────────────────────────

class _GameHud extends StatelessWidget {
  const _GameHud({
    required this.correct,
    required this.round,
    required this.total,
    required this.mistakes,
  });

  final int correct;
  final int round;
  final int total;
  final int mistakes;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _kCardBorder),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HudStat(
            label: 'CORRECT',
            child: Text(
              '$correct',
              style: _nunito(
                size: 16,
                weight: FontWeight.w700,
                color: _kCorrect,
                height: 1.5,
              ),
            ),
          ),
          const _HudDivider(),
          _HudStat(
            label: 'ROUND',
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$round',
                    style: _nunito(
                      size: 16,
                      weight: FontWeight.w700,
                      color: _kDark,
                      height: 1.5,
                    ),
                  ),
                  TextSpan(
                    text: ' /$total',
                    style: _nunito(
                      size: 16,
                      weight: FontWeight.w400,
                      color: _kLabel,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const _HudDivider(),
          _HudStat(
            label: 'MISTAKES',
            child: Text(
              '$mistakes',
              style: _nunito(
                size: 16,
                weight: FontWeight.w700,
                color: _kMistake,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HudStat extends StatelessWidget {
  const _HudStat({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: _nunito(
            size: 10,
            weight: FontWeight.w400,
            color: _kLabel,
            letterSpacing: 1,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 4),
        child,
      ],
    );
  }
}

class _HudDivider extends StatelessWidget {
  const _HudDivider();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 32, color: _kDivider);
  }
}

// ─── central focus area ──────────────────────────────────────────────────────

class _CentralFocus extends StatelessWidget {
  const _CentralFocus({this.letter});
  final String? letter;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 320,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(320, 320),
            painter: const _RingPainter(),
          ),
          Container(
            width: 272,
            height: 272,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: _kRingInnerBorder),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4648D4).withValues(alpha: 0.12),
                  blurRadius: 40,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: letter == null
                ? null
                : Text(
                    letter!,
                    style: _nunito(
                      size: 160,
                      weight: FontWeight.w700,
                      color: _kStimulus,
                      height: 1,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 22;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = (size.shortestSide - strokeWidth) / 2;
    final Rect rect = Rect.fromCircle(center: center, radius: radius);

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = const SweepGradient(
        startAngle: -1.5707963267948966,
        endAngle: 4.71238898038469,
        colors: [
          Color(0xFFC8EFFF),
          Color(0xFF91B8CA),
          _kDark,
          Color(0xFF91B8CA),
          Color(0xFFC8EFFF),
        ],
        stops: [0.0, 0.25, 0.5, 0.75, 1.0],
      ).createShader(rect);

    canvas.drawArc(rect, 0, 6.283185307179586, false, paint);
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) => false;
}

// ─── instruction text ────────────────────────────────────────────────────────

class _InstructionText extends StatelessWidget {
  const _InstructionText({this.targets});
  final List<String>? targets;

  @override
  Widget build(BuildContext context) {
    final letters = targets ?? const ['D', 'G'];
    final base = _nunito(
      size: 16,
      weight: FontWeight.w600,
      color: Colors.black,
      height: 1.5,
    );
    final highlight = _nunito(
      size: 20,
      weight: FontWeight.w700,
      color: _kDark,
      height: 1.5,
    );

    final spans = <TextSpan>[TextSpan(text: 'the letter ', style: base)];
    for (var i = 0; i < letters.length; i++) {
      spans.add(TextSpan(text: letters[i], style: highlight));
      if (i < letters.length - 1) {
        spans.add(TextSpan(text: ' or ', style: base));
      }
    }

    return Column(
      children: [
        Text(
          'Tap the screen as soon as you see',
          textAlign: TextAlign.center,
          style: base,
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: spans),
        ),
      ],
    );
  }
}

// ─── start overlay ───────────────────────────────────────────────────────────

class _StartOverlay extends StatelessWidget {
  const _StartOverlay({required this.onStart, required this.onHowToPlay});
  final VoidCallback onStart;
  final VoidCallback onHowToPlay;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          Center(
            child: GestureDetector(
              onTap: onStart,
              behavior: HitTestBehavior.opaque,
              child: Text(
                'Start',
                style: _nunito(
                  size: 48,
                  weight: FontWeight.w700,
                  color: _kCorrect,
                  height: 1,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 40 + MediaQuery.viewPaddingOf(context).bottom,
              ),
              child: TextButton(
                onPressed: onHowToPlay,
                child: Text(
                  'How to play',
                  style: _nunito(
                    size: 14,
                    weight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── countdown badge ─────────────────────────────────────────────────────────

class _CountdownBadge extends StatelessWidget {
  const _CountdownBadge({required this.value});
  final int value;

  @override
  Widget build(BuildContext context) {
    return Center(
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
          style: _nunito(
            size: 44,
            weight: FontWeight.w700,
            color: _kDark,
            height: 1,
          ),
        ),
      ),
    );
  }
}

// ─── paused body ─────────────────────────────────────────────────────────────

class _PausedBody extends StatelessWidget {
  const _PausedBody({
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
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _TopBar(
              elapsed: Duration.zero,
              paused: true,
              onPause: onResume,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _PauseMenuButton(
                      icon: Icons.play_arrow_rounded,
                      label: 'Resume',
                      onTap: onResume,
                    ),
                    const SizedBox(height: 16),
                    _PauseMenuButton(
                      icon: Icons.refresh_rounded,
                      label: 'Restart',
                      onTap: onRestart,
                    ),
                    const SizedBox(height: 16),
                    _PauseMenuButton(
                      icon: Icons.close_rounded,
                      label: 'Quit',
                      onTap: onQuit,
                    ),
                    const SizedBox(height: 16),
                    _PauseMenuButton(
                      icon: Icons.help_outline_rounded,
                      label: 'How To Play',
                      onTap: onHowToPlay,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PauseMenuButton extends StatelessWidget {
  const _PauseMenuButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: _kDark,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(width: 16),
            Text(
              label,
              style: _nunito(
                size: 16,
                weight: FontWeight.w600,
                color: Colors.white,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── instructions modal ──────────────────────────────────────────────────────

class _InstructionsModal extends StatelessWidget {
  const _InstructionsModal({required this.onClose});
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onClose,
        child: ColoredBox(
          color: Colors.black.withValues(alpha: 0.45),
          child: Center(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Letters will appear on the screen one by one. '
                      'Tap the button quickly when you see D or G. '
                      'Do not tap for any other letter. Stay focused and '
                      'complete all 25 rounds with as few mistakes as possible.',
                      textAlign: TextAlign.center,
                      style: _nunito(
                        size: 18,
                        weight: FontWeight.w500,
                        color: Colors.black,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: onClose,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: _kDark,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          'Got it',
                          style: _nunito(
                            size: 16,
                            weight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── result body ─────────────────────────────────────────────────────────────

class _ResultBody extends StatelessWidget {
  const _ResultBody({
    required this.result,
    required this.onPlayAgain,
    required this.onBack,
  });

  final AttentionCompleted result;
  final VoidCallback onPlayAgain;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final pct = (result.accuracy * 100).round();

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  Text(
                    'Challenge Complete!',
                    style: _nunito(
                      size: 28,
                      weight: FontWeight.w700,
                      color: _kDark,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sustained Attention & Response Control',
                    textAlign: TextAlign.center,
                    style: _nunito(
                      size: 13,
                      weight: FontWeight.w500,
                      color: const Color(0xFF41484B),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 28),
                  _ScoreCircle(
                    correct: result.correctCount,
                    total: result.totalRounds,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '$pct% accuracy',
                    style: _nunito(
                      size: 16,
                      weight: FontWeight.w600,
                      color: _kDark,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          label: 'MISTAKES',
                          value: '${result.mistakeCount}',
                          valueColor: _kMistake,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          label: 'AVG REACTION',
                          value: result.avgReactionTimeMs == 0
                              ? '—'
                              : '${result.avgReactionTimeMs} ms',
                          valueColor: _kDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          label: 'BEST REACTION',
                          value: result.bestReactionTimeMs == 0
                              ? '—'
                              : '${result.bestReactionTimeMs} ms',
                          valueColor: _kCorrect,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              24,
              0,
              24,
              MediaQuery.viewPaddingOf(context).bottom + 20,
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton(
                    onPressed: onPlayAgain,
                    style: FilledButton.styleFrom(
                      backgroundColor: _kDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'Play Again',
                      style: _nunito(
                        size: 16,
                        weight: FontWeight.w700,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: onBack,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _kDark,
                      side: const BorderSide(color: _kDark, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'Back',
                      style: _nunito(
                        size: 16,
                        weight: FontWeight.w700,
                        color: _kDark,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreCircle extends StatelessWidget {
  const _ScoreCircle({required this.correct, required this.total});
  final int correct;
  final int total;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 140,
      child: CustomPaint(
        painter: _ScoreCirclePainter(),
        child: Center(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$correct',
                  style: _nunito(
                    size: 34,
                    weight: FontWeight.w700,
                    color: Colors.white,
                    height: 1,
                  ),
                ),
                TextSpan(
                  text: '/$total',
                  style: _nunito(
                    size: 18,
                    weight: FontWeight.w500,
                    color: Colors.white,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ScoreCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2;
    canvas.drawCircle(c, r, Paint()..color = _kDark);
    canvas.drawCircle(c, r * 0.70, Paint()..color = const Color(0xFF021A24));
  }

  @override
  bool shouldRepaint(_ScoreCirclePainter _) => false;
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _kDark.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: _nunito(
              size: 9,
              weight: FontWeight.w700,
              color: _kLabel,
              letterSpacing: 0.5,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: _nunito(
                size: 18,
                weight: FontWeight.w700,
                color: valueColor,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
