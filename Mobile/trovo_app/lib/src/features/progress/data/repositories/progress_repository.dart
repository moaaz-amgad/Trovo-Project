import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/progress_entry.dart';
import '../models/progress_summary.dart';

abstract class ProgressRepository {
  Future<Either<Failure, ProgressSummary>> fetchSummary();
  Future<Either<Failure, List<ProgressEntry>>> fetchHistory();
}
