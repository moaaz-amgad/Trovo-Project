import '../models/nl_round.dart';

abstract class NlRepository {
  NlRound nextRound({required int level, required int index});
  int totalRoundsForSession();
  Duration roundTimeLimit();
}
