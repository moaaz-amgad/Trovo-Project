import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/diagnosis_response.dart';

abstract class DiagnosisRepository {
  Future<Either<Failure, DiagnosisResponse>> generateDiagnosis();
  Future<Either<Failure, DiagnosisResponse>> fetchHistory();
}
