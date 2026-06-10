import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:trovo_app/src/core/di/injection_container.dart';
import 'package:trovo_app/src/core/services/game_sound_player.dart';
import '../../data/models/nl_round.dart';
import '../cubit/nl_cubit.dart';
import '../cubit/nl_state.dart';

// ─── constants ───────────────────────────────────────────────────────────────

const Color _kBg = Color(0xFFF2F2F2);
const Color _kDark = Color(0xFF042F40);
const Color _kAmber = Color(0xFFFFC107);
const Color _kPill = Color(0xFFD9D9D9);
const Color _kCorrect = Color(0xFF2EC451);
const Color _kWrong = Color(0xFFC42C2F);
const String _kFont = 'Nunito';

const Duration _kFeedback = Duration(milliseconds: 380);

enum _Stage { start, countdown, playing, paused, result }

// ─── entry point ─────────────────────────────────────────────────────────────

class NlScreen extends StatelessWidget {
  const NlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NlCubit>(
      create: (_) => sl<NlCubit>(),
      child: const _NlView(),
    );
  }
}

// ─── stateful view ───────────────────────────────────────────────────────────

class _NlView extends StatefulWidget {
  const _NlView();

  @override
  State<_NlView> createState() => _NlViewState();
}

class _NlViewState extends State<_NlView> with TickerProviderStateMixin {
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

  late final AnimationController _progressCtrl;
  final GameSoundPlayer _sound = GameSoundPlayer();

  @override
  void initState() {
    super.initState();
    _progressCtrl = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _elapsedTimer?.cancel();
    _roundTimer?.cancel();
    _feedbackTimer?.cancel();
    _progressCtrl.dispose();
    _sound.dispose();
    super.dispose();
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

  void _scheduleTimeout(Duration d) {
    _roundTimer?.cancel();
    _roundTimer = Timer(d, () {
      if (!mounted) return;
      context.read<NlCubit>().timeout();
    });
  }

  // ── flow ──

  void _beginCountdown() {
    _countdownTimer?.cancel();
    setState(() {
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
    context.read<NlCubit>().start(level: _selectedLevel);
    _startElapsedTimer();
    setState(() => _stage = _Stage.playing);
  }

  void _pause() {
    _stopElapsedTimer();
    _roundTimer?.cancel();
    _progressCtrl.stop();
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
    final s = context.read<NlCubit>().state;
    if (s is NlInProgress && s.feedback == NlFeedback.none) {
      final remaining = Duration(
        milliseconds:
            (s.roundTimeLimit.inMilliseconds * (1 - _progressCtrl.value))
                .round(),
      );
      _scheduleTimeout(remaining);
      _progressCtrl.forward(from: _progressCtrl.value);
    }
  }

  void _restart() {
    _resetAll();
    context.read<NlCubit>().reset();
    _beginCountdown();
  }

  void _quit() {
    _resetAll();
    context.read<NlCubit>().reset();
    // Leave the game entirely, back out to the main screen.
    Navigator.of(context).maybePop();
  }

  void _resetAll() {
    _countdownTimer?.cancel();
    _roundTimer?.cancel();
    _feedbackTimer?.cancel();
    _stopElapsedTimer();
    _progressCtrl
      ..stop()
      ..value = 0;
    _trackedRoundIndex = -1;
    _accumulated = Duration.zero;
    _elapsed = Duration.zero;
    _sessionStartedAt = null;
  }

  // ── round handling ──

  void _onNewRound(NlInProgress s) {
    if (s.roundIndex == _trackedRoundIndex) return;
    _trackedRoundIndex = s.roundIndex;
    _feedbackTimer?.cancel();
    _roundTimer?.cancel();
    _progressCtrl
      ..stop()
      ..duration = s.roundTimeLimit
      ..value = 0
      ..forward();
    _scheduleTimeout(s.roundTimeLimit);
  }

  void _onFeedback() {
    _roundTimer?.cancel();
    _progressCtrl.stop();
    _feedbackTimer?.cancel();
    _feedbackTimer = Timer(_kFeedback, () {
      if (!mounted) return;
      context.read<NlCubit>().advance();
    });
  }

  void _onAnswer(bool yes) {
    if (_stage != _Stage.playing) return;
    context.read<NlCubit>().answer(answerYes: yes);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NlCubit, NlState>(
      listener: (context, state) {
        switch (state) {
          case NlInitial():
            _trackedRoundIndex = -1;
            _accumulated = Duration.zero;
            _elapsed = Duration.zero;
            _sessionStartedAt = null;
            _stopElapsedTimer();
            _progressCtrl.value = 0;
          case NlInProgress():
            if (_stage != _Stage.playing && _stage != _Stage.paused) {
              setState(() => _stage = _Stage.playing);
            }
            if (state.feedback == NlFeedback.none) {
              _onNewRound(state);
            } else {
              if (state.feedback == NlFeedback.correct) {
                _sound.correct();
              } else {
                _sound.wrong();
              }
              _onFeedback();
            }
          case NlCompleted():
            _resetAll();
            setState(() => _stage = _Stage.result);
        }
      },
      child: Scaffold(
        backgroundColor: _kBg,
        body: BlocBuilder<NlCubit, NlState>(
          builder: (context, state) {
            if (_stage == _Stage.result && state is NlCompleted) {
              return _ResultBody(
                result: state,
                onPlayAgain: _restart,
                onBack: () => context.pop(),
              );
            }
            return _GameBody(
              stage: _stage,
              cubitState: state,
              elapsed: _elapsed,
              countdown: _countdown,
              progress: _progressCtrl,
              onPause: _pause,
              onResume: _resume,
              onRestart: _restart,
              onQuit: _quit,
              onStart: _beginCountdown,
              onYes: () => _onAnswer(true),
              onNo: () => _onAnswer(false),
            );
          },
        ),
      ),
    );
  }
}

// ─── game body ───────────────────────────────────────────────────────────────

class _GameBody extends StatelessWidget {
  const _GameBody({
    required this.stage,
    required this.cubitState,
    required this.elapsed,
    required this.countdown,
    required this.progress,
    required this.onPause,
    required this.onResume,
    required this.onRestart,
    required this.onQuit,
    required this.onStart,
    required this.onYes,
    required this.onNo,
  });

  final _Stage stage;
  final NlState cubitState;
  final Duration elapsed;
  final int countdown;
  final AnimationController progress;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onRestart;
  final VoidCallback onQuit;
  final VoidCallback onStart;
  final VoidCallback onYes;
  final VoidCallback onNo;

  @override
  Widget build(BuildContext context) {
    NlRound? round;
    int score = 0;
    NlFeedback feedback = NlFeedback.none;
    if (cubitState is NlInProgress) {
      final s = cubitState as NlInProgress;
      round = s.currentRound;
      score = s.score;
      feedback = s.feedback;
    }

    final canAnswer =
        stage == _Stage.playing && round != null && feedback == NlFeedback.none;
    final dimmed =
        stage == _Stage.countdown || stage == _Stage.paused;

    Color? flashColor;
    if (feedback == NlFeedback.correct) flashColor = _kCorrect;
    if (feedback == NlFeedback.wrong || feedback == NlFeedback.timeout) {
      flashColor = _kWrong;
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        if (flashColor != null)
          Positioned.fill(
            child: IgnorePointer(
              child: ColoredBox(color: flashColor.withValues(alpha: 0.18)),
            ),
          ),
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
                  onPause: onPause,
                ),
              ),
              const SizedBox(height: 6),
              _ProgressBar(controller: progress, visible: stage == _Stage.playing && round != null),
              const SizedBox(height: 24),
              Expanded(
                child: Center(
                  child: _CardArea(round: round, stage: stage),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 40),
                child: _AnswerRow(enabled: canAnswer, onYes: onYes, onNo: onNo),
              ),
            ],
          ),
        ),
        if (dimmed) const _Scrim(),
        if (stage == _Stage.start) _StartOverlay(onStart: onStart),
        if (stage == _Stage.countdown) _CountdownOverlay(value: countdown),
        if (stage == _Stage.paused)
          _PauseMenu(
            onResume: onResume,
            onRestart: onRestart,
            onQuit: onQuit,
          ),
      ],
    );
  }
}

// ─── top bar ─────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.score,
    required this.time,
    required this.paused,
    required this.onPause,
  });

  final int score;
  final Duration time;
  final bool paused;
  final VoidCallback onPause;

  String _fmt(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onPause,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _kPill,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              paused ? Icons.play_arrow_rounded : Icons.pause_rounded,
              color: _kDark,
              size: 22,
            ),
          ),
        ),
        const Spacer(),
        _Chip(label: 'TIME', value: _fmt(time)),
        const SizedBox(width: 10),
        _Chip(label: 'SCORE', value: '$score'),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: _kPill,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _kDark,
              fontFamily: _kFont,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: _kDark,
              fontFamily: _kFont,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── progress bar ────────────────────────────────────────────────────────────

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.controller, required this.visible});
  final AnimationController controller;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox(height: 4);
    return AnimatedBuilder(
      animation: controller,
      builder: (_, _) {
        final v = 1 - controller.value;
        final color = v > 0.5 ? _kCorrect : v > 0.25 ? _kAmber : _kWrong;
        return LinearProgressIndicator(
          value: v,
          backgroundColor: _kPill,
          valueColor: AlwaysStoppedAnimation(color),
          minHeight: 4,
        );
      },
    );
  }
}

// ─── card area ───────────────────────────────────────────────────────────────

class _CardArea extends StatelessWidget {
  const _CardArea({required this.round, required this.stage});
  final NlRound? round;
  final _Stage stage;

  @override
  Widget build(BuildContext context) {
    final showContent = round != null && stage != _Stage.start;

    final numberLabel = showContent ? '${round!.number}' : '?';
    final letterLabel = showContent ? round!.letter.toUpperCase() : '?';

    final showNumberRule = showContent && (round!.rule == NlRule.a || round!.rule == NlRule.c);
    final showLetterRule = showContent && (round!.rule == NlRule.b || round!.rule == NlRule.c);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // top speech bubble (number rule)
        if (showNumberRule) ...[
          _SpeechBubble(text: 'Is the number even?', pointDown: false),
          const SizedBox(height: 4),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _GameBox(value: numberLabel),
            const SizedBox(width: 20),
            _GameBox(value: letterLabel),
          ],
        ),
        if (showLetterRule) ...[
          const SizedBox(height: 4),
          _SpeechBubble(text: 'Is the letter a vowel?', pointDown: true),
        ],
      ],
    );
  }
}

class _GameBox extends StatelessWidget {
  const _GameBox({required this.value});
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 110,
      decoration: BoxDecoration(
        color: _kDark,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          value,
          style: const TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.w800,
            color: _kAmber,
            fontFamily: _kFont,
          ),
        ),
      ),
    );
  }
}

class _SpeechBubble extends StatelessWidget {
  const _SpeechBubble({required this.text, required this.pointDown});
  final String text;
  final bool pointDown;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BubblePainter(pointDown: pointDown),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        constraints: const BoxConstraints(maxWidth: 240),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: _kDark,
            fontFamily: _kFont,
          ),
        ),
      ),
    );
  }
}

class _BubblePainter extends CustomPainter {
  const _BubblePainter({required this.pointDown});
  final bool pointDown;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = _kPill;
    const r = 12.0;
    final rect = RRect.fromLTRBR(0, 0, size.width, size.height, const Radius.circular(r));
    canvas.drawRRect(rect, paint);

    // small triangle pointer
    const tw = 10.0;
    const th = 7.0;
    final cx = size.width / 2;
    final path = Path();
    if (pointDown) {
      path
        ..moveTo(cx - tw, size.height)
        ..lineTo(cx + tw, size.height)
        ..lineTo(cx, size.height + th)
        ..close();
    } else {
      path
        ..moveTo(cx - tw, 0)
        ..lineTo(cx + tw, 0)
        ..lineTo(cx, -th)
        ..close();
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_BubblePainter old) => old.pointDown != pointDown;
}

// ─── answer row ──────────────────────────────────────────────────────────────

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
      children: [
        Expanded(child: _AnswerBtn(label: 'NO', onTap: enabled ? onNo : null)),
        const SizedBox(width: 20),
        Expanded(child: _AnswerBtn(label: 'YES', onTap: enabled ? onYes : null)),
      ],
    );
  }
}

class _AnswerBtn extends StatelessWidget {
  const _AnswerBtn({required this.label, required this.onTap});
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final active = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 54,
        decoration: BoxDecoration(
          color: active ? _kDark : _kDark.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(27),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: active ? Colors.white : Colors.white.withValues(alpha: 0.4),
              fontFamily: _kFont,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── overlays ────────────────────────────────────────────────────────────────

class _Scrim extends StatelessWidget {
  const _Scrim();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ColoredBox(color: Colors.black.withValues(alpha: 0.45)),
    );
  }
}

class _StartOverlay extends StatelessWidget {
  const _StartOverlay({required this.onStart});
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ColoredBox(
        color: _kDark.withValues(alpha: 0.72),
        child: Center(
          child: GestureDetector(
            onTap: onStart,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Number &\nLetter Challenge',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontFamily: _kFont,
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  decoration: BoxDecoration(
                    color: _kBg,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    'Start',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: _kDark,
                      fontFamily: _kFont,
                    ),
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

class _CountdownOverlay extends StatelessWidget {
  const _CountdownOverlay({required this.value});
  final int value;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ColoredBox(
        color: Colors.black.withValues(alpha: 0.45),
        child: Center(
          child: Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$value',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w800,
                  color: _kDark,
                  fontFamily: _kFont,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── pause menu ──────────────────────────────────────────────────────────────

class _PauseMenu extends StatelessWidget {
  const _PauseMenu({
    required this.onResume,
    required this.onRestart,
    required this.onQuit,
  });

  final VoidCallback onResume;
  final VoidCallback onRestart;
  final VoidCallback onQuit;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ColoredBox(
        color: Colors.black.withValues(alpha: 0.45),
        child: Center(
          child: Container(
            width: 300,
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
            decoration: BoxDecoration(
              color: _kDark,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Paused',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontFamily: _kFont,
                  ),
                ),
                const SizedBox(height: 24),
                _MenuBtn(icon: Icons.play_arrow_rounded, label: 'Resume', onTap: onResume),
                const SizedBox(height: 12),
                _MenuBtn(icon: Icons.restart_alt_rounded, label: 'Restart', onTap: onRestart),
                const SizedBox(height: 12),
                _MenuBtn(icon: Icons.close_rounded, label: 'Quit', onTap: onQuit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuBtn extends StatelessWidget {
  const _MenuBtn({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: _kDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF82979F), width: 1),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontFamily: _kFont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── result screen ───────────────────────────────────────────────────────────

class _ResultBody extends StatelessWidget {
  const _ResultBody({
    required this.result,
    required this.onPlayAgain,
    required this.onBack,
  });

  final NlCompleted result;
  final VoidCallback onPlayAgain;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final pct = (result.accuracy * 100).round();
    final maxScore = result.totalRounds * 10;

    return Scaffold(
      backgroundColor: _kBg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    const Text(
                      'Challenge Complete!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: _kDark,
                        fontFamily: _kFont,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Working Memory & Cognitive Flexibility',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF41484B),
                        fontFamily: _kFont,
                      ),
                    ),
                    const SizedBox(height: 28),
                    _ScoreCircle(score: result.score, maxScore: maxScore),
                    const SizedBox(height: 8),
                    Text(
                      '$pct% accuracy',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: _kDark,
                        fontFamily: _kFont,
                      ),
                    ),
                    const SizedBox(height: 28),
                    _RuleBreakdown(
                      ruleA: result.ruleAAccuracy,
                      ruleB: result.ruleBAccuracy,
                      ruleC: result.ruleCAccuracy,
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
                      child: const Text(
                        'Play Again',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: _kFont,
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
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: _kFont,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScoreCircle extends StatelessWidget {
  const _ScoreCircle({required this.score, required this.maxScore});
  final int score;
  final int maxScore;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 130,
      child: CustomPaint(
        painter: _CirclePainter(),
        child: Center(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$score',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    fontFamily: _kFont,
                  ),
                ),
                TextSpan(
                  text: '/$maxScore',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: _kFont,
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

class _CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2;
    canvas.drawCircle(c, r, Paint()..color = _kDark);
    canvas.drawCircle(c, r * 0.70, Paint()..color = const Color(0xFF021A24));
  }

  @override
  bool shouldRepaint(_CirclePainter _) => false;
}

class _RuleBreakdown extends StatelessWidget {
  const _RuleBreakdown({
    required this.ruleA,
    required this.ruleB,
    required this.ruleC,
  });

  final double ruleA;
  final double ruleB;
  final double ruleC;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _kDark.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rule Breakdown',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: _kDark,
              fontFamily: _kFont,
            ),
          ),
          const SizedBox(height: 16),
          _RuleRow(label: 'Rule A — Even number?', pct: ruleA),
          const SizedBox(height: 12),
          _RuleRow(label: 'Rule B — Vowel letter?', pct: ruleB),
          const SizedBox(height: 12),
          _RuleRow(label: 'Rule C — Both?', pct: ruleC),
        ],
      ),
    );
  }
}

class _RuleRow extends StatelessWidget {
  const _RuleRow({required this.label, required this.pct});
  final String label;
  final double pct;

  Color get _color {
    if (pct >= 0.75) return _kCorrect;
    if (pct >= 0.5) return _kAmber;
    return _kWrong;
  }

  @override
  Widget build(BuildContext context) {
    final pctInt = (pct * 100).round();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF41484B),
                fontFamily: _kFont,
              ),
            ),
            Text(
              '$pctInt%',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: _color,
                fontFamily: _kFont,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: pct,
            backgroundColor: _kPill,
            valueColor: AlwaysStoppedAnimation(_color),
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}

