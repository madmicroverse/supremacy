import 'package:guesswork/core/data/framework/firebase/signed_status.dart';

import '../entity/result.dart';

abstract class AuthRepository {
  Future<Result<bool, BaseError>> signInWithGoogle();

  Future<Result<bool, BaseError>> signInAnonymously();

  Future<void> signOut();

  Result<AuthStatus, BaseError> getAuthStatus();
}
