import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/main.dart';

import '../repository/sag_game_repository.dart';

class CreateSAGGameUseCase {
  final SAGGameRepository _sagGameRepository;

  CreateSAGGameUseCase(this._sagGameRepository);

  Future<Result<void, BaseError>> call() async {
    return _sagGameRepository.createSAGGame(sagGame);
  }
}
