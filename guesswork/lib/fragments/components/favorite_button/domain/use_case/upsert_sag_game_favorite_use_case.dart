import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/repository/games_favorite_repository.dart';

class UpsertSAGGameFavoriteUseCase {
  final AccountRepository _accountRepository;
  final SAGGameFavoriteRepository _gamesFavoriteRepository;
  int? points;

  UpsertSAGGameFavoriteUseCase(
    this._accountRepository,
    this._gamesFavoriteRepository,
  );

  Future<Result<void, BaseError>> call(SAGGame sagGame) async {
    final result = await _accountRepository.getGamesUser();
    switch (result) {
      case Success():
        final gamesUser = result.data;
        _gamesFavoriteRepository.upsertSAGGameFavorite(gamesUser.id, sagGame);
        return Success(null);
      case Error():
        return Error(result.error);
    }
  }
}
