import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:guesswork/core/presentation/theme.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  @preResolve
  @Injectable()
  Future<ThemeData> themeDataFactory() async {
    const materialTheme = MaterialTheme(TextTheme());
    return materialTheme.light();
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
        return SafeArea(child: child!);
      },
    );
  }
}
