import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guesswork/core/data/extension/firebase_auth_extension.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/firestore_paths.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/query_filter.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/sag_game_favorite/firestore_paths.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

class GetSAGGameFavoritesStreamOperation {
  final FirebaseFirestore _db;

  GetSAGGameFavoritesStreamOperation(this._db);

  Future<Result<Stream<List<SAGGame>>, BaseError>> call({
    required String gamesUserId,
    List<QueryFilter>? filters,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _db
          .collection(fsUserPath)
          .doc(gamesUserId)
          .collection(fsSAGGameFavoritePath);

      if (filters != null && filters.isNotEmpty) {
        for (final filter in filters) {
          query = query.where(
            filter.field,
            isEqualTo: filter.isEqualTo,
            isGreaterThan: filter.isGreaterThan,
            isGreaterThanOrEqualTo: filter.isGreaterThanOrEqualTo,
            isLessThan: filter.isLessThan,
            isLessThanOrEqualTo: filter.isLessThanOrEqualTo,
            arrayContains: filter.arrayContains,
            arrayContainsAny: filter.arrayContainsAny,
            whereIn: filter.whereIn,
            whereNotIn: filter.whereNotIn,
            isNull: filter.isNull,
          );
        }
      }

      return Success(
        query.snapshots().map((querySnapshot) {
          return querySnapshot.docs
              .map((doc) => SAGGame.fromJson(doc.dataWithId!))
              .toList();
        }),
      );
    } catch (error) {
      return Error(UnexpectedErrorError(error.toString()));
    }
  }
}
