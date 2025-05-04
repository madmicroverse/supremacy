import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

abstract class SAGGameRepository {
  Future<Result<void, BaseError>> createSAGGame(SAGGame sagGame);

  Future<Result<SAGGame, BaseError>> getSAGGame(String sagGameId);

  Future<List<SAGGamePreview>> getSAGGamePreviewList();
}
