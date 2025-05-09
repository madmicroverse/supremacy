import '../entity/account/games_user.dart';
import '../entity/result.dart';

sealed class GetGamesUserError extends BaseError {}

class GetGamesUserUnauthorizedError extends GetGamesUserError {}

class GetGamesUserDataAccessError extends GetGamesUserError {}

sealed class GetAuthGamesUserError extends BaseError {}

class GetAuthGamesUserUnauthorizedError extends GetAuthGamesUserError {}

abstract class AccountRepository {
  Future<Result<GamesUser, GetAuthGamesUserError>> getAuthGamesUser();

  Future<Result<GamesUser, GetGamesUserError>> getGamesUser();

  Future<Result<Stream<GamesUser>, BaseError>> getGamesUserStream();

  Future<Result<void, BaseError>> upsertGamesUser(GamesUser gamesUser);
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
