import 'package:audioplayers/audioplayers.dart';

/// Plays the shared correct / wrong feedback sounds used across the games.
///
/// A single [AudioPlayer] is reused and the currently-playing clip is stopped
/// before a new one starts, so each answer gets its own distinct sound.
class GameSoundPlayer {
  GameSoundPlayer() {
    _player.setReleaseMode(ReleaseMode.stop);
  }

  static const String _correctAsset = 'audio/successed.mp3';
  static const String _wrongAsset = 'audio/wronganswer.mp3';

  final AudioPlayer _player = AudioPlayer();

  Future<void> correct() => _play(_correctAsset);

  Future<void> wrong() => _play(_wrongAsset);

  Future<void> _play(String asset) async {
    try {
      await _player.stop();
      await _player.play(AssetSource(asset));
    } catch (_) {
      // Audio is non-critical; never let a playback error break gameplay.
    }
  }

  void dispose() => _player.dispose();
}
