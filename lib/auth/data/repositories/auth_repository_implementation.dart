import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_budget/auth/data/data_sources/auth_data_source.dart';
import 'package:my_budget/auth/domain/repositories/auth_repository.dart';
import 'package:my_budget/core/dependency_injection/locator.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final FirebaseAuth _auth;
  final AuthDataSource _dataSource;

  AuthRepositoryImplementation({
    FirebaseAuth? auth,
    AuthDataSource? dataSource,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _dataSource = dataSource ?? locator<AuthDataSource>();

  @override
  User? get currentUser => _auth.currentUser;

  @override
  String? get userEmail => _auth.currentUser?.email;

  @override
  String? get userId => _auth.currentUser?.uid;

  @override
  Future<void> signInWithGoogle() async =>
      await _call(() => _dataSource.signInWithGoogle());

  @override
  Future<void> logout() async => await _call(() => _dataSource.logout());
}

Future<T> _call<T>(Future<T> Function() function) async {
  try {
    return await function();
  } catch (e) {
    rethrow;
  }
}
