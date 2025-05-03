import 'package:guesswork/core/domain/entity/account/games_user_progress.dart';
import 'package:guesswork/core/domain/entity/settings/games_settings.dart';

import '../entity/account/games_user.dart';
import '../entity/result.dart';

abstract class AccountRepository {
  Future<Result<GamesUser, BaseError>> getGamesUser();

  Future<Result<GamesUserProgress, BaseError>> getGameUserInfo();

  Future<Result<Stream<GamesSettings>, BaseError>> getGamesSettings(
    String userId,
  );

  Future<Result<bool, BaseError>> setGamesSettings(GamesSettings gamesSettings);
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
