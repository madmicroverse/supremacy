import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/firestore_paths.dart';
import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/domain/entity/result.dart';

sealed class SetGamesUserOperationError extends BaseError {}

class SetGamesUserOperationDataAccessError extends SetGamesUserOperationError {}

class SetGamesUserOperation {
  final FirebaseFirestore _db;

  SetGamesUserOperation(this._db);

  DocumentReference<Map<String, dynamic>> gamesUserCollection(String userId) =>
      _db.collection(fsUserPath).doc(userId);

  Future<Result<void, SetGamesUserOperationError>> call(
    GamesUser gamesUser,
  ) async {
    try {
      final gamesUserDocRef = gamesUserCollection(gamesUser.id);
      await gamesUserDocRef.set(gamesUser.toJson());
      return Success(null);
    } catch (error) {
      return Error(SetGamesUserOperationDataAccessError());
    }
  }
}
