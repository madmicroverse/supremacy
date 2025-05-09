import 'dart:async';

import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/extension/sag_game.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/domain/repository/sag_game_repository.dart';

class UpsertUserSAGGameUseCase {
  final AccountRepository _accountRepository;
  final SAGGameRepository _sagGameRepository;

  UpsertUserSAGGameUseCase(this._accountRepository, this._sagGameRepository);

  Future<Result<String, BaseError>> call(
    String? userSAGGameId,
    SAGGame sagGame,
  ) async {
    final result = await _accountRepository.getGamesUser();
    switch (result) {
      case Success():
        final gamesUser = result.data;
        return _sagGameRepository.upsertUserSAGGameInfo(
          gamesUserId: gamesUser.id,
          userSAGGameId: userSAGGameId,
          sagGame: sagGame,
          sagGameUnique: sagGame.isCompleted ? sagGame.withoutAnswers : null,
        );
      case Error():
        return Error(result.error);
    }
  }
}
