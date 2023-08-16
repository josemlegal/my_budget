abstract class AuthDataSource {
  Future<void> signInWithGoogle();
  Future<void> logout();
}
