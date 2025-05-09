import 'package:guesswork/core/data/framework/firebase/signed_status.dart';

import '../entity/result.dart';

sealed class SignInWithGoogleError extends BaseError {}

sealed class SignInAnonymouslyError extends BaseError {}

class SignInAnonymouslyDataAccessError extends SignInAnonymouslyError {}

class SignInAnonymouslyUnknownError extends SignInAnonymouslyError {}

abstract class AuthRepository {
  Future<Result<void, BaseError>> signInWithGoogle();

  Future<Result<void, SignInAnonymouslyError>> signInAnonymously();

  Future<void> signOut();

  Result<AuthStatus, BaseError> getAuthStatus();
}
