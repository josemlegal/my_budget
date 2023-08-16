import 'package:my_budget/auth/domain/repositories/auth_repository.dart';
import 'package:my_budget/auth/presentation/controllers/landing_view_controller.dart';
import 'package:my_budget/core/dependency_injection/locator.dart';
import 'package:my_budget/core/error/error_handling.dart';
import 'package:my_budget/user/domain/repositories/user_repository.dart';

class SignInWithOAuthUseCase {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  SignInWithOAuthUseCase(
      {required this.authRepository, required this.userRepository});

  Future<bool> call({required SocialSignIn signInType}) async {
    try {
      if (signInType == SocialSignIn.GoogleSignIn) {
        await authRepository.signInWithGoogle();
      }

      final userExists = await userRepository.getUser(authRepository.userId!);
      if (userExists == null) {
        return false;
      }
      return true;
    } on CustomError catch (e) {
      throw CustomError(
        errorType: e.errorType,
        errorCode: e.errorCode,
        message: e.message,
      );
    }
  }
}

final signInWithOAuthUseCase = SignInWithOAuthUseCase(
  authRepository: locator<AuthRepository>(),
  userRepository: locator<UserRepository>(),
);
