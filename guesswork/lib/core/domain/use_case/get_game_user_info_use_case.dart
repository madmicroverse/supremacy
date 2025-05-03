import 'dart:async';

import 'package:guesswork/core/domain/entity/account/games_user_progress.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';

class GetGamesUserInfoUseCase {
  final AccountRepository _accountRepository;

  GetGamesUserInfoUseCase(this._accountRepository);

  Future<Result<GamesUserProgress, BaseError>> call() async =>
      await _accountRepository.getGameUserInfo();
}
