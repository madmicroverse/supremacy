import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/data/framework/firestore_operations/GetSagGamesOperation.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game/domain/repository/sag_game_repository.dart';

class GetSAGGamesUseCase {
  final SAGGameRepository _sagGameRepository;

  GetSAGGamesUseCase(this._sagGameRepository);

  Future<Result<PaginatedSagGames, BaseError>> call(int limit) {
    return _sagGameRepository.getSAGGames(limit);
  }
}
