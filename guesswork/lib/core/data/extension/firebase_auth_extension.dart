import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guesswork/core/data/extension/serialised.dart';

extension FirebaseAuthUtils on FirebaseAuth {
  bool get isAuthenticated => currentUser != null;
}

extension DocumentSnapshotUtils on DocumentSnapshot<Map<String, dynamic>> {
  Map<String, dynamic>? dataWithId() => data()?.withId(id);
}
