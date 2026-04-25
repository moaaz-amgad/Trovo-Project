import 'package:flutter/material.dart';

class PauseMenu extends StatelessWidget {
  final VoidCallback onResume;
  final VoidCallback onRestart;
  final VoidCallback onQuit;

  const PauseMenu({
    Key? key,
    required this.onResume,
    required this.onRestart,
    required this.onQuit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.6),
      child: Center(
        child: Container(
          width: 300,
          decoration: BoxDecoration(
            color: const Color(0xFF4A3E38),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildMenuItem(
                icon: Icons.play_arrow,
                text: 'Resume',
                onTap: onResume,
                isPrimary: true,
              ),
              _buildDivider(),
              _buildMenuItem(
                icon: Icons.refresh,
                text: 'Restart',
                onTap: onRestart,
              ),
              _buildDivider(),
              _buildMenuItem(
                icon: Icons.volume_up,
                text: 'Mute Sound',
                onTap: () {
                  // TODO: Implement sound toggle
                },
              ),
              _buildDivider(),
              _buildMenuItem(
                icon: Icons.music_note,
                text: 'Mute Music',
                onTap: () {
                  // TODO: Implement music toggle
                },
              ),
              _buildDivider(),
              _buildMenuItem(
                icon: Icons.close,
                text: 'Quit',
                onTap: onQuit,
              ),
              _buildDivider(),
              _buildMenuItem(
                icon: Icons.help_outline,
                text: 'How To Play',
                onTap: () {
                  // TODO: Implement how to play dialog
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: isPrimary ? const Color(0xFF30B0D6) : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: isPrimary ? Colors.white : const Color(0xFF30B0D6),
              size: 28,
            ),
            const SizedBox(width: 16),
            Text(
              text,
              style: TextStyle(
                color: isPrimary ? Colors.white : const Color(0xFF30B0D6),
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: const Color(0xFF2E2421),
    );
  }
}
