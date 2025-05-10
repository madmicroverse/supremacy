import 'dart:async';

import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';

sealed class SetGamesSettingsUseCaseError extends BaseError {}

class SetGamesSettingsUseCaseUnauthorizedError
    extends SetGamesSettingsUseCaseError {}

class SetGamesSettingsUseCaseSystemError extends SetGamesSettingsUseCaseError {}

class SetGamesSettingsUseCase {
  final AccountRepository _accountRepository;

  SetGamesSettingsUseCase(this._accountRepository);

  Future<Result<void, SetGamesSettingsUseCaseError>> call(
    GamesSettings gamesSettings,
  ) async {
    final result = await _accountRepository.getGamesUser();
    switch (result) {
      case Success():
        final gamesUser = result.data;
        final newGamesUser = gamesUser.withSettings(gamesSettings);
        final upsertResult = await _accountRepository.upsertGamesUser(
          newGamesUser,
        );
        switch (upsertResult) {
          case Success():
            return Success(upsertResult.data);
          case Error():
            final upsertError = upsertResult.error;
            switch (upsertError) {
              case UpsertGamesUserDataAccessError():
                return Error(SetGamesSettingsUseCaseSystemError());
            }
        }
      case Error():
        final error = result.error;
        switch (error) {
          case GetGamesUserUnauthorizedError():
            return Error(SetGamesSettingsUseCaseUnauthorizedError());
          case GetGamesUserDataAccessError():
            return Error(SetGamesSettingsUseCaseSystemError());
        }
    }
  }
}
