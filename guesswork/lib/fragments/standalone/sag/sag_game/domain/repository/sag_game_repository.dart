import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/data/framework/firestore_operations/GetSagGamesOperation.dart';

abstract class SAGGameRepository {
  Future<Result<void, BaseError>> createSAGGame(SAGGame sagGame);

  Future<Result<SAGGame, BaseError>> getSAGGame(String sagGameId);

  Future<Result<PaginatedSagGames, BaseError>> getSAGGames(int limit);

  Future<Result<String, BaseError>> upsertUserSAGGameInfo(
      String gamesUserId,
      String? userSAGGameId,
      SAGGame sagGame,
      );
}
