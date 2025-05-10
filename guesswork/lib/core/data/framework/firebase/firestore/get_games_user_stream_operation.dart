import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guesswork/core/data/extension/firebase_auth_extension.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/firestore_paths.dart';
import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/domain/entity/result.dart';

sealed class GetGamesUserStreamOperationError extends BaseError {}

class GetGamesUserStreamOperationDataAccessError
    extends GetGamesUserStreamOperationError {}

class GetGamesUserStreamOperation {
  final FirebaseFirestore _db;

  GetGamesUserStreamOperation(this._db);

  DocumentReference<Map<String, dynamic>> getGamesUserDocRef(String userId) =>
      _db.collection(fsUserPath).doc(userId);

  Future<Result<Stream<GamesUser>, GetGamesUserStreamOperationError>> call(
    GamesUser gamesUser,
  ) async {
    try {
      final gamesUserDocRef = getGamesUserDocRef(gamesUser.id);
      final gamesUserDoc = await gamesUserDocRef.get();

      if (!gamesUserDoc.exists) {
        await gamesUserDocRef.set(gamesUser.toJson());
      }

      return Success(
        gamesUserDocRef.snapshots().map(
          (snapshot) => GamesUser.fromJson(snapshot.dataWithId!),
        ),
      );
    } catch (error) {
      return Error(GetGamesUserStreamOperationDataAccessError());
    }
  }
}
