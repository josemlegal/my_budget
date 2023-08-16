import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_budget/core/dependency_injection/locator.dart';
import 'package:my_budget/core/error/error_handling.dart';
import 'package:my_budget/user/domain/models/user_model.dart';
import 'package:my_budget/user/domain/repositories/user_repository.dart';
import 'package:stacked_services/stacked_services.dart';

class DashboardViewController extends ChangeNotifier {
  final UserRepository _userRepository;
  // final NavigationService _navigationService;
  final SnackbarService _snackbarService;

  User? _currentUser;

  DashboardViewController({
    // required NavigationService navigationService,
    // required AuthRepository authRepository,
    required UserRepository userRepository,
    required SnackbarService snackbarService,
  })  : _userRepository = userRepository,
        // _navigationService = navigationService,
        _snackbarService = snackbarService;

  User? get currentUser => _currentUser;
  Future<void> getCurrentUser() async {
    try {
      _currentUser = await _userRepository.getUser(_userRepository.userId!);
      notifyListeners();
    } on CustomError catch (err) {
      _snackbarService.showSnackbar(
        message: err.message,
        duration: const Duration(seconds: 3),
      );
      // print(err);
    }
  }
}

final dashboardViewProvider = ChangeNotifierProvider(
  (ref) => DashboardViewController(
    // navigationService: locator<NavigationService>(),
    // authRepository: locator<AuthRepository>(),
    userRepository: locator<UserRepository>(),
    snackbarService: locator<SnackbarService>(),
  ),
);
