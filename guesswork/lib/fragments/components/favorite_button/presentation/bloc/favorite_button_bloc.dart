import 'dart:async';

import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/extension/object_utils.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/domain/use_case/get_sag_game_favorites_stream_use_case.dart';
import 'package:guesswork/di/modules/router_module.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/use_case/delete_sag_game_favorite_use_case.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/use_case/upsert_sag_game_favorite_use_case.dart';

import 'favorite_button_be.dart';
import 'favorite_button_bs.dart';

class FavoriteButtonBloc extends Bloc<FavoriteButtonBE, FavoriteButtonBS> {
  final IRouter _router;
  final UpsertSAGGameFavoriteUseCase _upsertGamesFavoriteUseCase;
  final GetSAGGameFavoritesStreamUseCase _getGamesFavoritesStreamUseCase;
  final DeleteSAGGameFavoriteUseCase _deleteSAGGameFavoriteUseCase;

  StreamSubscription<List<SAGGame>>? _sagGameFavoriteListSubscription;

  FavoriteButtonBloc(
    this._router,
    this._upsertGamesFavoriteUseCase,
    this._getGamesFavoritesStreamUseCase,
    this._deleteSAGGameFavoriteUseCase,
  ) : super(FavoriteButtonBS()) {
    on<UpdateGameFavoritesBE>(_updateGameFavoritesBE);
    on<FavoriteGameBE>(_favoriteGameBE);
    on<InitSAGGameFavoriteBE>(_initSAGGameFavoriteBE);
  }

  FutureOr<void> _updateGameFavoritesBE(
    UpdateGameFavoritesBE event,
    Emitter<FavoriteButtonBS> emit,
  ) {
    final isFavorite =
        event.gamesFavoriteList.firstWhereOrNull((gamesFavorite) {
          return gamesFavorite.id == event.sagGame.id;
        }).isNotNull;

    favoriteEvent() => add(FavoriteGameBE(event.sagGame, isFavorite));

    emit(state.withOnPressed(favoriteEvent).withIsFavorite(isFavorite));
  }

  FutureOr<void> _initSAGGameFavoriteBE(
    InitSAGGameFavoriteBE event,
    Emitter<FavoriteButtonBS> emit,
  ) async {
    final result = await _getGamesFavoritesStreamUseCase();
    switch (result) {
      case Success():
        _sagGameFavoriteListSubscription = result.data.listen((
          gamesFavoriteList,
        ) {
          add(UpdateGameFavoritesBE(event.sagGame, gamesFavoriteList));
        });
      case Error():
        final error = result.error;
        switch (error) {
          case GetSAGGameFavoritesStreamUseCaseDataAccessError():
            emit(state.withError(FavoriteButtonViewDataAccessError()));
          case GetSAGGameFavoritesStreamUseCaseUnauthorizedError():
            _router.goNamed(signInRouteName);
        }
    }
  }

  FutureOr<void> _favoriteGameBE(
    FavoriteGameBE event,
    Emitter<FavoriteButtonBS> emit,
  ) async {
    if (event.isFavorite) {
      final result = await _deleteSAGGameFavoriteUseCase(
        event.sagGameFavorite.id,
      );
      switch (result) {
        case Success():
          break;
        case Error():
          final error = result.error;
          switch (error) {
            case DeleteSAGGameFavoriteUseCaseUnauthorizedError():
              _router.goNamed(signInRouteName);
            case DeleteSAGGameFavoriteUseCaseDataAccessError():
              emit(state.withError(FavoriteButtonViewDataAccessError()));
          }
      }
    } else {
      final result = await _upsertGamesFavoriteUseCase(event.sagGameFavorite);
      switch (result) {
        case Success():
          break;
        case Error():
          final error = result.error;
          switch (error) {
            case UpsertSAGGameFavoriteUseCaseUnauthorizedError():
              _router.goNamed(signInRouteName);
            case UpsertSAGGameFavoriteUseCaseDataAccessError():
              emit(state.withError(FavoriteButtonViewDataAccessError()));
          }
      }
    }
  }

  @override
  Future<void> close() {
    _sagGameFavoriteListSubscription?.cancel();
    return super.close();
  }
}
