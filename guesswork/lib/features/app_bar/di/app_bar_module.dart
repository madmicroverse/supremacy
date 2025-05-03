import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/features/app_bar/presentation/bloc/app_bar_bloc.dart';
import 'package:guesswork/features/app_bar/presentation/view/app_bar_widget.dart';
import 'package:guesswork/features/coins/di/app_bar_module.dart';
import 'package:guesswork/features/no_ads_button/di/no_ads_button_module.dart';
import 'package:guesswork/features/settings_button/di/settings_button_module.dart';
import 'package:injectable/injectable.dart';

const appBarWidget = "appBarWidget";

@module
abstract class AppBarModule {
  @Injectable()
  AppBarBloc appBarBlocFactory() {
    return AppBarBloc();
  }

  @Named(appBarWidget)
  @Injectable()
  PreferredSizeWidget appBarWidgetFactory(
    AppBarBloc bloc,
    @Named(coinsWidget) Widget coins,
    @Named(settingsButtonWidget) Widget settingsButton,
    @Named(noAdsButtonWidget) Widget noAdsButton,
  ) {
    return GamesAppBarPreferredSize(
      child: BlocProvider(
        lazy: false,
        create: (_) => bloc,
        child: GamesAppBar(
          coins: coins,
          settingsButton: settingsButton,
          noAdsButton: noAdsButton,
        ),
      ),
    );
  }
}
