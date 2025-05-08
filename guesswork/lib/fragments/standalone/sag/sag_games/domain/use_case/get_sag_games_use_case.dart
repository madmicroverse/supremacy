import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/data/framework/firestore_operations/GetSagGamesOperation.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/domain/repository/sag_game_repository.dart';

class GetSAGGamesUseCase {
  final AccountRepository _accountRepository;
  final SAGGameRepository _sagGameRepository;

  GetSAGGamesUseCase(this._accountRepository, this._sagGameRepository);

  Future<Result<PaginatedSagGames, BaseError>> call({
    required SAGGameSource sagGameSource,
    required int limit,
  }) async {
    switch (sagGameSource) {
      case SAGGameSource.main:
      case SAGGameSource.top:
        return _sagGameRepository.getSAGGames(
          sagGameSource: sagGameSource,
          limit: limit,
        );
      case SAGGameSource.replay:
        final result = await _accountRepository.getGamesUser();
        switch (result) {
          case Success():
            return _sagGameRepository.getSAGGames(
              gamesUserId: result.data.id,
              sagGameSource: sagGameSource,
              limit: limit,
            );
          case Error():
            return Error(result.error);
        }
      case SAGGameSource.favorite:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
