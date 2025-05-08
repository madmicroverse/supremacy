import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guesswork/core/data/extension/firebase_auth_extension.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/query_filter.dart';
import 'package:guesswork/core/data/framework/firebase/firestore_framework.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

class EmptySAGGameError extends BaseError {}

class EmptySAGGamesError extends BaseError {}

class GetSagGamesOperation {
  final FirebaseFirestore _db;

  GetSagGamesOperation(this._db);

  /// Fetches multiple SAG games with pagination
  ///
  /// [limit] - Number of documents to fetch per page
  /// [startAfterDocument] - The document to start after for pagination (null for first page)
  /// [filters] - Optional query filters to apply
  Future<Result<PaginatedSagGames, BaseError>> call({
    required int limit,
    DocumentSnapshot? startAfterDocument,
    List<QueryFilter>? filters,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _db.collection(sagGameCollectionPath);

      // Apply any filters if provided
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

      // Apply pagination
      query = query.limit(limit);

      // If we have a start document, use it for pagination
      if (startAfterDocument != null) {
        query = query.startAfterDocument(startAfterDocument);
      }

      // Execute the query
      final querySnapshot = await query.get();
      final documents = querySnapshot.docs;

      if (documents.isEmpty) {
        return Error(EmptySAGGamesError());
      }

      // Convert documents to SAGGame objects
      final games =
          documents.map((doc) {
            final data = doc.dataWithId;
            return SAGGame.fromJson(data!);
          }).toList();

      // Create pagination result
      final hasMore = documents.length >= limit;
      final lastDocument = documents.isNotEmpty ? documents.last : null;

      return Success(
        PaginatedSagGames(
          games: games,
          hasMore: hasMore,
          lastDocument: lastDocument,
        ),
      );
    } catch (error) {
      return Error(UnexpectedErrorError(error.toString()));
    }
  }
}

/// Class to hold paginated results
class PaginatedSagGames {
  final List<SAGGame> games;
  final bool hasMore;
  final DocumentSnapshot? lastDocument;

  PaginatedSagGames({
    required this.games,
    required this.hasMore,
    this.lastDocument,
  });
}
