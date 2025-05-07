import 'dart:async';

import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';

class GetGamesSettingsStreamUseCase {
  final AccountRepository _accountRepository;
  GamesSettings? gamesSettings;

  GetGamesSettingsStreamUseCase(this._accountRepository);

  Future<Result<Stream<GamesSettings>, BaseError>> call() async {
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
        return Error(result.error);
    }
  }
}
