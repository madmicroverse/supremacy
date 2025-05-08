import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/entity/games_favorite.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/repository/games_favorite_repository.dart';

class GetGamesFavoritesStreamUseCase {
  final AccountRepository _accountRepository;
  final GamesFavoriteRepository _gamesFavoriteRepository;
  int? points;

  GetGamesFavoritesStreamUseCase(
    this._accountRepository,
    this._gamesFavoriteRepository,
  );

  Future<Result<Stream<List<GamesFavorite>>, BaseError>> call() async {
    final result = await _accountRepository.getGamesUser();
    switch (result) {
      case Success():
        final gamesUser = result.data;
        return _gamesFavoriteRepository.getGamesFavoritesStream(gamesUser.id);
      case Error():
        return Error(result.error);
    }
  }
}
