import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class AuthRepository {
  //Getters
  auth.User? get currentUser;
  String? get userEmail;
  String? get userId;

  Future<void> signInWithGoogle();
  Future<void> logout();
}
