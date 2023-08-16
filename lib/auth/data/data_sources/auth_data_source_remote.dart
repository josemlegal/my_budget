import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_budget/auth/data/data_sources/auth_data_source.dart';
import 'package:my_budget/core/error/error_handling.dart';

class AuthDataSourceRemote implements AuthDataSource {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  final OAuthProvider _googleAuthProvider;

  AuthDataSourceRemote({
    FirebaseAuth? auth,
    GoogleSignIn? googleSignIn,
    OAuthProvider? googleAuthProvider,
    OAuthProvider? appleAuthProvider,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _googleAuthProvider = googleAuthProvider ?? OAuthProvider('google.com');

  @override
  Future<void> signInWithGoogle() async {
    final googleAccount = await _googleSignIn.signIn();
    if (googleAccount == null) {
      throw const CustomError(
          errorCode: 'ERROR_ABORTED_BY_USER',
          message: 'Cancelaste el registro con Google',
          errorType: 'google_auth');
    }
    final googleAuth = await googleAccount.authentication;
    if (googleAuth.accessToken == null || googleAuth.idToken == null) {
      throw const CustomError(
          errorCode: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Error al ingresar con Google',
          errorType: 'google_auth');
    }

    final oAuthCredential = _googleAuthProvider.credential(
      idToken: googleAuth.idToken!,
      accessToken: googleAuth.accessToken!,
    );
    await _call(() => _auth.signInWithCredential(oAuthCredential));
  }

  @override
  Future<void> logout() async {
    return await _call(() async {
      await _googleSignIn.signOut();
      await _auth.signOut();
    });
  }

  Future<T> _call<T>(Future<T> Function() function) async {
    try {
      return await function();
    } catch (e, stack) {
      if (e is FirebaseAuthException) {
        throw CustomErrorHandler.fromFirebaseException(
          e,
          stack: stack,
          devMessage: 'Auth Repository',
        );
      }
      if (e is CustomError) {
        rethrow;
      }
      throw CustomErrorHandler.fromGenericError(
        stack: stack,
        errorCode: 'auth-error-code',
        errorType: 'auth-error',
        devMessage: 'AuthRepo',
      );
    }
  }
}
