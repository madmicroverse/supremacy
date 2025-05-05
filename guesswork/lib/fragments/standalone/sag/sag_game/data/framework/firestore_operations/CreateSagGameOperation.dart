import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guesswork/core/data/framework/firebase/firestore_framework.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';



class UnableToCreateSAGGameError extends BaseError {}

class CreateSagGameOperation {
  final FirebaseFirestore _db;

  CreateSagGameOperation(this._db);

  CollectionReference<Map<String, dynamic>> get sagGameCollection =>
      _db.collection(sagGameCollectionPath);

  Future<Result<void, BaseError>> call(SAGGame sagGame) async {
    try {
      DocumentReference newSAGGameDocRef = sagGameCollection.doc();
      await newSAGGameDocRef.set(sagGame.toJson());
      return Success(null);
    } catch (error) {
      return Error(UnexpectedErrorError(error.toString()));
    }
  }
}
