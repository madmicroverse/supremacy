import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/data/framework/firestore_operations/GetSagGamesOperation.dart';

sealed class GetSAGGamesError extends BaseError {}

class DataAccessError extends GetSAGGamesError { }

abstract class SAGGameRepository {
  Future<Result<void, BaseError>> createSAGGame(SAGGame sagGame);

  Future<Result<SAGGame, BaseError>> getSAGGame(String sagGameId);

  Future<Result<PaginatedSagGames, GetSAGGamesError>> getSAGGames({
    String? gamesUserId,
    required SAGGameSource sagGameSource,
    required int limit,
  });

  Future<Result<String, BaseError>> upsertUserSAGGameInfo({
    required String gamesUserId,
    String? userSAGGameId,
    required SAGGame sagGame,
    SAGGame? sagGameUnique,
  });
}
