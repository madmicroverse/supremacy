import 'package:firebase_auth/firebase_auth.dart';
import 'package:guesswork/core/data/extension/firebase_auth_extension.dart';
import 'package:guesswork/core/domain/entity/result.dart';

sealed class AuthStatus {}

class Authenticated extends AuthStatus {}

class Unauthenticated extends AuthStatus {}

class SignedStatus {
  final FirebaseAuth _firebaseAuth;

  SignedStatus(this._firebaseAuth);

  Result<AuthStatus, BaseError> call() =>
      _firebaseAuth.isAuthenticated
          ? Success(Authenticated())
          : Success(Unauthenticated());
}
