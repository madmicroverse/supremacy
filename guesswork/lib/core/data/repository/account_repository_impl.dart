import 'package:guesswork/core/data/framework/firebase/firestore/get_games_user_operation.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/get_games_user_stream_operation.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/set_games_user_operation.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/upsert_user_sag_game_operation.dart';
import 'package:guesswork/core/data/framework/firebase/user_framework.dart';
import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';

class AccountRepositoryImpl extends AccountRepository {
  final GetAuthGamesUserOperation _getAuthGamesUserOperation;
  final GetGamesUserOperation _getGamesUserOperation;
  final GetGamesUserStreamOperation _getGamesUserStreamOperation;
  final SetGamesUserOperation _setGamesUserOperation;
  final UpsertUserSAGGameOperation _upsertUserSAGGameOperation;

  AccountRepositoryImpl(
    this._getAuthGamesUserOperation,
    this._getGamesUserOperation,
    this._getGamesUserStreamOperation,
    this._setGamesUserOperation,
    this._upsertUserSAGGameOperation,
  );

  @override
  Future<Result<GamesUser, BaseError>> getGamesUser() async {
    final authResult = await _getAuthGamesUserOperation();
    switch (authResult) {
      case Success():
        return _getGamesUserOperation(authResult.data);
      case Error():
        return authResult;
    }
  }

  @override
  Future<Result<void, BaseError>> upsertGamesUser(GamesUser gamesUser) =>
      _setGamesUserOperation(gamesUser);

  @override
  Future<Result<Stream<GamesUser>, BaseError>> getGamesUserStream() async {
    final result = await _getAuthGamesUserOperation();
    switch (result) {
      case Success():
        return _getGamesUserStreamOperation(result.data);
      case Error():
        return Error(result.error);
    }
  }

  @override
  Future<Result<String, BaseError>> upsertUserSAGGameInfo(
    String gamesUserId,
    String? userSAGGameId,
    SAGGame sagGame,
  ) => _upsertUserSAGGameOperation(gamesUserId, userSAGGameId, sagGame);
}
