import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';

class AddCoinsStreamUseCase {
  final AccountRepository _accountRepository;

  AddCoinsStreamUseCase(this._accountRepository);

  Future<Result<void, BaseError>> call(int coinsAmount) async {
    final setGamesUserResult = await _accountRepository.getGamesUser();
    switch (setGamesUserResult) {
      case Success():
        return _accountRepository.upsertGamesUser(
          setGamesUserResult.data.addPoints(coinsAmount),
        );
      case Error():
        return Error(setGamesUserResult.error);
    }
  }
}
