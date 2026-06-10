import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:trovo_app/src/core/services/hive_cache_service.dart';
import 'package:trovo_app/src/core/services/image_picker_service.dart';
import 'package:trovo_app/src/core/services/secure_storage_service.dart';
import 'package:trovo_app/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:trovo_app/src/features/auth/data/repositories/auth_repository.dart';
import 'package:trovo_app/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:trovo_app/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:trovo_app/src/features/diagnosis/data/datasources/diagnosis_remote_data_source.dart';
import 'package:trovo_app/src/features/diagnosis/data/repositories/diagnosis_repository.dart';
import 'package:trovo_app/src/features/diagnosis/data/repositories/diagnosis_repository_impl.dart';
import 'package:trovo_app/src/features/diagnosis/presentation/cubit/diagnosis_cubit.dart';
import 'package:trovo_app/src/features/memory_sequence/data/repositories/memory_sequence_repository.dart';
import 'package:trovo_app/src/features/memory_sequence/data/repositories/memory_sequence_repository_impl.dart';
import 'package:trovo_app/src/features/memory_sequence/presentation/cubit/memory_sequence_cubit.dart';
import 'package:trovo_app/src/features/phone_usage/data/datasources/phone_usage_platform_data_source.dart';
import 'package:trovo_app/src/features/phone_usage/data/datasources/phone_usage_remote_data_source.dart';
import 'package:trovo_app/src/features/phone_usage/data/repositories/phone_usage_repository.dart';
import 'package:trovo_app/src/features/phone_usage/data/repositories/phone_usage_repository_impl.dart';
import 'package:trovo_app/src/features/phone_usage/presentation/cubit/phone_usage_cubit.dart';
import 'package:trovo_app/src/features/questionnaire/data/datasources/questionnaire_local_data_source.dart';
import 'package:trovo_app/src/features/questionnaire/data/datasources/questionnaire_remote_data_source.dart';
import 'package:trovo_app/src/features/questionnaire/data/repositories/questionnaire_repository.dart';
import 'package:trovo_app/src/features/questionnaire/data/repositories/questionnaire_repository_impl.dart';
import 'package:trovo_app/src/features/questionnaire/presentation/cubit/questionnaire_cubit.dart';
import 'package:trovo_app/src/features/number_letter/data/repositories/nl_repository.dart';
import 'package:trovo_app/src/features/number_letter/data/repositories/nl_repository_impl.dart';
import 'package:trovo_app/src/features/number_letter/presentation/cubit/nl_cubit.dart';
import 'package:trovo_app/src/features/stroop/data/repositories/stroop_repository.dart';
import 'package:trovo_app/src/features/stroop/data/repositories/stroop_repository_impl.dart';
import 'package:trovo_app/src/features/stroop/presentation/cubit/stroop_cubit.dart';
import 'package:trovo_app/src/features/attention_span/data/repositories/attention_repository.dart';
import 'package:trovo_app/src/features/attention_span/data/repositories/attention_repository_impl.dart';
import 'package:trovo_app/src/features/attention_span/presentation/cubit/attention_cubit.dart';
import 'package:trovo_app/src/features/user/data/datasources/user_remote_data_source.dart';
import 'package:trovo_app/src/features/user/data/repositories/user_repository.dart';
import 'package:trovo_app/src/features/user/data/repositories/user_repository_impl.dart';
import 'package:trovo_app/src/features/user/presentation/cubit/user_cubit.dart';
import 'package:trovo_app/src/features/mini_game/data/datasources/mini_game_remote_data_source.dart';
import 'package:trovo_app/src/features/mini_game/data/repositories/mini_game_repository.dart';
import 'package:trovo_app/src/features/mini_game/data/repositories/mini_game_repository_impl.dart';
import 'package:trovo_app/src/features/mini_game/presentation/cubit/mini_game_cubit.dart';
import 'package:trovo_app/src/features/progress/data/datasources/progress_remote_data_source.dart';
import 'package:trovo_app/src/features/progress/data/repositories/progress_repository.dart';
import 'package:trovo_app/src/features/progress/data/repositories/progress_repository_impl.dart';
import 'package:trovo_app/src/features/progress/presentation/cubit/progress_cubit.dart';

import '../network/dio_client.dart';
import '../network/dio_factory.dart';

final sl = GetIt.instance;

Future<void> initializeServiceLocator() async {
  // ============================================================================
  // Core Services
  // ============================================================================
  sl.registerLazySingleton<SecureStorageService>(() => SecureStorageService());
  sl.registerLazySingleton<HiveCacheService>(() => HiveCacheService());
  sl.registerLazySingleton<DioClient>(() => DioClient(sl()));
  sl.registerLazySingleton<ImagePickerService>(() => ImagePickerService());

  // Dio instance (shared)
  sl.registerLazySingleton<Dio>(() => DioFactory.create(sl()));

  // ============================================================================
  // Feature: Auth
  // ============================================================================
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remote: sl(), secureStorage: sl()),
  );
  sl.registerFactory<AuthCubit>(() => AuthCubit(repository: sl()));

  // ============================================================================
  // Feature: User (profile & account)
  // ============================================================================
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remote: sl(), secureStorage: sl()),
  );
  sl.registerFactory<UserCubit>(() => UserCubit(repository: sl()));

  // ============================================================================
  // Feature: Mini Games (submission, history, stats, dashboard)
  // ============================================================================
  sl.registerLazySingleton<MiniGameRemoteDataSource>(
    () => MiniGameRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<MiniGameRepository>(
    () => MiniGameRepositoryImpl(remote: sl()),
  );
  sl.registerFactory<MiniGameCubit>(() => MiniGameCubit(repository: sl()));

  // ============================================================================
  // Feature: Progress Tracking
  // ============================================================================
  sl.registerLazySingleton<ProgressRemoteDataSource>(
    () => ProgressRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ProgressRepository>(
    () => ProgressRepositoryImpl(remote: sl()),
  );
  sl.registerFactory<ProgressCubit>(() => ProgressCubit(repository: sl()));

  // ============================================================================
  // Feature: Diagnosis
  // ============================================================================
  sl.registerLazySingleton<DiagnosisRemoteDataSource>(
    () => DiagnosisRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<DiagnosisRepository>(
    () => DiagnosisRepositoryImpl(remote: sl()),
  );
  sl.registerFactory<DiagnosisCubit>(() => DiagnosisCubit(repository: sl()));

  // ============================================================================
  // Feature: Phone Usage
  // ============================================================================
  sl.registerLazySingleton<PhoneUsageRemoteDataSource>(
    () => PhoneUsageRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<PhoneUsagePlatformDataSource>(
    () => PhoneUsagePlatformDataSourceImpl(),
  );
  sl.registerLazySingleton<PhoneUsageRepository>(
    () => PhoneUsageRepositoryImpl(remote: sl(), platform: sl()),
  );
  sl.registerFactory<PhoneUsageCubit>(() => PhoneUsageCubit(repository: sl()));

  // ============================================================================
  // Feature: Questionnaire
  // ============================================================================
  sl.registerLazySingleton<QuestionnaireRemoteDataSource>(
    () => QuestionnaireRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<QuestionnaireLocalDataSource>(
    () => QuestionnaireLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<QuestionnaireRepository>(
    () => QuestionnaireRepositoryImpl(
      remote: sl(),
      local: sl(),
    ),
  );
  sl.registerFactory<QuestionnaireCubit>(
    () => QuestionnaireCubit(repository: sl()),
  );

  // ============================================================================
  // Feature: Memory Sequence
  // ============================================================================
  sl.registerLazySingleton<MemorySequenceRepository>(
    () => MemorySequenceRepositoryImpl(),
  );
  sl.registerFactory<MemorySequenceCubit>(
    () => MemorySequenceCubit(repository: sl(), miniGame: sl()),
  );

  // ============================================================================
  // Feature: Stroop
  // ============================================================================
  sl.registerLazySingleton<StroopRepository>(() => StroopRepositoryImpl());
  sl.registerFactory<StroopCubit>(
    () => StroopCubit(repository: sl(), miniGame: sl()),
  );

  // ============================================================================
  // Feature: Number & Letter
  // ============================================================================
  sl.registerLazySingleton<NlRepository>(() => NlRepositoryImpl());
  sl.registerFactory<NlCubit>(
    () => NlCubit(repository: sl(), miniGame: sl()),
  );

  // ============================================================================
  // Feature: Attention Span (Go / No-Go)
  // ============================================================================
  sl.registerLazySingleton<AttentionRepository>(
    () => AttentionRepositoryImpl(),
  );
  sl.registerFactory<AttentionCubit>(
    () => AttentionCubit(repository: sl(), miniGame: sl()),
  );
}
