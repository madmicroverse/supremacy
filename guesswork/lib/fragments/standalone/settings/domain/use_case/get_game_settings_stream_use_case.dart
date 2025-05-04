import 'dart:async';

import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';

class GetGamesSettingsStreamUseCase {
  final AccountRepository _accountRepository;

  GetGamesSettingsStreamUseCase(this._accountRepository);

  Future<Result<Stream<GamesSettings>, BaseError>> call() async {
    final result = await _accountRepository.getGamesUserStream();
    switch (result) {
      case Success():
        return Success(result.data.map((gamesUser) => gamesUser.gamesSettings));
      case Error():
        return Error(result.error);
    }
  }
}
