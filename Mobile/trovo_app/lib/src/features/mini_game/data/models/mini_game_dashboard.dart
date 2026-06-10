import 'mini_game_record.dart';
import 'mini_game_stats.dart';

/// Composite payload for `GET /api/mini-game/dashboard`.
///
/// The dashboard typically bundles aggregate stats with the most recent
/// sessions. Parsed defensively so partial payloads still render.
class MiniGameDashboard {
  const MiniGameDashboard({required this.stats, required this.recent});

  final MiniGameStats stats;
  final List<MiniGameRecord> recent;

  factory MiniGameDashboard.fromJson(Map<String, dynamic> json) {
    final root = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;

    final statsJson = root['stats'] ?? root['statistics'];
    final stats = statsJson is Map<String, dynamic>
        ? MiniGameStats.fromJson(statsJson)
        : MiniGameStats.fromJson(root);

    final recentSource =
        root['recent'] ?? root['recent_games'] ?? root['history'] ?? root['records'];

    return MiniGameDashboard(
      stats: stats,
      recent: MiniGameRecord.listFromEnvelope(recentSource),
    );
  }
}
