import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/fragments/standalone/sag/data/framework/firebase/firestore/firestore_framework.dart';

class UnableToCreateSAGGameError extends BaseError {}

class CreateSagGameOperation {
  final FirebaseFirestore _db;

  CreateSagGameOperation(this._db);

  CollectionReference<Map<String, dynamic>> get sagGameCollection =>
      _db.collection(fsSAGGamePath);

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
