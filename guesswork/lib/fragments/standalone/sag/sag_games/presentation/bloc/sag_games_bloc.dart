import 'dart:async';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/sag_game_selection/sag_game_favorite/upsert_sag_game_selection_operation.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/domain/use_case/get_sag_game_selections_stream_use_case.dart';
import 'package:guesswork/di/modules/router_module.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/data/framework/firestore_operations/GetSagGamesOperation.dart';

import '../../domain/use_case/get_sag_games_use_case.dart';
import 'sag_games_be.dart';
import 'sag_games_bsc.dart';

class SAGGamesBloc extends Bloc<SAGGamesBE, SAGGamesBSC> {
  final IRouter _router;
  final GetSAGGamesUseCase _getSAGGamesUseCase;
  final GetSAGGameSelectionsStreamUseCase _getSAGGameSelectionsStreamUseCase;

  StreamSubscription<List<SAGGame>>? _sagGameSelectionListSubscription;
  List<PaginatedSagGames> paginatedSagGamesList = [];

  SAGGamesBloc(
    this._router,
    this._getSAGGamesUseCase,
    this._getSAGGameSelectionsStreamUseCase,
  ) : super(SAGGamesBSC()) {
    on<InitSAGGamesBlocEvent>(_initSAGGamesBlocEvent);
    on<InitLiveSAGGamesBlocEvent>(_initLiveSAGGamesBlocEvent);
    on<UpdateSAGGameListBlocEvent>(_updateSAGGameListBlocEvent);
    on<SelectGameBlocEvent>(_selectGameBlocEvent);
    on<PullToRefreshBlocEvent>(_pullToRefreshBlocEvent);
  }

  FutureOr<void> _initSAGGamesBlocEvent(
    InitSAGGamesBlocEvent event,
    Emitter<SAGGamesBSC> emit,
  ) async {
    emit(state.withSAGGameSource(event.sagGameSource));
    _loadSAGGamesBlocEvent(event.sagGameSource, emit);
  }

  FutureOr<void> _pullToRefreshBlocEvent(
    PullToRefreshBlocEvent event,
    Emitter<SAGGamesBSC> emit,
  ) async {
    if (state.isSAGGamesRefreshable) {
      emit(state.withEmptySAGGameList);
      await Future.delayed(10000.ms);
      await _loadSAGGamesBlocEvent(state.sagGameSource!, emit);
    }
    event.completer.complete();
  }

  FutureOr<void> _loadSAGGamesBlocEvent(
    SAGGameSource sagGameSource,
    Emitter<SAGGamesBSC> emit,
  ) async {
    switch (sagGameSource) {
      case SAGGameSource.main:
      case SAGGameSource.replay:
        final result = await _getSAGGamesUseCase(
          sagGameSource: sagGameSource,
          limit: 10,
        );
        switch (result) {
          case Success():
            PaginatedSagGames paginatedSagGames = result.data;
            paginatedSagGamesList.add(paginatedSagGames);

            final sagGameList = paginatedSagGamesList.fold(
              <SAGGame>[],
              (acc, page) => acc..addAll(page.games),
            );
            add(UpdateSAGGameListBlocEvent(sagGameList));
          case Error():
            switch (result.error) {
              case GetSAGGamesUseCaseUnknownError():
                emit(state.withError(SAGGamesBSCUnknownError()));
              case GetSAGGamesUseCaseUserUnauthorizedError():
                _router.goNamed(signInRouteName);
            }
        }
    }
  }

  FutureOr<void> _initLiveSAGGamesBlocEvent(
    InitLiveSAGGamesBlocEvent event,
    Emitter<SAGGamesBSC> emit,
  ) async {
    final result = await _getSAGGameSelectionsStreamUseCase(
      event.liveSAGGameSource,
    );
    switch (result) {
      case Success():
        _sagGameSelectionListSubscription = result.data.listen(
          (sagGameList) => add(UpdateSAGGameListBlocEvent(sagGameList)),
        );
      case Error():
        final error = result.error;
        switch (error) {
          case GetSAGGameSelectionsStreamUseCaseDataAccessError():
            throw UnimplementedError();
          case GetSAGGameSelectionsStreamUseCaseUnauthorizedError():
            throw UnimplementedError();
        }
    }
  }

  FutureOr<void> _loadLiveSAGGamesBlocEvent(
    LiveSAGGameSource liveSAGGameSource,
    Emitter<SAGGamesBSC> emit,
  ) async {
    final result = await _getSAGGameSelectionsStreamUseCase(liveSAGGameSource);
    switch (result) {
      case Success():
        _sagGameSelectionListSubscription = result.data.listen(
          (sagGameList) => add(UpdateSAGGameListBlocEvent(sagGameList)),
        );
      case Error():
        print('');
    }
  }

  FutureOr<void> _updateSAGGameListBlocEvent(
    UpdateSAGGameListBlocEvent event,
    Emitter<SAGGamesBSC> emit,
  ) {
    emit(state.withSAGGameList(event.sagGameList));
  }

  FutureOr<void> _selectGameBlocEvent(
    SelectGameBlocEvent event,
    Emitter<SAGGamesBSC> emit,
  ) {
    _router.pushNamed(sagGameRouteName, extra: event.sagGame.id);
  }

  @override
  Future<void> close() {
    _sagGameSelectionListSubscription?.cancel();
    return super.close();
  }
}
