import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/domain/use_case/get_sag_game_selections_stream_use_case.dart';
import 'package:guesswork/fragments/components/app_bar/di/app_bar_module.dart';
import 'package:guesswork/fragments/components/selection_button/di/selection_button_module.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/data/framework/firestore_operations/GetSagGamesOperation.dart';
import 'package:injectable/injectable.dart';

import '../domain/use_case/get_sag_games_use_case.dart';
import '../presentation/bloc/sag_games_be.dart';
import '../presentation/bloc/sag_games_bloc.dart';
import '../presentation/view/sag_games_route_widget.dart';

const sagGamesRouteWidget = "sagGamesRouteWidget";

@module
abstract class SAGGamesModule {
  @Injectable()
  SAGGamesBloc sagGamesBlocFactory(
    IRouter router,
    GetSAGGamesUseCase getSAGGamesUseCase,
    GetSAGGameSelectionsStreamUseCase getSAGGameSelectionsStreamUseCase,
  ) {
    return SAGGamesBloc(
      router,
      getSAGGamesUseCase,
      getSAGGameSelectionsStreamUseCase,
    );
  }

  @Named(sagGamesRouteWidget)
  @Injectable()
  Widget sagGamesRouteWidgetFactory(
    SAGGamesBloc bloc,
    @Named(appBarWidget) PreferredSizeWidget appBarWidget,
    @factoryParam SAGGameSource sagGameSource,
  ) {
    return BlocProvider(
      lazy: false,
      create: (_) => bloc..add(InitSAGGamesBlocEvent(sagGameSource)),
      child: SAGGamesRouteWidget(
        appBar: appBarWidget,
        sagGameSelectionButtonProvider:
            (SAGGame sagGame) => GetIt.instance.get(
              param1: sagGame,
              instanceName: sagGameSelectionButtonWidget,
            ),
      ),
    );
  }
}
