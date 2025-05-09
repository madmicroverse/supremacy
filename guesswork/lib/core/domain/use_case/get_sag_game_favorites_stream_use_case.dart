import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/repository/games_favorite_repository.dart';

class GetSAGGameFavoritesStreamUseCase {
  final AccountRepository _accountRepository;
  final SAGGameFavoriteRepository _sagGameFavoriteRepository;
  int? points;

  GetSAGGameFavoritesStreamUseCase(
    this._accountRepository,
    this._sagGameFavoriteRepository,
  );

  Future<Result<Stream<List<SAGGame>>, BaseError>> call() async {
    final result = await _accountRepository.getGamesUser();
    switch (result) {
      case Success():
        final gamesUser = result.data;
        return _sagGameFavoriteRepository.getSAGGameFavoritesStream(
          gamesUser.id,
        );
      case Error():
        return Error(result.error);
    }
  }
}
