import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/sag_game_selection/sag_game_favorite/delete_sag_game_selection_operation.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/sag_game_selection/sag_game_favorite/get_sag_games_selections_stream_operation.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/sag_game_selection/sag_game_favorite/upsert_sag_game_selection_operation.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';
import 'package:guesswork/core/domain/use_case/get_sag_game_selections_stream_use_case.dart';
import 'package:guesswork/fragments/components/selection_button/data/repository/games_selection_repository_impl.dart';
import 'package:guesswork/fragments/components/selection_button/domain/repository/games_selection_repository.dart';
import 'package:guesswork/fragments/components/selection_button/domain/use_case/delete_sag_game_selection_use_case.dart';
import 'package:guesswork/fragments/components/selection_button/domain/use_case/upsert_sag_game_selection_use_case.dart';
import 'package:guesswork/fragments/components/selection_button/presentation/bloc/selection_button_be.dart';
import 'package:injectable/injectable.dart';

import '../presentation/bloc/selection_button_bloc.dart';
import '../presentation/view/selection_button_widget.dart';

const sagGameSelectionButtonWidget = "sagGameSelectionButtonWidget";

@module
abstract class SelectionButtonModule {
  @Injectable()
  UpsertSAGGameSelectionOperation upsertSelectionOperationFactory(
    FirebaseFirestore firebaseFirestore,
  ) {
    return UpsertSAGGameSelectionOperation(firebaseFirestore);
  }

  @Injectable()
  GetSAGGameSelectionsStreamOperation getGamesSelectionsStreamOperationFactory(
    FirebaseFirestore firebaseFirestore,
  ) {
    return GetSAGGameSelectionsStreamOperation(firebaseFirestore);
  }

  @Injectable()
  DeleteSAGGameSelectionOperation deleteSAGGameSelectionOperationFactory(
    FirebaseFirestore firebaseFirestore,
  ) {
    return DeleteSAGGameSelectionOperation(firebaseFirestore);
  }

  @Singleton()
  SAGGameSelectionRepository gamesSelectionRepositoryFactory(
    UpsertSAGGameSelectionOperation upsertSAGGameSelectionOperation,
    GetSAGGameSelectionsStreamOperation getSAGGameSelectionsStreamOperation,
    DeleteSAGGameSelectionOperation deleteSAGGameSelectionOperation,
  ) {
    return GamesSelectionRepositoryImpl(
      upsertSAGGameSelectionOperation,
      getSAGGameSelectionsStreamOperation,
      deleteSAGGameSelectionOperation,
    );
  }

  @Injectable()
  UpsertSAGGameSelectionUseCase upsertGamesSelectionUseCaseFactory(
    AccountRepository accountRepository,
    SAGGameSelectionRepository gamesSelectionRepository,
  ) {
    return UpsertSAGGameSelectionUseCase(
      accountRepository,
      gamesSelectionRepository,
    );
  }

  @Injectable()
  DeleteSAGGameSelectionUseCase deleteSAGGameSelectionUseCaseFactory(
    AccountRepository accountRepository,
    SAGGameSelectionRepository gamesSelectionRepository,
  ) {
    return DeleteSAGGameSelectionUseCase(
      accountRepository,
      gamesSelectionRepository,
    );
  }

  @Injectable()
  GetSAGGameSelectionsStreamUseCase getGamesSelectionsStreamUseCaseFactory(
    AccountRepository accountRepository,
    SAGGameSelectionRepository gamesSelectionRepository,
  ) {
    return GetSAGGameSelectionsStreamUseCase(
      accountRepository,
      gamesSelectionRepository,
    );
  }

  @Injectable()
  SelectionButtonBloc selectionButtonBlocFactory(
    IRouter router,
    UpsertSAGGameSelectionUseCase upsertGamesSelectionUseCase,
    GetSAGGameSelectionsStreamUseCase getGamesSelectionsStreamUseCase,
    DeleteSAGGameSelectionUseCase deleteSAGGameSelectionUseCase,
  ) {
    return SelectionButtonBloc(
      router,
      upsertGamesSelectionUseCase,
      getGamesSelectionsStreamUseCase,
      deleteSAGGameSelectionUseCase,
    );
  }

  @Named(sagGameSelectionButtonWidget)
  @Injectable()
  Widget sagGameSelectionButtonComponentFactory(
    SelectionButtonBloc bloc,
    @factoryParam SAGGame sagGame,
  ) {
    return BlocProvider(
      lazy: false,
      create:
          (_) =>
              bloc..add(
                InitSAGGameSelectionBE(LiveSAGGameSource.favorites, sagGame),
              ),
      child: SelectionButton(),
    );
  }
}
