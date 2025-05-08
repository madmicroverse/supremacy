import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/domain/use_case/sign_out_use_case.dart';
import 'package:guesswork/fragments/components/app_bar/di/app_bar_module.dart';
import 'package:guesswork/fragments/components/favorite_button/di/favorite_button_module.dart';
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
    SignOutUseCase signOutUseCase,
  ) {
    return SAGGamesBloc(router, getSAGGamesUseCase, signOutUseCase);
  }

  @Named(sagGamesRouteWidget)
  @Injectable()
  Widget sagGamesRouteWidgetFactory(
    SAGGamesBloc bloc,
    @Named(appBarWidget) PreferredSizeWidget appBarWidget,
  ) {
    return BlocProvider(
      lazy: false,
      create: (_) => bloc..add(InitSAGGamesBlocEvent()),
      child: SAGGamesRouteWidget(
        appBar: appBarWidget,
        sagGameFavoriteButtonProvider:
            (SAGGame sagGame) => GetIt.instance.get(
              param1: sagGame,
              instanceName: sagGameFavoriteButtonWidget,
            ),
      ),
    );
  }
}
