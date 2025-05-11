import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/firestore_paths.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/sag_game_selection/sag_game_favorite/firestore_paths.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

sealed class UpsertSAGGameSelectionOperationError extends BaseError {}

class UpsertSAGGameSelectionOperationDataAccessError
    extends UpsertSAGGameSelectionOperationError {}

class UpsertSAGGameSelectionOperation {
  final FirebaseFirestore _db;

  UpsertSAGGameSelectionOperation(this._db);

  Future<Result<void, UpsertSAGGameSelectionOperationError>> call(
    String gamesUserId,
    SAGGame sagGameSelection,
  ) async {
    try {
      final sagGameSelectionJson = sagGameSelection.toJson();
      final gamesUserSAGGameSelectionDocRef = _db
          .collection(fsUserPath)
          .doc(gamesUserId)
          .collection(fsSAGGameSelectionPath)
          .doc(sagGameSelection.id);
      var gamesUserSAGGameSelectionDoc =
          await gamesUserSAGGameSelectionDocRef.get();
      if (!gamesUserSAGGameSelectionDoc.exists) {
        gamesUserSAGGameSelectionDocRef.set(sagGameSelectionJson);
      }
      return Success(null);
    } catch (error) {
      return Error(UpsertSAGGameSelectionOperationDataAccessError());
    }
  }
}
