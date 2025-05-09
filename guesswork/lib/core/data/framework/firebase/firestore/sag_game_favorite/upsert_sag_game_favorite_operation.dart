import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/firestore_paths.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/sag_game_favorite/firestore_paths.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

class UpsertSAGGameFavoriteOperation {
  final FirebaseFirestore _db;

  UpsertSAGGameFavoriteOperation(this._db);

  Future<Result<void, BaseError>> call(
    String gamesUserId,
    SAGGame sagGameFavorite,
  ) async {
    try {
      final sagGameFavoriteJson = sagGameFavorite.toJson();
      final gamesUserSAGGameFavoriteDocRef = _db
          .collection(fsUserPath)
          .doc(gamesUserId)
          .collection(fsSAGGameFavoritePath)
          .doc(sagGameFavorite.id);
      var gamesUserSAGGameFavoriteDoc =
          await gamesUserSAGGameFavoriteDocRef.get();
      if (!gamesUserSAGGameFavoriteDoc.exists) {
        gamesUserSAGGameFavoriteDocRef.set(sagGameFavoriteJson);
      }
      return Success(null);
    } catch (error) {
      return Error(UnexpectedErrorError(error.toString()));
    }
  }
}
