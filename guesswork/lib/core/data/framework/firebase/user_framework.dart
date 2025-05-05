import 'package:firebase_auth/firebase_auth.dart';
import 'package:guesswork/core/domain/entity/account/games_user.dart';
import 'package:guesswork/core/domain/entity/result.dart';

class GetAuthGamesUserOperation {
  final FirebaseAuth _firebaseAuth;

  GetAuthGamesUserOperation(this._firebaseAuth);

  Future<Result<GamesUser, BaseError>> call() async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) return Error(UnauthorizedError());

    final gamesUserInfoList =
        currentUser.providerData
            .map(
              (userInfo) => GamesUserInfo(
                uid: userInfo.uid,
                email: userInfo.email,
                displayName: userInfo.displayName,
                photoURL: userInfo.photoURL,
                phoneNumber: userInfo.phoneNumber,
                providerId: userInfo.providerId,
              ),
            )
            .toList();

    final entangledUser = GamesUser(
      id: currentUser.uid,
      isAnonymous: currentUser.isAnonymous,
      gamesUserInfoList: gamesUserInfoList,
      gamesSettings: GamesSettings(),
      progress: GamesUserProgress(),
    );

    return Success(entangledUser);
  }
}
