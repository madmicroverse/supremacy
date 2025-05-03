import 'package:firebase_auth/firebase_auth.dart';

extension FirebaseAuthUtils on FirebaseAuth {
  bool get isAuthenticated => currentUser != null;
}
