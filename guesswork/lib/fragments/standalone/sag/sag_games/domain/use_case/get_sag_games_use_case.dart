import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/data/framework/firestore_operations/GetSagGamesOperation.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/domain/repository/sag_game_repository.dart';

sealed class GetSAGGamesUseCaseError extends BaseError {}

class AuthError extends GetSAGGamesUseCaseError {}

class NoDataAvailableError extends GetSAGGamesUseCaseError {}

class GetSAGGamesUseCase {
  final AccountRepository _accountRepository;
  final SAGGameRepository _sagGameRepository;

  GetSAGGamesUseCase(this._accountRepository, this._sagGameRepository);

  Future<Result<PaginatedSagGames, GetSAGGamesUseCaseError>> call({
    required SAGGameSource sagGameSource,
    required int limit,
  }) async {
    final gamesUserResult = await _accountRepository.getGamesUser();
    switch (gamesUserResult) {
      case Success():
        final autResult = await _sagGameRepository.getSAGGames(
          gamesUserId: gamesUserResult.data.id,
          sagGameSource: sagGameSource,
          limit: limit,
        );
        switch (autResult) {
          case Success():
            return Success(autResult.data);
          case Error():
            return Error(NoDataAvailableError());
        }
      case Error():
        return Error(AuthError());
    }
  }
}
