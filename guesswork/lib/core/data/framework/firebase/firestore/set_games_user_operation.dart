import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/domain/entity/result.dart';

const userPath = "user";

class UnableToGetGamesUserError extends BaseError {}

class EmptyGameSettingsError extends BaseError {}

class SetGamesUserOperation {
  final FirebaseFirestore _db;

  SetGamesUserOperation(this._db);

  DocumentReference<Map<String, dynamic>> gamesUserCollection(String userId) =>
      _db.collection(userPath).doc(userId);

  Future<Result<void, BaseError>> call(GamesUser gamesUser) async {
    try {
      final gamesUserDocRef = gamesUserCollection(gamesUser.id);
      await gamesUserDocRef.set(gamesUser.toJson());
      return Success(gamesUser);
    } catch (error) {
      return Error(UnexpectedErrorError(error.toString()));
    }
  }
}
