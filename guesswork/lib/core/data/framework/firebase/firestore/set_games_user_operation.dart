import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guesswork/core/data/framework/firebase/firestore_paths.dart';
import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/domain/entity/result.dart';

class SetGamesUserOperation {
  final FirebaseFirestore _db;

  SetGamesUserOperation(this._db);

  DocumentReference<Map<String, dynamic>> gamesUserCollection(String userId) =>
      _db.collection(fsUserPath).doc(userId);

  Future<Result<void, BaseError>> call(GamesUser gamesUser) async {
    try {
      final gamesUserDocRef = gamesUserCollection(gamesUser.id);
      await gamesUserDocRef.set(gamesUser.toJson());
      return Success(null);
    } catch (error) {
      return Error(UnexpectedErrorError(error.toString()));
    }
  }
}
