import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guesswork/core/data/extension/firebase_auth_extension.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/firestore_paths.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/query_filter.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/fragments/standalone/sag/data/framework/firebase/firestore/firestore_framework.dart';

sealed class GetSagGamesOperationError extends BaseError {}

class GetSagGamesOperationUnknownError extends GetSagGamesOperationError {}

enum SAGGameSource { main, replay }

class GetSagGamesOperation {
  final FirebaseFirestore _db;

  GetSagGamesOperation(this._db);

  Future<Result<PaginatedSagGames, GetSagGamesOperationError>> call({
    String? gamesUserId,
    required SAGGameSource sagGameSource,
    required int limit,
    DocumentSnapshot? startAfterDocument,
    List<QueryFilter>? filters,
  }) async {
    try {
      Query<Map<String, dynamic>> query = getQuery(sagGameSource, gamesUserId);
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
      return Error(GetSagGamesOperationUnknownError());
    }
  }

  Query<Map<String, dynamic>> getQuery(
    SAGGameSource sagGameSource,
    String? gameUserId,
  ) {
    switch (sagGameSource) {
      case SAGGameSource.main:
        return _db.collection(fsSAGGamePath);
      case SAGGameSource.replay:
        return _db
            .collection(fsUserPath)
            .doc(gameUserId)
            .collection(fsSAGGameReplayPath);
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
