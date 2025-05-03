import 'dart:async';

import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/settings/games_settings.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';

class GetGamesSettingsUseCase {
  final AccountRepository _accountRepository;

  GetGamesSettingsUseCase(this._accountRepository);

  Future<Result<Stream<GamesSettings>, BaseError>> call() async {
    final result = await _accountRepository.getGamesUser();
    switch (result) {
      case Success():
        return _accountRepository.getGamesSettings(result.data.id);
      case Error():
        return Error(result.error);
    }
  }
}
