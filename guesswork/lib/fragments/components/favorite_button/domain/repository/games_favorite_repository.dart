import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

abstract class SAGGameFavoriteRepository {
  Future<Result<Stream<List<SAGGame>>, BaseError>> getSAGGameFavoritesStream(
    String gamesUserId,
  );

  Future<Result<void, BaseError>> upsertSAGGameFavorite(
    String gamesUserId,
    SAGGame sagGameFavorite,
  );

  Future<Result<void, BaseError>> deleteSAGGameFavorite(
    String gamesUserId,
    String sagGameFavoriteId,
  );
}
