import 'package:guesswork/core/data/framework/firebase/firestore/get_games_favorite_stream_operation.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/upsert_games_favorite_operation.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/entity/games_favorite.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/repository/games_favorite_repository.dart';

class GamesFavoriteRepositoryImpl extends GamesFavoriteRepository {
  final UpsertFavoriteOperation _upsertFavoriteOperation;
  final GetSagGamesStreamOperation _getSagGamesStreamOperation;

  GamesFavoriteRepositoryImpl(
    this._upsertFavoriteOperation,
    this._getSagGamesStreamOperation,
  );

  @override
  Future<Result<GamesFavorite, BaseError>> getGamesFavorite() {
    // TODO: implement getGamesFavorite
    throw UnimplementedError();
  }

  @override
  Future<Result<Stream<GamesFavorite>, BaseError>> getGamesFavoriteStream() {
    // TODO: implement getGamesFavoriteStream
    throw UnimplementedError();
  }

  @override
  Future<Result<void, BaseError>> upsertGamesFavorite(
    String gamesUserId,
    GamesFavorite gamesFavorite,
  ) => _upsertFavoriteOperation(gamesUserId, gamesFavorite);
}
