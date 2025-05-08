import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guesswork/core/data/extension/firebase_auth_extension.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/query_filter.dart';
import 'package:guesswork/core/data/framework/firebase/firestore_framework.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/fragments/components/favorite_button/domain/entity/games_favorite.dart';

class GetSagGamesStreamOperation {
  final FirebaseFirestore _db;

  GetSagGamesStreamOperation(this._db);

  Query<Map<String, dynamic>> gamesFavoriteCollection(String gamesUserId) =>
      _db.doc(gamesUserId).collection(favoriteCollectionPath);

  Future<Result<Stream<List<GamesFavorite>>, BaseError>> call({
    required String gamesUserId,
    List<QueryFilter>? filters,
  }) async {
    try {
      Query<Map<String, dynamic>> query = gamesFavoriteCollection(gamesUserId);

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
              .map((doc) => GamesFavorite.fromJson(doc.dataWithId!))
              .toList();
        }),
      );
    } catch (error) {
      return Error(UnexpectedErrorError(error.toString()));
    }
  }
}
