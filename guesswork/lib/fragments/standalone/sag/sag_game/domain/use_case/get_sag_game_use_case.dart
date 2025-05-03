import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

import '../repository/sag_game_repository.dart';

class GetSAGGameUseCase {
  final SAGGameRepository _sagGameRepository;

  GetSAGGameUseCase(this._sagGameRepository);

  Future<SAGGame> call(String url) {
    return _sagGameRepository.getSAGGame("");
  }
}
