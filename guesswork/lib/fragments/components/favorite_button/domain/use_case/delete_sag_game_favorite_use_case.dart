import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/repository/games_favorite_repository.dart';

class DeleteSAGGameFavoriteUseCase {
  final AccountRepository _accountRepository;
  final SAGGameFavoriteRepository _gamesFavoriteRepository;
  int? points;

  DeleteSAGGameFavoriteUseCase(
    this._accountRepository,
    this._gamesFavoriteRepository,
  );

  Future<Result<void, BaseError>> call(String sagGameFavoriteId) async {
    final result = await _accountRepository.getGamesUser();
    switch (result) {
      case Success():
        final gamesUser = result.data;
        _gamesFavoriteRepository.deleteSAGGameFavorite(
          gamesUser.id,
          sagGameFavoriteId,
        );
        return Success(null);
      case Error():
        return Error(result.error);
    }
  }
}
