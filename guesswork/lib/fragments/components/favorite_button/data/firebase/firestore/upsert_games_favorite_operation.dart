import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guesswork/core/data/framework/firebase/firestore_framework.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/extension/object_utils.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/entity/games_favorite.dart';

class UpsertFavoriteOperation {
  final FirebaseFirestore _db;

  UpsertFavoriteOperation(this._db);

  CollectionReference<Map<String, dynamic>> gamesUserDoc(String userId) =>
      _db.collection(userPath).doc(userId).collection(favoriteCollectionPath);

  Future<Result<String, BaseError>> call(
    String gamesUserId,
    GamesFavorite favorite,
  ) async {
    try {
      final favoriteJson = favorite.toJson();
      final favoriteColRef = gamesUserDoc(gamesUserId);
      var favoriteDocRef = favoriteColRef.doc(favorite.id);
      if (favorite.id.isNotNull) {
        favoriteDocRef.set(favoriteJson);
      } else {
        favoriteDocRef = await favoriteColRef.add(favoriteJson);
      }
      return Success(favoriteDocRef.id);
    } catch (error) {
      return Error(UnexpectedErrorError(error.toString()));
    }
  }
}
