import 'package:guesswork/core/data/framework/firebase/firestore/sag_game_selection/sag_game_favorite/upsert_sag_game_selection_operation.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

sealed class SAGGameSelectionRepositoryGetSAGGameSelectionsStreamError
    extends BaseError {}

class SAGGameSelectionRepositoryGetSAGGameSelectionsStreamDataAccessError
    extends SAGGameSelectionRepositoryGetSAGGameSelectionsStreamError {}

sealed class SAGGameSelectionRepositoryUpsertSAGGameSelectionError
    extends BaseError {}

class SAGGameSelectionRepositoryUpsertSAGGameSelectionDataAccessError
    extends SAGGameSelectionRepositoryUpsertSAGGameSelectionError {}

sealed class SAGGameSelectionRepositoryDeleteSAGGameSelectionError
    extends BaseError {}

class SAGGameSelectionRepositoryDeleteSAGGameSelectionDataAccessError
    extends SAGGameSelectionRepositoryDeleteSAGGameSelectionError {}

abstract class SAGGameSelectionRepository {
  Future<
    Result<
      Stream<List<SAGGame>>,
      SAGGameSelectionRepositoryGetSAGGameSelectionsStreamError
    >
  >
  getSAGGameSelectionsStream(
    LiveSAGGameSource liveSAGGameSource,
    String gamesUserId,
  );

  Future<Result<void, SAGGameSelectionRepositoryUpsertSAGGameSelectionError>>
  upsertSAGGameSelection(
    LiveSAGGameSource liveSAGGameSource,
    String gamesUserId,
    SAGGame sagGameSelection,
  );

  Future<Result<void, SAGGameSelectionRepositoryDeleteSAGGameSelectionError>>
  deleteSAGGameSelection(String gamesUserId, String sagGameSelectionId);
}
