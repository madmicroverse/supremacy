import 'package:guesswork/core/domain/entity/account/games_user_progress.dart';

import '../entity/account/games_user.dart';
import '../entity/result.dart';

abstract class AccountRepository {
  Future<Result<GamesUser, BaseError>> getGamesUser();

  Future<Result<Stream<GamesUser>, BaseError>> getGamesUserStream();

  Future<Result<void, BaseError>> setGamesUser(GamesUser gamesUser);

  Future<Result<GamesUserProgress, BaseError>> getGameUserInfo();
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
