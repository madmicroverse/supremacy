import 'package:firebase_auth/firebase_auth.dart';
import 'package:guesswork/core/data/extension/firebase_auth_extension.dart';
import 'package:guesswork/core/data/framework/firebase/sign_in_with_google.dart';
import 'package:guesswork/core/domain/entity/result.dart';

class AnonymousAuthenticationDisabledError extends BaseError {}

const networkRequestFailedCode = "network-request-failed";
const adminRestrictedOperationCode = "admin-restricted-operation";

class SignInAnonymous {
  final FirebaseAuth _firebaseAuth;

  SignInAnonymous(this._firebaseAuth);

  Future<Result<bool, BaseError>> call() async {
    if (_firebaseAuth.isAuthenticated)
      return Error(AlreadyAuthenticatedError());

    try {
      await FirebaseAuth.instance.signInAnonymously();
      return Success(true);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case networkRequestFailedCode:
          return Error(NetworkRequestFailedError());
        case adminRestrictedOperationCode:
          return Error(AnonymousAuthenticationDisabledError());
        default:
          return Error(UnknownError());
      }
    }
  }
}
