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
  Future<Result<Stream<List<SAGGame>>, BaseError>> getSAGGameFavoritesStream(
    String gamesUserId,
  ) async {
    if (_gamesFavoritesStream == null) {
      final streamResult = await _getSAGGameFavoritesStreamOperation(
        gamesUserId: gamesUserId,
      );
      switch (streamResult) {
        case Success():
          _gamesFavoritesStream = streamResult.data;
          _gamesFavoritesStream!.listen(
            (favorites) {
              _gamesFavoritesBehaviorSubject.add(favorites);
            },
            onError: (error) {
              _gamesFavoritesBehaviorSubject.addError(error);
            },
          );
        case Error():
          return Error(streamResult.error);
      }
    }
    return Success(_gamesFavoritesBehaviorSubject.stream);
  }

  @override
  Future<Result<void, BaseError>> upsertSAGGameFavorite(
    String gamesUserId,
    SAGGame sagGameFavorite,
  ) => _upsertSAGGameFavoriteOperation(gamesUserId, sagGameFavorite);

  @override
  Future<Result<void, BaseError>> deleteSAGGameFavorite(
    String gamesUserId,
    String sagGameFavoriteId,
  ) => _deleteSAGGameFavoriteOperation(gamesUserId, sagGameFavoriteId);
}
