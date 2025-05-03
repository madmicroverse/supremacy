import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:guesswork/firebase_options.dart';
import 'package:injectable/injectable.dart';

const emulated = bool.fromEnvironment('emulated', defaultValue: false);

@module
abstract class FirebaseModule {
  @preResolve
  @Singleton()
  Future<FirebaseApp> firebaseAppFactory() {
    return Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @preResolve
  @Singleton()
  Future<FirebaseAuth> firebaseAuthFactory() async {
    final firebaseAuth = FirebaseAuth.instance;
    if (emulated) {
      firebaseAuth.useAuthEmulator('localhost', 9099);
    }
    return firebaseAuth;
  }

  @preResolve
  @Singleton()
  Future<FirebaseFirestore> firebaseFirestoreFactory() async {
    final firebaseFirestore = FirebaseFirestore.instance;
    return firebaseFirestore;
  }
}
