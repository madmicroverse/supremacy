import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/domain/entity/account/games_user_progress.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/extension/object_utils.dart';

const gamesUserIdPlaceholder = "{gamesUserIdPlaceholder}";
const userPath = "/users/$gamesUserIdPlaceholder";

extension GamesSettingsData on GamesSettings {
  Map<String, dynamic> get snapshotData => toJson()..remove('id');
}

extension DocumentSnapshotUtils on DocumentSnapshot<Map<String, dynamic>> {
  GamesSettings gamesSettings(String id) {
    var incompleteData = data();
    if (incompleteData.isNull) return GamesSettings(id: id);
    return GamesSettings.fromJson(incompleteData!).copyWith(id: id);
  }
}

class FirestoreFramework {
  final FirebaseFirestore _db;

  FirestoreFramework(this._db);

  Future<Result<GamesUserProgress, BaseError>> getGamesUserInfo() async {
    return Success(GamesUserProgress(points: 10000));
  }

  Future<Result<Stream<GamesSettings>, BaseError>> getSettings(
    String userId,
  ) async {
    try {
      final docPath = userPath.replaceAll(gamesUserIdPlaceholder, userId);
      final docRef = _db.doc(docPath);
      final doc = await docRef.get();

      if (!doc.exists) {
        await docRef.set(GamesSettings().snapshotData);
      }

      return Success(docRef.snapshots().map((qs) => qs.gamesSettings(userId)));
    } catch (error) {
      return Error(UnexpectedErrorError(error.toString()));
    }
  }

  Future<Result<bool, BaseError>> setSettings(
    GamesSettings gamesSettings,
  ) async {
    try {
      final docPath = userPath.replaceAll(
        gamesUserIdPlaceholder,
        gamesSettings.id,
      );

      final docRef = _db.doc(docPath);

      await docRef.set(gamesSettings.snapshotData);

      return Success(true);
    } catch (error) {
      return Error(UnexpectedErrorError(error.toString()));
    }
  }
}
