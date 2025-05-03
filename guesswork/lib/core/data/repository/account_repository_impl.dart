import 'package:guesswork/core/data/framework/firebase/firestore_framework.dart';
import 'package:guesswork/core/data/framework/firebase/user_framework.dart';
import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/domain/entity/account/games_user_progress.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/settings/games_settings.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';

class AccountRepositoryImpl extends AccountRepository {
  final UserFramework _userFramework;
  final FirestoreFramework _firestoreFramework;

  AccountRepositoryImpl(this._userFramework, this._firestoreFramework);

  @override
  Future<Result<GamesUser, BaseError>> getGamesUser() => _userFramework();

  @override
  Future<Result<GamesUserProgress, BaseError>> getGameUserInfo() =>
      _firestoreFramework.getGamesUserInfo();

  @override
  Future<Result<Stream<GamesSettings>, BaseError>> getGamesSettings(
    String userId,
  ) => _firestoreFramework.getSettings(userId);

  @override
  Future<Result<bool, BaseError>> setGamesSettings(
    GamesSettings gamesSettings,
  ) => _firestoreFramework.setSettings(gamesSettings);
}
