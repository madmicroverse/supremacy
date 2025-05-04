import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/fragments/components/no_ads_button/di/no_ads_button_module.dart';
import 'package:guesswork/fragments/standalone/settings/domain/use_case/get_game_settings_stream_use_case.dart';
import 'package:guesswork/fragments/standalone/settings/domain/use_case/set_game_settings_use_case.dart';
import 'package:injectable/injectable.dart';

import '../presentation/bloc/settings_be.dart';
import '../presentation/bloc/settings_bloc.dart';
import '../presentation/view/settings_widget.dart';

const settingsRouteWidget = "settingsRouteWidget";

@module
abstract class SettingsModule {
  @Injectable()
  SettingsBloc appBarBlocFactory(
    IRouter router,
    GetGamesSettingsStreamUseCase getGamesSettingsUseCase,
    SetGamesSettingsUseCase setGamesSettingsUseCase,
  ) {
    return SettingsBloc(
      router,
      getGamesSettingsUseCase,
      setGamesSettingsUseCase,
    );
  }

  @Named(settingsRouteWidget)
  @Injectable()
  Widget appBarWidgetFactory(
    SettingsBloc bloc,
    @Named(noAdsButtonWidget) Widget noAdsButton,
  ) {
    return BlocProvider(
      lazy: false,
      create: (_) => bloc..add(InitSettingsBE()),
      child: Settings(noAdsButton: noAdsButton),
    );
  }
}
