import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/domain/use_case/get_game_settings_use_case.dart';
import 'package:guesswork/core/domain/use_case/get_network_image_use_case.dart';
import 'package:guesswork/fragments/components/no_ads_button/di/no_ads_button_module.dart';
import 'package:guesswork/fragments/components/settings_button/di/settings_button_module.dart';
import 'package:injectable/injectable.dart';

import '../presentation/bloc/sag_game_item_be.dart';
import '../presentation/bloc/sag_game_item_bloc.dart';
import '../presentation/view/scratch_and_guess_route_widget.dart';

const sagGameItemRouteWidget = "sagGameItemRouteWidget";

@module
abstract class ScratchAndGuessModule {
  @Injectable()
  SAGGameItemBloc sagGameItemBlocFactory(
    IRouter router,
    GetNetworkImageUseCase getNetworkImageUseCase,
    GetGamesSettingsUseCase getGamesSettingsUseCase,
  ) {
    return SAGGameItemBloc(
      router,
      getNetworkImageUseCase,
      getGamesSettingsUseCase,
    );
  }

  @Named(sagGameItemRouteWidget)
  @Injectable()
  Widget sagGameItemRouteWidgetFactory(
    SAGGameItemBloc bloc,
    @factoryParam SAGGameItem sagGameItem,
    @Named(settingsButtonWidget) Widget settingsButton,
    @Named(noAdsButtonWidget) Widget noAdsButton,
  ) {
    return BlocProvider(
      lazy: false,
      create: (_) => bloc..add(InitSAGGameItemBE(sagGameItem)),
      child: SAGGameItemRouteWidget(
        settingsButton: settingsButton,
        noAdsButton: noAdsButton,
      ),
    );
  }
}
