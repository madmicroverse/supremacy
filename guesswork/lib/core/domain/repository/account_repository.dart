import '../entity/account/games_user.dart';
import '../entity/result.dart';

sealed class GetAuthGamesUserError extends BaseError {}

class GetAuthGamesUserUnauthorizedError extends GetAuthGamesUserError {}

sealed class GetGamesUserError extends BaseError {}

class GetGamesUserUnauthorizedError extends GetGamesUserError {}

class GetGamesUserDataAccessError extends GetGamesUserError {}

sealed class GetGamesUserStreamError extends BaseError {}

class GetGamesUserStreamUnauthorizedError extends GetGamesUserStreamError {}

class GetGamesUserStreamDataAccessError extends GetGamesUserStreamError {}

sealed class UpsertGamesUserError extends BaseError {}

class UpsertGamesUserDataAccessError extends UpsertGamesUserError {}

abstract class AccountRepository {
  Future<Result<GamesUser, GetAuthGamesUserError>> getAuthGamesUser();

  Future<Result<GamesUser, GetGamesUserError>> getGamesUser();

  Future<Result<Stream<GamesUser>, GetGamesUserStreamError>>
  getGamesUserStream();

  Future<Result<void, UpsertGamesUserError>> upsertGamesUser(
    GamesUser gamesUser,
  );
}

extension AccountRepositoryUtils on AccountRepository {
  Future<GamesUser?> get gamesUser async {
    final result = await getGamesUser();
    switch (result) {
      case Success():
        return result.data;
      case Error():
        return null;
    }
  }
}
