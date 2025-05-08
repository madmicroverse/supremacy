import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/data/framework/firestore_operations/CreateSagGameOperation.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/data/framework/firestore_operations/GetSagGamesOperation.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/data/framework/firestore_operations/upsert_user_sag_game_operation.dart';

import '../../domain/repository/sag_game_repository.dart';
import '../framework/firestore_operations/GetSagGameOperation.dart';

class SAGGameRepositoryImpl extends SAGGameRepository {
  final CreateSagGameOperation createSagGameOperation;
  final GetSagGameOperation getSagGameOperation;
  final GetSagGamesOperation getSagGamesOperation;
  final UpsertUserSAGGameOperation _upsertUserSAGGameOperation;

  SAGGameRepositoryImpl(
    this.createSagGameOperation,
    this.getSagGameOperation,
    this.getSagGamesOperation,
    this._upsertUserSAGGameOperation,
  );

  @override
  Future<Result<void, BaseError>> createSAGGame(SAGGame sagGame) =>
      createSagGameOperation(sagGame);

  @override
  Future<Result<SAGGame, BaseError>> getSAGGame(String sagGameId) =>
      getSagGameOperation(sagGameId);

  @override
  Future<Result<PaginatedSagGames, BaseError>> getSAGGames(int limit) =>
      getSagGamesOperation(limit: limit);

  @override
  Future<Result<String, BaseError>> upsertUserSAGGameInfo(
    String gamesUserId,
    String? userSAGGameId,
    SAGGame sagGame,
  ) => _upsertUserSAGGameOperation(gamesUserId, userSAGGameId, sagGame);
}
