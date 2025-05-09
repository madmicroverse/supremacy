import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/domain/use_case/get_sag_game_favorites_stream_use_case.dart';
import 'package:guesswork/di/modules/router_module.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/data/framework/firestore_operations/GetSagGamesOperation.dart';

import '../../domain/use_case/get_sag_games_use_case.dart';
import 'sag_games_be.dart';
import 'sag_games_bsc.dart';

class SAGGamesBloc extends Bloc<SAGGamesBE, SAGGamesBSC> {
  final IRouter _router;
  final GetSAGGamesUseCase _getSAGGamesUseCase;
  final GetSAGGameFavoritesStreamUseCase _getSAGGameFavoritesStreamUseCase;

  StreamSubscription<List<SAGGame>>? _sagGameFavoriteListSubscription;
  List<PaginatedSagGames> paginatedSagGamesList = [];

  SAGGamesBloc(
    this._router,
    this._getSAGGamesUseCase,
    this._getSAGGameFavoritesStreamUseCase,
  ) : super(SAGGamesBSC()) {
    on<InitSAGGamesBlocEvent>(_initSAGGamesBlocEvent);
    on<UpdateSAGGameListBlocEvent>(_updateSAGGameListBlocEvent);
    on<SelectGameBlocEvent>(_selectGameBlocEvent);
  }

  FutureOr<void> _initSAGGamesBlocEvent(
    InitSAGGamesBlocEvent event,
    Emitter<SAGGamesBSC> emit,
  ) async {
    switch (event.sagGameSource) {
      case SAGGameSource.main:
      case SAGGameSource.top:
      case SAGGameSource.replay:
        final result = await _getSAGGamesUseCase(
          sagGameSource: event.sagGameSource,
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
              case AuthError():
                // TODO: Handle this case.
                throw UnimplementedError();
              case NoDataAvailableError():
                // TODO: Handle this case.
                throw UnimplementedError();
            }
        }
      case SAGGameSource.favorite:
        final result = await _getSAGGameFavoritesStreamUseCase();
        switch (result) {
          case Success():
            _sagGameFavoriteListSubscription = result.data.listen(
              (sagGameList) => add(UpdateSAGGameListBlocEvent(sagGameList)),
            );
          case Error():
            print('');
        }
    }
  }

  FutureOr<void> _updateSAGGameListBlocEvent(
    UpdateSAGGameListBlocEvent event,
    Emitter<SAGGamesBSC> emit,
  ) async => emit(state.withSAGGameList(event.sagGameList));

  FutureOr<void> _selectGameBlocEvent(
    SelectGameBlocEvent event,
    Emitter<SAGGamesBSC> emit,
  ) {
    _router.pushNamed(sagGameRouteName, extra: event.sagGame.id);
  }

  @override
  Future<void> close() {
    _sagGameFavoriteListSubscription?.cancel();
    return super.close();
  }
}
