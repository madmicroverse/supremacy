import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/firestore_paths.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/sag_game_selection/sag_game_favorite/firestore_paths.dart';
import 'package:guesswork/core/domain/entity/result.dart';

sealed class DeleteSAGGameSelectionOperationError extends BaseError {}

class DeleteSAGGameSelectionOperationDataAccessError
    extends DeleteSAGGameSelectionOperationError {}

class DeleteSAGGameSelectionOperation {
  final FirebaseFirestore _db;

  DeleteSAGGameSelectionOperation(this._db);

  Future<Result<void, DeleteSAGGameSelectionOperationError>> call(
    String gamesUserId,
    String sagGameSelectionId,
  ) async {
    try {
      final gamesUserSAGGameSelectionDocRef = _db
          .collection(fsUserPath)
          .doc(gamesUserId)
          .collection(fsSAGGameSelectionPath)
          .doc(sagGameSelectionId);
      await gamesUserSAGGameSelectionDocRef.delete();
      return Success(null);
    } catch (error) {
      return Error(DeleteSAGGameSelectionOperationDataAccessError());
    }
  }
}
