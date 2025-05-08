import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/entity/games_favorite.dart';

abstract class GamesFavoriteRepository {
  Future<Result<GamesFavorite, BaseError>> getGamesFavorite();

  Future<Result<Stream<GamesFavorite>, BaseError>> getGamesFavoriteStream();

  Future<Result<void, BaseError>> upsertGamesFavorite(
    String gamesUserId,
    GamesFavorite gamesFavorite,
  );
}
