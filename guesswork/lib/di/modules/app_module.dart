import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:guesswork/core/domain/constants/space.dart';
import 'package:guesswork/core/presentation/extension/context_colors.dart';
import 'package:guesswork/core/presentation/theme.dart';
import 'package:guesswork/fragments/standalone/app_wrapper/di/app_wrapper_module.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  @preResolve
  @Injectable()
  Future<ThemeData> themeDataFactory() async {
    const materialTheme = MaterialTheme(TextTheme());
    ThemeData themeData = materialTheme.light();
    return themeData.copyWith(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: themeData.colorScheme.onPrimary,
          foregroundColor: themeData.colorScheme.scrim,
          elevation: elevationMin,
          padding: vpMin,
          shape: rrbMax,
          textStyle: themeData.textTheme.bodyLarge?.withFontWeight(
            FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @Injectable()
  MaterialApp crosswordBlockFactory(ThemeData themeData, GoRouter router) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      locale: AppLocalizations.supportedLocales.first,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
      theme: themeData,
      builder: (context, child) {
        return SafeArea(
          child: GetIt.instance.get<Widget>(
            instanceName: appWrapperWidget,
            param1: child,
          ),
        );
      },
    );
  }
}
