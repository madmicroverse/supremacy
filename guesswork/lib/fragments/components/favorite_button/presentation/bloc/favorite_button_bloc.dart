import 'dart:async';

import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/entity/games.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/entity/games_favorite.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/use_case/get_games_favorites_stream_use_case.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/use_case/upsert_favorite_use_case.dart';

import 'favorite_button_be.dart';
import 'favorite_button_bsc.dart';

class FavoriteButtonBloc extends Bloc<FavoriteButtonBE, FavoriteButtonBS> {
  final IRouter _router;
  final UpsertGamesFavoriteUseCase _upsertGamesFavoriteUseCase;
  final GetGamesFavoritesStreamUseCase _getGamesFavoritesStreamUseCase;

  FavoriteButtonBloc(
    this._router,
    this._upsertGamesFavoriteUseCase,
    this._getGamesFavoritesStreamUseCase,
  ) : super(FavoriteButtonBS()) {
    on<UpdateGameFavoritesBE>(_updateGameFavoritesBE);
    on<FavoriteGameBE>(_favoriteGameBE);
    on<InitSAGGameFavoriteBE>(_initSAGGameFavoriteBE);
  }

  FutureOr<void> _updateGameFavoritesBE(
    UpdateGameFavoritesBE event,
    Emitter<FavoriteButtonBS> emit,
  ) {
    final gamesFavorite = event.gamesFavoriteList.firstWhereOrNull(
      (gamesFavorite) => gamesFavorite.id == event.gameId,
    );
    favoriteEvent() =>
        add(FavoriteGameBE(event.gameId, event.gameType, gamesFavorite));
    emit(
      state
          .withOnPressed(favoriteEvent)
          .withIsFavorite(!(gamesFavorite?.isUndo ?? true)),
    );
  }

  FutureOr<void> _initSAGGameFavoriteBE(
    InitSAGGameFavoriteBE event,
    Emitter<FavoriteButtonBS> emit,
  ) async {
    final result = await _getGamesFavoritesStreamUseCase();
    switch (result) {
      case Success():
        result.data.listen((gamesFavoriteList) {
          add(
            UpdateGameFavoritesBE(
              event.gameId,
              GameType.sagGame,
              gamesFavoriteList,
            ),
          );
        });
      case Error():
      // TODO ovi
    }
  }

  FutureOr<void> _favoriteGameBE(
    FavoriteGameBE event,
    Emitter<FavoriteButtonBS> emit,
  ) async {
    final result = await _upsertGamesFavoriteUseCase(
      GamesFavorite(
        gameId: event.gameId,
        gameType: GameType.sagGame,
        isUndo: !(event.gamesFavorite?.isUndo ?? true),
      ),
    );
    switch (result) {
      case Success():
      // TODO ovi
      case Error():
      // TODO ovi
    }
  }
}
