import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guesswork/core/data/extension/firebase_auth_extension.dart';
import 'package:guesswork/core/domain/entity/result.dart';

class AlreadyAuthenticatedError extends BaseError {}

class GoogleAuthenticationError extends BaseError {}

class SignInWithGoogle {
  final FirebaseAuth _firebaseAuth;

  SignInWithGoogle(this._firebaseAuth);

  Future<Result<bool, BaseError>> call() async {
    if (_firebaseAuth.isAuthenticated)
      return Error(AlreadyAuthenticatedError());

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(
          clientId:
              "39715899698-1ghl17fdelqvt9ce6prv0i7dnuav83vk.apps.googleusercontent.com",
        ).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    if (googleAuth == null) return Error(GoogleAuthenticationError());

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      // Once signed in, return the UserCredential
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
    } catch (exception) {
      return Error(GoogleAuthenticationError());
    }

    return Success(true);
  }
}
