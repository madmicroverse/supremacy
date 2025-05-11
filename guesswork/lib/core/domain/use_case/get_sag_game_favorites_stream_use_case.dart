import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/repository/games_favorite_repository.dart';

sealed class GetSAGGameFavoritesStreamUseCaseError extends BaseError {}

class GetSAGGameFavoritesStreamUseCaseDataAccessError
    extends GetSAGGameFavoritesStreamUseCaseError {}

class GetSAGGameFavoritesStreamUseCaseUnauthorizedError
    extends GetSAGGameFavoritesStreamUseCaseError {}

class GetSAGGameFavoritesStreamUseCase {
  final AccountRepository _accountRepository;
  final SAGGameFavoriteRepository _sagGameFavoriteRepository;
  int? points;

  GetSAGGameFavoritesStreamUseCase(
    this._accountRepository,
    this._sagGameFavoriteRepository,
  );

  Future<Result<Stream<List<SAGGame>>, GetSAGGameFavoritesStreamUseCaseError>>
  call() async {
    final result = await _accountRepository.getGamesUser();
    switch (result) {
      case Success():
        final gamesUser = result.data;
        final streamResult = await _sagGameFavoriteRepository
            .getSAGGameFavoritesStream(gamesUser.id);
        switch (streamResult) {
          case Success<
            Stream<List<SAGGame>>,
            SAGGameFavoriteRepositoryGetSAGGameFavoritesStreamError
          >():
            return Success(streamResult.data);
          case Error():
            final streamError = streamResult.error;
            switch (streamError) {
              case SAGGameFavoriteRepositoryGetSAGGameFavoritesStreamDataAccessError():
                return Error(GetSAGGameFavoritesStreamUseCaseDataAccessError());
            }
        }
      case Error():
        final error = result.error;
        switch (error) {
          case GetGamesUserUnauthorizedError():
            return Error(GetSAGGameFavoritesStreamUseCaseUnauthorizedError());
          case GetGamesUserDataAccessError():
            return Error(GetSAGGameFavoritesStreamUseCaseDataAccessError());
        }
    }
  }
}
