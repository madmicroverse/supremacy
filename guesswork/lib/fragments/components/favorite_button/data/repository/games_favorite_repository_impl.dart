import 'dart:async';

import 'package:guesswork/core/data/framework/firebase/firestore/sag_game_favorite/delete_sag_game_favorite_operation.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/sag_game_favorite/get_sag_games_favorites_stream_operation.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/sag_game_favorite/upsert_sag_game_favorite_operation.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/repository/games_favorite_repository.dart';
import 'package:rxdart/rxdart.dart';

class GamesFavoriteRepositoryImpl extends SAGGameFavoriteRepository {
  final UpsertSAGGameFavoriteOperation _upsertSAGGameFavoriteOperation;
  final GetSAGGameFavoritesStreamOperation _getSAGGameFavoritesStreamOperation;
  final DeleteSAGGameFavoriteOperation _deleteSAGGameFavoriteOperation;

  Stream<List<SAGGame>>? _gamesFavoritesStream;

  final _gamesFavoritesBehaviorSubject = BehaviorSubject<List<SAGGame>>();

  GamesFavoriteRepositoryImpl(
    this._upsertSAGGameFavoriteOperation,
    this._getSAGGameFavoritesStreamOperation,
    this._deleteSAGGameFavoriteOperation,
  );

  @override
  Future<
    Result<
      Stream<List<SAGGame>>,
      SAGGameFavoriteRepositoryGetSAGGameFavoritesStreamError
    >
  >
  getSAGGameFavoritesStream(String gamesUserId) async {
    if (_gamesFavoritesStream == null) {
      final result = await _getSAGGameFavoritesStreamOperation(
        gamesUserId: gamesUserId,
      );
      switch (result) {
        case Success():
          _gamesFavoritesStream = result.data;
          _gamesFavoritesStream!.listen(
            (favorites) {
              _gamesFavoritesBehaviorSubject.add(favorites);
            },
            onError: (error) {
              _gamesFavoritesBehaviorSubject.addError(error);
            },
          );
        case Error():
          final error = result.error;
          switch (error) {
            case GetSAGGameFavoritesStreamOperationDataAccessError():
              return Error(
                SAGGameFavoriteRepositoryGetSAGGameFavoritesStreamDataAccessError(),
              );
          }
      }
    }
    return Success(_gamesFavoritesBehaviorSubject.stream);
  }

  @override
  Future<Result<void, SAGGameFavoriteRepositoryUpsertSAGGameFavoriteError>>
  upsertSAGGameFavorite(String gamesUserId, SAGGame sagGameFavorite) async {
    final result = await _upsertSAGGameFavoriteOperation(
      gamesUserId,
      sagGameFavorite,
    );
    switch (result) {
      case Success():
        return Success(result.data);
      case Error():
        final error = result.error;
        switch (error) {
          case UpsertSAGGameFavoriteOperationDataAccessError():
            return Error(
              SAGGameFavoriteRepositoryUpsertSAGGameFavoriteDataAccessError(),
            );
        }
    }
  }

  @override
  Future<Result<void, SAGGameFavoriteRepositoryDeleteSAGGameFavoriteError>>
  deleteSAGGameFavorite(String gamesUserId, String sagGameFavoriteId) async {
    final result = await _deleteSAGGameFavoriteOperation(
      gamesUserId,
      sagGameFavoriteId,
    );

    switch (result) {
      case Success():
        return Success(result.data);
      case Error():
        final error = result.error;
        switch (error) {
          case DeleteSAGGameFavoriteOperationDataAccessError():
            return Error(
              SAGGameFavoriteRepositoryDeleteSAGGameFavoriteDataAccessError(),
            );
        }
    }
  }
}
