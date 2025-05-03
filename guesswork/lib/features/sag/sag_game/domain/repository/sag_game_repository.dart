import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

abstract class SAGGameRepository {
  Future<List<SAGGamePreview>> getSAGGamePreviewList();

  Future<SAGGame> getSAGGame(String url);
}
