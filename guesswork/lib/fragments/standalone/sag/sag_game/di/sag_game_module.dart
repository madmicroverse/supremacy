import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/get_games_user_operation.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/get_games_user_stream_operation.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/set_games_user_operation.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/upsert_user_sag_game_operation.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/domain/use_case/add_coins_use_case.dart';
import 'package:guesswork/core/domain/use_case/upsert_user_sag_game_use_case.dart';
import 'package:guesswork/fragments/components/app_bar/di/app_bar_module.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/domain/use_case/create_sag_game_use_case.dart';
import 'package:guesswork/fragments/standalone/settings/domain/use_case/get_game_settings_stream_use_case.dart';
import 'package:injectable/injectable.dart';

import '../data/framework/firestore_operations/CreateSagGameOperation.dart';
import '../data/framework/firestore_operations/GetSagGameOperation.dart';
import '../data/repository/sag_game_repository_impl.dart';
import '../domain/repository/sag_game_repository.dart';
import '../domain/use_case/get_sag_game_use_case.dart';
import '../presentation/bloc/sag_game_be.dart';
import '../presentation/bloc/sag_game_bloc.dart';
import '../presentation/view/sag_game_route_widget.dart';

const sagGameRouteWidget = "sagGameRouteWidget";

@module
abstract class SAGGameModule {
  @Singleton()
  CreateSagGameOperation createSagGameOperationFactory(
    FirebaseFirestore firebaseFirestore,
  ) {
    return CreateSagGameOperation(firebaseFirestore);
  }

  @Singleton()
  GetSagGameOperation getSagGameOperationFactory(
    FirebaseFirestore firebaseFirestore,
  ) {
    return GetSagGameOperation(firebaseFirestore);
  }

  @Singleton()
  GetGamesUserOperation getGamesUserOperationFactory(
    FirebaseFirestore firebaseFirestore,
  ) {
    return GetGamesUserOperation(firebaseFirestore);
  }

  @Singleton()
  GetGamesUserStreamOperation getGamesUserStreamOperationFactory(
    FirebaseFirestore firebaseFirestore,
  ) {
    return GetGamesUserStreamOperation(firebaseFirestore);
  }

  @Singleton()
  SetGamesUserOperation setGamesUserOperationFactory(
    FirebaseFirestore firebaseFirestore,
  ) {
    return SetGamesUserOperation(firebaseFirestore);
  }

  @Singleton()
  UpsertUserSAGGameOperation upsertUserSAGGameOperationFactory(
    FirebaseFirestore firebaseFirestore,
  ) {
    return UpsertUserSAGGameOperation(firebaseFirestore);
  }

  @Injectable()
  SAGGameRepository sagGameRepositoryFactory(
    CreateSagGameOperation createSagGameOperation,
    GetSagGameOperation getSagGameOperation,
  ) {
    return SAGGameRepositoryImpl(createSagGameOperation, getSagGameOperation);
  }

  @Injectable()
  GetSAGGameUseCase getSAGGameUseCaseFactory(
    SAGGameRepository gameSetRepository,
  ) {
    return GetSAGGameUseCase(gameSetRepository);
  }

  @Injectable()
  CreateSAGGameUseCase createSAGGameUseCaseFactory(
    SAGGameRepository gameSetRepository,
  ) {
    return CreateSAGGameUseCase(gameSetRepository);
  }

  @Injectable()
  SAGGameBloc gameSetBlocFactory(
    IRouter router,
    GetSAGGameUseCase getSAGGameUseCase,
    UpsertUserSAGGameUseCase createGamesUserPointsUseCase,
    AddCoinsStreamUseCase addCoinsStreamUseCase,
    GetGamesSettingsStreamUseCase getGamesSettingsUseCase,
  ) {
    return SAGGameBloc(
      router,
      getSAGGameUseCase,
      createGamesUserPointsUseCase,
      addCoinsStreamUseCase,
      getGamesSettingsUseCase,
    );
  }

  @Named(sagGameRouteWidget)
  @Injectable()
  Widget gameSetRouteWidgetFactory(
    SAGGameBloc bloc,
    @factoryParam String sagGameId,
    @Named(appBarWidget) PreferredSizeWidget appBarWidget,
  ) {
    return BlocProvider(
      lazy: false,
      create: (_) => bloc..add(InitSAGGameBE(sagGameId)),
      child: SAGGameRouteWidget(appBarWidget: appBarWidget),
    );
  }
}
