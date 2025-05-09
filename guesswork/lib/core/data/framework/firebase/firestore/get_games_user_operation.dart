import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guesswork/core/data/extension/firebase_auth_extension.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/firestore_paths.dart';
import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/domain/entity/result.dart';

sealed class GetGamesUserOperationError extends BaseError {}

class GetGamesUserOperationDataAccessError extends GetGamesUserOperationError {}

class GetGamesUserOperation {
  final FirebaseFirestore _db;

  GetGamesUserOperation(this._db);

  DocumentReference<Map<String, dynamic>> gamesUserCollection(String userId) =>
      _db.collection(fsUserPath).doc(userId);

  Future<Result<GamesUser, GetGamesUserOperationError>> call(
    GamesUser gamesUser, // This is a base GamesUser from authentication
  ) async {
    try {
      final gamesUserDocRef = gamesUserCollection(gamesUser.id);
      final gamesUserDoc = await gamesUserDocRef.get();
      if (!gamesUserDoc.exists) {
        // The first time we user the authentication GamesUser as a template
        await gamesUserDocRef.set(gamesUser.toJson());
        return Success(gamesUser);
      }
      final data = gamesUserDoc.dataWithId;
      return Success(GamesUser.fromJson(data!));
    } catch (error) {
      return Error(GetGamesUserOperationDataAccessError());
    }
  }
}
