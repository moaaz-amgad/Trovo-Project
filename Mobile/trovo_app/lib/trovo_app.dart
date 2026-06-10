import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trovo_app/generated/l10n.dart';
import 'package:trovo_app/src/core/cubits/locale_cubit.dart';
import 'package:trovo_app/src/core/routing/app_router.dart';
import 'package:trovo_app/src/core/theming/app_themes.dart';

class TrovoApp extends StatelessWidget {
  const TrovoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocaleCubit(),
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              return MaterialApp.router(
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                locale: Locale('en'),
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                themeMode: ThemeMode.light,
                routerConfig: AppRouter.router,
              );
            },
          );
        },
      ),
    );
  }
}
