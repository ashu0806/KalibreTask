import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum LoadingStatus {
  loading,
  completed,
  error,
}

mixin Config {
  static const userModel = "userModel";
}

final firebaseAuth = FirebaseAuth.instance;
final firebaseFirestore = FirebaseFirestore.instance;
final googleSignInInstance = GoogleSignIn();
