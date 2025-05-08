import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/entity/games_favorite.dart';

abstract class GamesFavoriteRepository {
  Future<Result<Stream<List<GamesFavorite>>, BaseError>>
  getGamesFavoritesStream(String gamesUserId);

  Future<Result<void, BaseError>> upsertGamesFavorite(
    String gamesUserId,
    GamesFavorite gamesFavorite,
  );
}
