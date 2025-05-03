import 'package:firebase_auth/firebase_auth.dart';

class SignOut {
  final FirebaseAuth _firebaseAuth;

  SignOut(this._firebaseAuth);

  Future<void> call() async => _firebaseAuth.signOut();
}
