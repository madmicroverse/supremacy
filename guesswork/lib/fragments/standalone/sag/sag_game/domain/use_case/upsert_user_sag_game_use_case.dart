import 'dart:async';

import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/extension/sag_game.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/domain/repository/sag_game_repository.dart';

sealed class UpsertUserSAGGameUseCaseError extends BaseError {}

class UpsertUserSAGGameUseCaseSystemError
    extends UpsertUserSAGGameUseCaseError {}

class UpsertUserSAGGameUseCaseConnectionError
    extends UpsertUserSAGGameUseCaseError {}

class UpsertUserSAGGameUseCaseUnauthorizedError
    extends UpsertUserSAGGameUseCaseError {}

class UpsertUserSAGGameUseCase {
  final AccountRepository _accountRepository;
  final SAGGameRepository _sagGameRepository;

  UpsertUserSAGGameUseCase(this._accountRepository, this._sagGameRepository);

  Future<Result<String, UpsertUserSAGGameUseCaseError>> call(
    String? userSAGGameId,
    SAGGame sagGame,
  ) async {
    final result = await _accountRepository.getAuthGamesUser();
    switch (result) {
      case Success():
        final gamesUser = result.data;
        final upsertResult = await _sagGameRepository.upsertUserSAGGame(
          gamesUserId: gamesUser.id,
          userSAGGameId: userSAGGameId,
          sagGame: sagGame,
          sagGameUnique: sagGame.isCompleted ? sagGame.withoutAnswers : null,
        );
        switch (upsertResult) {
          case Success():
            return Success(upsertResult.data);
          case Error():
            final upsertError = upsertResult.error;
            switch (upsertError) {
              case GetSAGGamesUpsertUserSAGGameSystemError():
                return Error(UpsertUserSAGGameUseCaseSystemError());
              case GetSAGGamesUpsertUserSAGGameConnectionError():
                return Error(UpsertUserSAGGameUseCaseConnectionError());
            }
        }
      case Error():
        final error = result.error;
        switch (error) {
          case GetAuthGamesUserUnauthorizedError():
            return Error(UpsertUserSAGGameUseCaseUnauthorizedError());
        }
    }
  }
}
