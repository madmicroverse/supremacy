import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/firestore_paths.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/sag_game_favorite/firestore_paths.dart';
import 'package:guesswork/core/domain/entity/result.dart';

sealed class DeleteSAGGameFavoriteOperationError extends BaseError {}

class DeleteSAGGameFavoriteOperationDataAccessError
    extends DeleteSAGGameFavoriteOperationError {}

class DeleteSAGGameFavoriteOperation {
  final FirebaseFirestore _db;

  DeleteSAGGameFavoriteOperation(this._db);

  Future<Result<void, DeleteSAGGameFavoriteOperationError>> call(
    String gamesUserId,
    String sagGameFavoriteId,
  ) async {
    try {
      final gamesUserSAGGameFavoriteDocRef = _db
          .collection(fsUserPath)
          .doc(gamesUserId)
          .collection(fsSAGGameFavoritePath)
          .doc(sagGameFavoriteId);
      await gamesUserSAGGameFavoriteDocRef.delete();
      return Success(null);
    } catch (error) {
      return Error(DeleteSAGGameFavoriteOperationDataAccessError());
    }
  }
}
