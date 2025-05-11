import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/repository/games_favorite_repository.dart';

sealed class UpsertSAGGameFavoriteUseCaseError extends BaseError {}

class UpsertSAGGameFavoriteUseCaseDataAccessError
    extends UpsertSAGGameFavoriteUseCaseError {}

class UpsertSAGGameFavoriteUseCaseUnauthorizedError
    extends UpsertSAGGameFavoriteUseCaseError {}

class UpsertSAGGameFavoriteUseCase {
  final AccountRepository _accountRepository;
  final SAGGameFavoriteRepository _gamesFavoriteRepository;
  int? points;

  UpsertSAGGameFavoriteUseCase(
    this._accountRepository,
    this._gamesFavoriteRepository,
  );

  Future<Result<void, UpsertSAGGameFavoriteUseCaseError>> call(
    SAGGame sagGame,
  ) async {
    final result = await _accountRepository.getGamesUser();
    switch (result) {
      case Success():
        final gamesUser = result.data;
        final upsertResult = await _gamesFavoriteRepository
            .upsertSAGGameFavorite(gamesUser.id, sagGame);
        switch (upsertResult) {
          case Success():
            return Success(upsertResult.data);
          case Error():
            final upsertError = upsertResult.error;
            switch (upsertError) {
              case SAGGameFavoriteRepositoryUpsertSAGGameFavoriteDataAccessError():
                return Error(UpsertSAGGameFavoriteUseCaseDataAccessError());
            }
        }
      case Error():
        final error = result.error;
        switch (error) {
          case GetGamesUserUnauthorizedError():
            return Error(UpsertSAGGameFavoriteUseCaseUnauthorizedError());
          case GetGamesUserDataAccessError():
            return Error(UpsertSAGGameFavoriteUseCaseDataAccessError());
        }
    }
  }
}
