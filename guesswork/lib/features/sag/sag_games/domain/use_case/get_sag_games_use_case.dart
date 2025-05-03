import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

import '../../../sag_game/domain/repository/sag_game_repository.dart';

class GetSAGGamesUseCase {
  final SAGGameRepository _sagGameRepository;

  GetSAGGamesUseCase(this._sagGameRepository);

  Future<List<SAGGamePreview>> call() {
    return _sagGameRepository.getSAGGamePreviewList();
  }
}
