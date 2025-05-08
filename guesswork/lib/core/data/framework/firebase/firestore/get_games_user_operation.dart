import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guesswork/core/data/extension/firebase_auth_extension.dart';
import 'package:guesswork/core/data/framework/firebase/firestore_paths.dart';
import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/extension/object_utils.dart';

class UnableToGetGamesUserError extends BaseError {}

class EmptyGameSettingsError extends BaseError {}

class GetGamesUserOperation {
  final FirebaseFirestore _db;

  GetGamesUserOperation(this._db);

  DocumentReference<Map<String, dynamic>> gamesUserCollection(String userId) =>
      _db.collection(fsUserPath).doc(userId);

  Future<Result<GamesUser, BaseError>> call(GamesUser gamesUser) async {
    try {
      final gamesUserDocRef = gamesUserCollection(gamesUser.id);
      final gamesUserDoc = await gamesUserDocRef.get();

      if (!gamesUserDoc.exists) {
        await gamesUserDocRef.set(gamesUser.toJson());
        return Success(gamesUser);
      }

      final data = gamesUserDoc.dataWithId;
      if (data.isNotNull) {
        return Success(GamesUser.fromJson(data!));
      } else {
        return Error(EmptyGameSettingsError());
      }
    } catch (error) {
      return Error(UnexpectedErrorError(error.toString()));
    }
  }
}
