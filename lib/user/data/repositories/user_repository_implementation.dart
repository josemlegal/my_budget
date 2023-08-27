import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_budget/auth/domain/repositories/auth_repository.dart';
import 'package:my_budget/core/error/error_handling.dart';
import 'package:my_budget/user/domain/models/user_model.dart';
import 'package:my_budget/user/domain/repositories/user_repository.dart';

class UserRepositoryImplementation implements UserRepository {
  final AuthRepository _authRepository;
  final FirebaseFirestore _firestore;

  UserRepositoryImplementation({
    required AuthRepository authRepository,
    required FirebaseFirestore firestore,
  })  : _firestore = firestore,
        _authRepository = authRepository;

  UserModel? _currentUser;

  @override
  String? get userId => _authRepository.userId;

  @override
  UserModel? get currentUser => _currentUser;

  @override
  Future<UserModel?> getUser(String id) {
    return _call(() async {
      final response = await _firestore.collection('users').doc(id).get();
      if (response.data() == null) {
        return null;
      }
      _currentUser = UserModel.fromFirestore(response);
      return _currentUser!;
    });
  }

  @override
  Future<void> createUser(UserModel user) {
    return _call(() async {
      await _firestore
          .collection('users')
          .doc(_authRepository.userId)
          .set(user.toJson());
    });
  }
}

Future<T> _call<T>(Future<T> Function() function) async {
  try {
    return await function();
  } catch (e, stack) {
    if (e is FirebaseException) {
      throw CustomErrorHandler.fromFirebaseException(e,
          stack: stack, devMessage: 'User Repository');
    }

    throw CustomErrorHandler.fromGenericError(
        stack: stack,
        devMessage: "UserRepo",
        errorCode: 'user repo error code',
        errorType: 'user-repo-error-type');
  }
}
