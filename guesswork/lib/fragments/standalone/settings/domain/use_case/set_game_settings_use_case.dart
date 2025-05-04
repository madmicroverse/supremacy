import 'dart:async';

import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';

class SetGamesSettingsUseCase {
  final AccountRepository _accountRepository;

  SetGamesSettingsUseCase(this._accountRepository);

  Future<Result<void, BaseError>> call(GamesSettings gamesSettings) async {
    final result = await _accountRepository.getGamesUser();
    switch (result) {
      case Success():
        final gamesUser = result.data;
        final newGamesUser = gamesUser.withSettings(gamesSettings);
        return _accountRepository.setGamesUser(newGamesUser);
      case Error():
        return result;
    }
  }
}
