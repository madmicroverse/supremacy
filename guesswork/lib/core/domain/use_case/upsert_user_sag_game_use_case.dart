import 'dart:async';

import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';

class UpsertUserSAGGameUseCase {
  final AccountRepository _accountRepository;

  UpsertUserSAGGameUseCase(this._accountRepository);

  Future<Result<String, BaseError>> call(
    String? userSAGGameId,
    SAGGame sagGame,
  ) async {
    final result = await _accountRepository.getGamesUser();
    switch (result) {
      case Success():
        final gamesUser = result.data;
        return _accountRepository.upsertUserSAGGameInfo(
          gamesUser.id,
          userSAGGameId,
          sagGame,
        );
      case Error():
        return Error(result.error);
    }
  }
}
