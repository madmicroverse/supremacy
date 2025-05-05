import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guesswork/core/data/framework/firebase/firestore_framework.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

class UpsertUserSAGGameOperation {
  final FirebaseFirestore _db;

  UpsertUserSAGGameOperation(this._db);

  CollectionReference<Map<String, dynamic>> gamesUserDoc(
    String userId,
    String? userSAGGameId,
  ) => _db.collection(userPath).doc(userId).collection(sagGameCollectionPath);

  Future<Result<String, BaseError>> call(
    String gamesUserId,
    String? userSAGGameId,
    SAGGame sagGame,
  ) async {
    try {
      final userSAGGameColRef = gamesUserDoc(gamesUserId, userSAGGameId);
      var userSAGGameDocRef = userSAGGameColRef.doc(userSAGGameId);
      var userSAGGameDoc = await userSAGGameDocRef.get();

      final sagGameJson = sagGame.toJson();
      if (userSAGGameDoc.exists) {
        userSAGGameDocRef.set(sagGameJson);
      } else {
        userSAGGameDocRef = await userSAGGameColRef.add(sagGameJson);
      }
      return Success(userSAGGameDocRef.id);
    } catch (error) {
      return Error(UnexpectedErrorError(error.toString()));
    }
  }
}
