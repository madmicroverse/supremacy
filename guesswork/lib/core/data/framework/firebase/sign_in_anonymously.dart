import 'package:firebase_auth/firebase_auth.dart';
import 'package:guesswork/core/data/extension/firebase_auth_extension.dart';
import 'package:guesswork/core/domain/entity/result.dart';

sealed class SignInAnonymousError extends BaseError {}

class SignInAnonymousNetworkError extends SignInAnonymousError {}

class SignInAnonymousRestrictedError extends SignInAnonymousError {}

class SignInAnonymousUnknownError extends SignInAnonymousError {}

const _networkRequestFailedCode = "network-request-failed";
const _adminRestrictedOperationCode = "admin-restricted-operation";

class SignInAnonymous {
  final FirebaseAuth _firebaseAuth;

  SignInAnonymous(this._firebaseAuth);

  Future<Result<void, SignInAnonymousError>> call() async {
    if (_firebaseAuth.isAuthenticated) return Success(null);

    try {
      await FirebaseAuth.instance.signInAnonymously();
      return Success(null);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case _networkRequestFailedCode:
          return Error(SignInAnonymousNetworkError());
        case _adminRestrictedOperationCode:
          return Error(SignInAnonymousRestrictedError());
        default:
          return Error(SignInAnonymousUnknownError());
      }
    }
  }
}
