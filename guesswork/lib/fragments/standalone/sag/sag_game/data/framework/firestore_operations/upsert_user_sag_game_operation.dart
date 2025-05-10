import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guesswork/core/data/framework/firebase/firestore/firestore_paths.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/extension/object_utils.dart';
import 'package:guesswork/fragments/standalone/sag/data/framework/firebase/firestore/firestore_framework.dart';

sealed class UpsertUserSAGGameOperationError extends BaseError {}

class UpsertUserSAGGameOperationParsingError
    extends UpsertUserSAGGameOperationError {}

class UpsertUserSAGGameOperationConnectionError
    extends UpsertUserSAGGameOperationError {}

class UpsertUserSAGGameOperation {
  final FirebaseFirestore _db;

  UpsertUserSAGGameOperation(this._db);

  CollectionReference<Map<String, dynamic>> gamesUserSagGamesDoc(
    String userId,
  ) => _db.collection(fsUserPath).doc(userId).collection(fsSAGGamePath);

  CollectionReference<Map<String, dynamic>> gamesUserSagGamesUniqueDoc(
    String userId,
  ) => _db.collection(fsUserPath).doc(userId).collection(fsSAGGameUniquePath);

  Future<Result<String, UpsertUserSAGGameOperationError>> call({
    required String gamesUserId,
    String? userSAGGameId,
    required SAGGame sagGame,
    SAGGame? sagGameUnique,
  }) => _db
      .runTransaction<Result<String, UpsertUserSAGGameOperationError>>(
        (transaction) async {
          try {
            final userSAGGameColRef = gamesUserSagGamesDoc(gamesUserId);
            final sagGameJson = sagGame.toJson();
            late DocumentReference<Map<String, dynamic>> userSAGGameDocRef;
            if (userSAGGameId.isNotNull) {
              userSAGGameDocRef = userSAGGameColRef.doc(userSAGGameId);
            } else {
              userSAGGameDocRef = userSAGGameColRef.doc();
            }
            transaction.set(userSAGGameDocRef, sagGameJson);

            if (sagGameUnique.isNotNull) {
              final userSAGGameUniqueColRef = gamesUserSagGamesUniqueDoc(
                gamesUserId,
              );
              final userSAGGameUniqueDocRef = userSAGGameUniqueColRef.doc(
                sagGame.id,
              );
              final userSAGGameUniqueDoc = await userSAGGameUniqueDocRef.get();
              if (!userSAGGameUniqueDoc.exists) {
                final sagGameJsonWithoutAnswers = sagGameUnique!.toJson();
                transaction.set(
                  userSAGGameUniqueDocRef,
                  sagGameJsonWithoutAnswers,
                );
              }
            }
            return Success(userSAGGameDocRef.id);
          } catch (error) {
            return Error(UpsertUserSAGGameOperationParsingError());
          }
        },
        timeout: Duration(seconds: 15),
        maxAttempts: 1,
      )
      .catchError((error) {
        return Error<String, UpsertUserSAGGameOperationError>(
          UpsertUserSAGGameOperationConnectionError(),
        );
      });
}
