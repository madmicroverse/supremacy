import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

sealed class SAGGameFavoriteRepositoryGetSAGGameFavoritesStreamError
    extends BaseError {}

class SAGGameFavoriteRepositoryGetSAGGameFavoritesStreamDataAccessError
    extends SAGGameFavoriteRepositoryGetSAGGameFavoritesStreamError {}

sealed class SAGGameFavoriteRepositoryUpsertSAGGameFavoriteError
    extends BaseError {}

class SAGGameFavoriteRepositoryUpsertSAGGameFavoriteDataAccessError
    extends SAGGameFavoriteRepositoryUpsertSAGGameFavoriteError {}

sealed class SAGGameFavoriteRepositoryDeleteSAGGameFavoriteError
    extends BaseError {}

class SAGGameFavoriteRepositoryDeleteSAGGameFavoriteDataAccessError
    extends SAGGameFavoriteRepositoryDeleteSAGGameFavoriteError {}

abstract class SAGGameFavoriteRepository {
  Future<
    Result<
      Stream<List<SAGGame>>,
      SAGGameFavoriteRepositoryGetSAGGameFavoritesStreamError
    >
  >
  getSAGGameFavoritesStream(String gamesUserId);

  Future<Result<void, SAGGameFavoriteRepositoryUpsertSAGGameFavoriteError>>
  upsertSAGGameFavorite(String gamesUserId, SAGGame sagGameFavorite);

  Future<Result<void, SAGGameFavoriteRepositoryDeleteSAGGameFavoriteError>>
  deleteSAGGameFavorite(String gamesUserId, String sagGameFavoriteId);
}
