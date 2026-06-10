import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../home/presentation/home_screen.dart';

const Color kPageBg = Color(0xFFF2F2F2);
const Color kBasis = Color(0xFF042F40);
const Color kSoftText = Color(0x99042F40);
const double kBottomNavHeight = 96;
const double kBottomNavTopOverlap = 48;

class TimeFocusScreen extends StatefulWidget {
  const TimeFocusScreen({super.key, this.embedded = false});

  /// When hosted inside the app shell, the screen hides its own bottom
  /// navigation bar so the shell's shared nav is used instead.
  final bool embedded;

  @override
  State<TimeFocusScreen> createState() => _TimeFocusScreenState();
}

class _TimeFocusScreenState extends State<TimeFocusScreen>
    with WidgetsBindingObserver {
  int _selectedMinutes = 25;
  bool _muteNotifications = true;
  bool _backgroundSound = false;

  Duration _remaining = const Duration(minutes: 25);
  bool _running = false;
  Timer? _ticker;
  // Absolute moment the countdown should end. Computing the remaining time
  // from this wall-clock target keeps the timer accurate even when the OS
  // suspends the app while it is in the background.
  DateTime? _endAt;
  final AudioPlayer _alarm = AudioPlayer();

  Duration get _total => Duration(minutes: _selectedMinutes);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _ticker?.cancel();
    _alarm.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Re-sync as soon as we come back so the time spent in the background
    // is reflected (and the alarm fires if it already elapsed).
    if (state == AppLifecycleState.resumed) {
      _syncFromWallClock();
    }
  }

  Future<void> _playAlarm() async {
    try {
      await _alarm.stop();
      await _alarm.play(AssetSource('audio/alarm-clock.mp3'));
    } catch (_) {
      // Audio is non-critical; ignore playback failures.
    }
  }

  void _syncFromWallClock() {
    if (!_running || _endAt == null) return;
    final remaining = _endAt!.difference(DateTime.now());
    if (remaining <= Duration.zero) {
      _finish();
    } else {
      setState(() => _remaining = remaining);
    }
  }

  void _finish() {
    _ticker?.cancel();
    _endAt = null;
    _playAlarm();
    if (mounted) {
      setState(() {
        _remaining = Duration.zero;
        _running = false;
      });
    }
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      final remaining = _endAt == null
          ? Duration.zero
          : _endAt!.difference(DateTime.now());
      if (remaining <= Duration.zero) {
        _finish();
      } else {
        setState(() => _remaining = remaining);
      }
    });
  }

  void _selectMinutes(int minutes) {
    _ticker?.cancel();
    _endAt = null;
    setState(() {
      _selectedMinutes = minutes;
      _remaining = Duration(minutes: minutes);
      _running = false;
    });
  }

  void _toggleTimer() {
    // Restart once the countdown has finished.
    if (_remaining <= Duration.zero) {
      setState(() => _remaining = _total);
    }
    if (_running) {
      // Pause: freeze on the current remaining time.
      _ticker?.cancel();
      _endAt = null;
      setState(() => _running = false);
    } else {
      // Start / resume against an absolute end time.
      _endAt = DateTime.now().add(_remaining);
      setState(() => _running = true);
      _startTicker();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double bottomPadding =
        24 +
        kBottomNavHeight +
        kBottomNavTopOverlap +
        MediaQuery.of(context).padding.bottom;

    final double progress = _total.inSeconds == 0
        ? 0
        : _remaining.inSeconds / _total.inSeconds;

    return Scaffold(
      backgroundColor: kPageBg,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 430),
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(24, 24, 24, bottomPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const _HeaderSection(),
                      const SizedBox(height: 24),
                      _TimerSection(
                        remaining: _remaining,
                        progress: progress,
                        running: _running,
                        onPressed: _toggleTimer,
                      ),
                      const SizedBox(height: 24),
                      _DurationChips(
                        selectedMinutes: _selectedMinutes,
                        onSelected: _selectMinutes,
                      ),
                      const SizedBox(height: 24),
                      _FocusSettingsCard(
                        muteNotifications: _muteNotifications,
                        backgroundSound: _backgroundSound,
                        onMuteToggle: (value) {
                          setState(() => _muteNotifications = value);
                        },
                        onSoundToggle: (value) {
                          setState(() => _backgroundSound = value);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (!widget.embedded)
              const Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _BottomNavigationBar(),
              ),
          ],
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Stay present',
          style: TextStyle(
            color: kBasis,
            fontSize: 30,
            fontWeight: FontWeight.w800,
            height: 1.2,
            letterSpacing: -0.75,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          'boost your concentration',
          style: TextStyle(
            color: kSoftText,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _TimerSection extends StatelessWidget {
  const _TimerSection({
    required this.remaining,
    required this.progress,
    required this.running,
    required this.onPressed,
  });

  final Duration remaining;
  final double progress;
  final bool running;
  final VoidCallback onPressed;

  String _fmt(Duration d) {
    // Round up so a fractional wall-clock remainder still reads cleanly
    // (e.g. 24:59.3 shows as 25:00, then ticks down to 24:59).
    final totalSeconds = (d.inMilliseconds / 1000).ceil().clamp(0, 1 << 31);
    final m = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final s = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 288,
      height: 288,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(260, 260),
            painter: _TimerRingPainter(
              trackColor: const Color(0xFFE6E8EA),
              progressColor: kBasis,
              strokeWidth: 10,
              progress: progress.clamp(0.0, 1.0),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _fmt(remaining),
                style: const TextStyle(
                  color: kBasis,
                  fontSize: 60,
                  fontWeight: FontWeight.w800,
                  height: 1,
                  letterSpacing: -3,
                ),
              ),
              const SizedBox(height: 16),
              _PlayButton(running: running, onPressed: onPressed),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({required this.running, required this.onPressed});

  final bool running;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 64,
        height: 64,
        decoration: const BoxDecoration(
          color: kBasis,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 12,
              offset: Offset(0, 8),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(
          running ? Icons.pause_rounded : Icons.play_arrow_rounded,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}

class _DurationChips extends StatelessWidget {
  const _DurationChips({
    required this.selectedMinutes,
    required this.onSelected,
  });

  final int selectedMinutes;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _DurationChip(
          label: '15 min',
          selected: selectedMinutes == 15,
          onTap: () => onSelected(15),
        ),
        const SizedBox(width: 12),
        _DurationChip(
          label: '25 min',
          selected: selectedMinutes == 25,
          onTap: () => onSelected(25),
        ),
        const SizedBox(width: 12),
        _DurationChip(
          label: '45 min',
          selected: selectedMinutes == 45,
          onTap: () => onSelected(45),
        ),
      ],
    );
  }
}

class _DurationChip extends StatelessWidget {
  const _DurationChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color bgColor = selected ? kBasis : const Color(0xFFEDEEEF);
    final Color fgColor = selected ? const Color(0xFFF2F2F2) : kBasis;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(999),
          boxShadow: selected
              ? const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: fgColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

class _FocusSettingsCard extends StatelessWidget {
  const _FocusSettingsCard({
    required this.muteNotifications,
    required this.backgroundSound,
    required this.onMuteToggle,
    required this.onSoundToggle,
  });

  final bool muteNotifications;
  final bool backgroundSound;
  final ValueChanged<bool> onMuteToggle;
  final ValueChanged<bool> onSoundToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F5),
        borderRadius: BorderRadius.circular(48),
      ),
      child: Column(
        children: [
          _SettingRow(
            icon: Icons.notifications_off_rounded,
            title: 'Mute notifications',
            subtitle: 'Stay away from digital noise',
            enabled: muteNotifications,
            onToggle: onMuteToggle,
          ),
          const SizedBox(height: 24),
          _SettingRow(
            icon: Icons.spa_rounded,
            title: 'Background sound',
            subtitle: 'Soft rain in the forest',
            enabled: backgroundSound,
            onToggle: onSoundToggle,
            activeColor: const Color(0xFFE1E3E4),
          ),
        ],
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  const _SettingRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.enabled,
    required this.onToggle,
    this.activeColor,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool enabled;
  final ValueChanged<bool> onToggle;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    final Color toggleColor = enabled
        ? kBasis
        : (activeColor ?? const Color(0xFFE1E3E4));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFC8EFFF),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(icon, color: kBasis, size: 20),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: kBasis,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: kSoftText,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                  ),
                ),
              ],
            ),
          ],
        ),
        GestureDetector(
          onTap: () => onToggle(!enabled),
          child: _TogglePill(enabled: enabled, backgroundColor: toggleColor),
        ),
      ],
    );
  }
}

class _TogglePill extends StatelessWidget {
  const _TogglePill({required this.enabled, required this.backgroundColor});

  final bool enabled;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 48,
      height: 24,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Align(
        alignment: enabled ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 16,
          height: 16,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SizedBox(
        height: kBottomNavHeight + kBottomNavTopOverlap,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: kBottomNavHeight,
                decoration: const BoxDecoration(
                  color: kBasis,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(48)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x66000000),
                      blurRadius: 16,
                      offset: Offset(0, -12),
                    ),
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(32, 18, 32, 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _NavIcon(
                      iconAsset: 'assets/images/home_icon_home.svg',
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute<void>(
                            builder: (_) => const HomeScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 24),
                    const _NavIcon(
                      iconAsset: 'assets/images/home_icon_games.svg',
                    ),
                    const Spacer(),
                    const SizedBox(width: 64, height: 16),
                    const Spacer(),
                    const _NavIcon(
                      iconAsset: 'assets/images/home_icon_library.svg',
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Center(
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: kPageBg,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x1A000000),
                        blurRadius: 16,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 22,
                    height: 26,
                    child: SvgPicture.asset(
                      'assets/images/home_icon_timer.svg',
                      colorFilter: const ColorFilter.mode(
                        kBasis,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  const _NavIcon({required this.iconAsset, this.onTap});

  final String iconAsset;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: InkResponse(
        onTap: onTap,
        radius: 28,
        child: Center(
          child: SvgPicture.asset(
            iconAsset,
            colorFilter: const ColorFilter.mode(
              Color(0xFFF2F2F2),
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}

class _TimerRingPainter extends CustomPainter {
  const _TimerRingPainter({
    required this.trackColor,
    required this.progressColor,
    required this.strokeWidth,
    required this.progress,
  });

  final Color trackColor;
  final Color progressColor;
  final double strokeWidth;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = (size.shortestSide - strokeWidth) / 2;
    final Rect rect = Rect.fromCircle(center: center, radius: radius);

    final Paint trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    final Paint progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const double startAngle = -1.5707963267948966;
    final double sweepAngle = 6.283185307179586 * progress.clamp(0.0, 1.0);
    canvas.drawArc(rect, startAngle, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant _TimerRingPainter oldDelegate) {
    return oldDelegate.trackColor != trackColor ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.progress != progress;
  }
}
