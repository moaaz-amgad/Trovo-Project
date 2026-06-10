import '../models/stroop_round.dart';

abstract class StroopRepository {
  StroopRound nextRound({required int level, required int index});
  int totalRoundsForSession();
  Duration roundTimeLimit();
}
