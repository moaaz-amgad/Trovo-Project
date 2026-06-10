import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/mini_game_dashboard.dart';
import '../models/mini_game_record.dart';
import '../models/mini_game_session.dart';
import '../models/mini_game_stats.dart';

abstract class MiniGameRepository {
  Future<Either<Failure, MiniGameRecord>> submitSession(
    MiniGameSession session,
  );

  Future<Either<Failure, List<MiniGameRecord>>> fetchHistory();

  Future<Either<Failure, MiniGameStats>> fetchStats();

  Future<Either<Failure, MiniGameDashboard>> fetchDashboard();
}
