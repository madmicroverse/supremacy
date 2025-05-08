import 'dart:async';

import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/fragments/components/favorite_button/data/firebase/firestore/get_games_favorites_stream_operation.dart';
import 'package:guesswork/fragments/components/favorite_button/data/firebase/firestore/upsert_games_favorite_operation.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/entity/games_favorite.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/repository/games_favorite_repository.dart';
import 'package:rxdart/rxdart.dart';

class GamesFavoriteRepositoryImpl extends GamesFavoriteRepository {
  final UpsertFavoriteOperation _upsertFavoriteOperation;
  final GetGamesFavoritesStreamOperation _getGamesFavoritesStreamOperation;

  Stream<List<GamesFavorite>>? _gamesFavoritesStream;

  final _gamesFavoritesBehaviorSubject = BehaviorSubject<List<GamesFavorite>>();

  GamesFavoriteRepositoryImpl(
    this._upsertFavoriteOperation,
    this._getGamesFavoritesStreamOperation,
  );

  @override
  Future<Result<Stream<List<GamesFavorite>>, BaseError>>
  getGamesFavoritesStream(String gamesUserId) async {
    if (_gamesFavoritesStream == null) {
      final streamResult = await _getGamesFavoritesStreamOperation(
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
  Future<Result<void, BaseError>> upsertGamesFavorite(
    String gamesUserId,
    GamesFavorite gamesFavorite,
  ) => _upsertFavoriteOperation(gamesUserId, gamesFavorite);
}
