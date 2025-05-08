import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/entity/games_favorite.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/repository/games_favorite_repository.dart';

class UpsertGamesFavoriteUseCase {
  final AccountRepository _accountRepository;
  final GamesFavoriteRepository _gamesFavoriteRepository;
  int? points;

  UpsertGamesFavoriteUseCase(
    this._accountRepository,
    this._gamesFavoriteRepository,
  );

  Future<Result<void, BaseError>> call(GamesFavorite gamesFavorite) async {
    final result = await _accountRepository.getGamesUser();
    switch (result) {
      case Success():
        final gamesUser = result.data;
        _gamesFavoriteRepository.upsertGamesFavorite(
          gamesUser.id,
          gamesFavorite,
        );
        return Success(null);
      case Error():
        return Error(result.error);
    }
  }
}
