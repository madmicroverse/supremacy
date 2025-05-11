import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/firestore_paths.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/sag_game_selection/sag_game_favorite/firestore_paths.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

sealed class UpsertSAGGameSelectionOperationError extends BaseError {}

class UpsertSAGGameSelectionOperationDataAccessError
    extends UpsertSAGGameSelectionOperationError {}

enum LiveSAGGameSource { favorites, top, event }

class UpsertSAGGameSelectionOperation {
  final FirebaseFirestore _db;

  UpsertSAGGameSelectionOperation(this._db);

  Future<Result<void, UpsertSAGGameSelectionOperationError>> call(
    LiveSAGGameSource liveSAGGameSource,
    String? gamesUserId,
    SAGGame sagGameSelection,
  ) async {
    try {
      final sagGameSelectionJson = sagGameSelection.toJson();
      final gamesUserSAGGameSelectionDocRef = _liveSAGGameToPath(
        liveSAGGameSource,
        gamesUserId,
      ).doc(sagGameSelection.id);
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

  CollectionReference<Map<String, dynamic>> _liveSAGGameToPath(
    LiveSAGGameSource sagGameSource,
    String? gamesUserId,
  ) {
    switch (sagGameSource) {
      case LiveSAGGameSource.favorites:
        return _db
            .collection(fsUserPath)
            .doc(gamesUserId)
            .collection(fsSAGGameFavoritePath);
      case LiveSAGGameSource.top:
        return _db.collection(fsSAGGameTopPath);
      case LiveSAGGameSource.event:
        return _db.collection(fsSAGGameEventPath);
    }
  }
}
