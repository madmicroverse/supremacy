import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guesswork/core/data/extension/firebase_auth_extension.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/extension/object_utils.dart';
import 'package:guesswork/fragments/standalone/sag/data/framework/firebase/firestore/firestore_framework.dart';

class EmptySAGGameError extends BaseError {}

class GetSagGameOperation {
  final FirebaseFirestore _db;

  GetSagGameOperation(this._db);

  CollectionReference<Map<String, dynamic>> get sagGameCollection =>
      _db.collection(fsSAGGamePath);

  Future<Result<SAGGame, BaseError>> call(String sagGameId) async {
    try {
      final sagGameDocRef = sagGameCollection.doc(sagGameId);
      final documentSnapshot = await sagGameDocRef.get();
      var data = documentSnapshot.dataWithId;

      if (data.isNotNull) {
        return Success(SAGGame.fromJson(data!));
      } else {
        return Error(EmptySAGGameError());
      }
    } catch (error) {
      return Error(UnexpectedErrorError(error.toString()));
    }
  }
}
