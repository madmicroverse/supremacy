import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/features/app_bar/di/app_bar_module.dart';
import 'package:injectable/injectable.dart';

import '../data/repository/sag_game_repository_impl.dart';
import '../domain/repository/sag_game_repository.dart';
import '../domain/use_case/get_sag_game_use_case.dart';
import '../presentation/bloc/sag_game_be.dart';
import '../presentation/bloc/sag_game_bloc.dart';
import '../presentation/view/sag_game_route_widget.dart';

const sagGameRouteWidget = "sagGameRouteWidget";

@module
abstract class SAGGameModule {
  @Injectable()
  SAGGameRepository sagGameRepositoryFactory() {
    return SAGGameRepositoryImpl();
  }

  @Injectable()
  GetSAGGameUseCase getSAGGameUseCaseFactory(
    SAGGameRepository gameSetRepository,
  ) {
    return GetSAGGameUseCase(gameSetRepository);
  }

  @Injectable()
  SAGGameBloc gameSetBlocFactory(
    IRouter router,
    GetSAGGameUseCase getSAGGameUseCase,
  ) {
    return SAGGameBloc(router, getSAGGameUseCase);
  }

  @Named(sagGameRouteWidget)
  @Injectable()
  Widget gameSetRouteWidgetFactory(
    SAGGameBloc bloc,
    @factoryParam String id,
    @Named(appBarWidget) PreferredSizeWidget appBarWidget,
  ) {
    return BlocProvider(
      lazy: false,
      create: (_) => bloc..add(InitSAGGameBE()),
      child: SAGGameRouteWidget(appBarWidget: appBarWidget),
    );
  }
}
