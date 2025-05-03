import 'dart:async';

import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/settings/games_settings.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';

class SetGamesSettingsUseCase {
  final AccountRepository _accountRepository;

  SetGamesSettingsUseCase(this._accountRepository);

  Future<Result<bool, BaseError>> call(GamesSettings gamesSettings) async {
    // final result = await _accountRepository.getGamesUser();
    // switch (result) {
    //   case Success():
    return _accountRepository.setGamesSettings(gamesSettings);
    // case Error():
    //   return Error(result.error);
    // }
  }
}
