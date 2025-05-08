import 'package:guesswork/core/domain/entity/result.dart';

import '../repository/sag_game_repository.dart';

class CreateSAGGameUseCase {
  final SAGGameRepository _sagGameRepository;

  CreateSAGGameUseCase(this._sagGameRepository);

  Future<Result<void, BaseError>> call() async {
    throw UnimplementedError();
    // return _sagGameRepository.createSAGGame(sagGame);
  }
}
