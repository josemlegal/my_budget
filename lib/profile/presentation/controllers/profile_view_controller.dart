import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_budget/auth/domain/repositories/auth_repository.dart';
import 'package:my_budget/core/dependency_injection/locator.dart';
import 'package:my_budget/core/error/error_handling.dart';
import 'package:my_budget/user/domain/models/user_model.dart';
import 'package:my_budget/user/domain/repositories/user_repository.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileViewController extends ChangeNotifier {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;
  final NavigationService _navigationService;
  final SnackbarService _snackbarService;

  // States
  User? _currentUser;

  ProfileViewController({
    required NavigationService navigationService,
    required AuthRepository authRepository,
    required UserRepository userRepository,
    required SnackbarService snackbarService,
  })  : _navigationService = navigationService,
        _userRepository = userRepository,
        _authRepository = authRepository,
        _snackbarService = snackbarService;

  //Flags
  bool _isLoading = true;

  //Getters
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  Future<void> onInit() async {
    _isLoading = true;
    notifyListeners();
    await getCurrentUser();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getCurrentUser() async {
    try {
      _currentUser = await _userRepository.getUser(_userRepository.userId!);
      notifyListeners();
    } on CustomError catch (err) {
      _snackbarService.showSnackbar(
        message: err.message,
        duration: const Duration(seconds: 3),
      );
    }
  }

  void onLogOut() async {
    await _authRepository.logout();
    _navigationService.clearStackAndShow('/landing');
  }
}

final profileViewProvider = ChangeNotifierProvider(
  (ref) => ProfileViewController(
    navigationService: locator<NavigationService>(),
    authRepository: locator<AuthRepository>(),
    userRepository: locator<UserRepository>(),
    snackbarService: locator<SnackbarService>(),
  ),
);
