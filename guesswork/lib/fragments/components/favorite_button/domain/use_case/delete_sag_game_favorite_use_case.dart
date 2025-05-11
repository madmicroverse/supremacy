import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/repository/games_favorite_repository.dart';

sealed class DeleteSAGGameFavoriteUseCaseError extends BaseError {}

class DeleteSAGGameFavoriteUseCaseDataAccessError
    extends DeleteSAGGameFavoriteUseCaseError {}

class DeleteSAGGameFavoriteUseCaseUnauthorizedError
    extends DeleteSAGGameFavoriteUseCaseError {}

class DeleteSAGGameFavoriteUseCase {
  final AccountRepository _accountRepository;
  final SAGGameFavoriteRepository _gamesFavoriteRepository;
  int? points;

  DeleteSAGGameFavoriteUseCase(
    this._accountRepository,
    this._gamesFavoriteRepository,
  );

  Future<Result<void, DeleteSAGGameFavoriteUseCaseError>> call(
    String sagGameFavoriteId,
  ) async {
    final result = await _accountRepository.getGamesUser();
    switch (result) {
      case Success():
        final gamesUser = result.data;
        final deleteResult = await _gamesFavoriteRepository
            .deleteSAGGameFavorite(gamesUser.id, sagGameFavoriteId);
        switch (deleteResult) {
          case Success():
            return Success(null);
          case Error():
            final deleteError = deleteResult.error;
            switch (deleteError) {
              case SAGGameFavoriteRepositoryDeleteSAGGameFavoriteDataAccessError():
                return Error(DeleteSAGGameFavoriteUseCaseDataAccessError());
            }
        }
      case Error():
        final error = result.error;
        switch (error) {
          case GetGamesUserUnauthorizedError():
            return Error(DeleteSAGGameFavoriteUseCaseUnauthorizedError());
          case GetGamesUserDataAccessError():
            return Error(DeleteSAGGameFavoriteUseCaseDataAccessError());
        }
    }
  }
}
