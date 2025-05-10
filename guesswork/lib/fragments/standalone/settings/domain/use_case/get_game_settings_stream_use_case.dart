import 'dart:async';

import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';

sealed class GetGamesSettingsStreamUseCaseError extends BaseError {}

class GetGamesSettingsStreamUseCaseUnauthorizedError
    extends GetGamesSettingsStreamUseCaseError {}

class GetGamesSettingsStreamUseCaseDataAccessError
    extends GetGamesSettingsStreamUseCaseError {}

class GetGamesSettingsStreamUseCase {
  final AccountRepository _accountRepository;
  GamesSettings? gamesSettings;

  GetGamesSettingsStreamUseCase(this._accountRepository);

  Future<Result<Stream<GamesSettings>, GetGamesSettingsStreamUseCaseError>>
  call() async {
    final result = await _accountRepository.getGamesUserStream();
    switch (result) {
      case Success():
        return Success(
          result.data
              .where((gamesUser) {
                final areEqual =
                    gamesSettings?.haptic == gamesUser.gamesSettings.haptic &&
                    gamesSettings?.sound == gamesUser.gamesSettings.sound &&
                    gamesSettings?.music == gamesUser.gamesSettings.music;
                gamesSettings = gamesUser.gamesSettings;
                return !areEqual;
              })
              .map((gamesUser) {
                return gamesUser.gamesSettings;
              }),
        );
      case Error():
        final error = result.error;
        switch (error) {
          case GetGamesUserStreamUnauthorizedError():
            return Error(GetGamesSettingsStreamUseCaseUnauthorizedError());
          case GetGamesUserStreamDataAccessError():
            return Error(GetGamesSettingsStreamUseCaseDataAccessError());
        }
    }
  }
}
