import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:trovo_app/src/core/di/injection_container.dart';
import 'package:trovo_app/src/core/services/hive_cache_service.dart';
import 'package:trovo_app/src/core/utils/app_bloc_observer.dart';
import 'package:trovo_app/trovo_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveCacheService().init();

  await initializeServiceLocator();

  Bloc.observer = AppBlocObserver();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  runApp(const TrovoApp());
}
