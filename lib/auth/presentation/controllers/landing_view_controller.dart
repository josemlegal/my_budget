// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:my_budget/auth/domain/use_cases/sign_in_with_oauth.dart';
import 'package:my_budget/core/dependency_injection/locator.dart';
import 'package:my_budget/core/error/error_handling.dart';
import 'package:my_budget/core/mixin/validation_mixin.dart';
import 'package:my_budget/core/router/app_router.dart' as router;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stacked_services/stacked_services.dart';

enum SocialSignIn {
  GoogleSignIn,
  AppleSignIn,
}

enum SignIn {
  Login,
  Signup,
}

class LandingViewController extends ChangeNotifier with Validation {
  final NavigationService _navigationService;
  final SnackbarService _snackbarService;

  LandingViewController({
    required NavigationService navigationService,
    required SnackbarService snackbarService,
  })  : _navigationService = navigationService,
        _snackbarService = snackbarService;

  //Flags
  bool isLoading = false;

  Future<void> signinWithOAuth(SocialSignIn signInType) async {
    isLoading = true;
    notifyListeners();
    try {
      final userHasRegisteredBefore =
          await signInWithOAuthUseCase.call(signInType: signInType);
      if (!userHasRegisteredBefore) {
        _navigationService.clearStackAndShow(router.Router.onboardingView);
        isLoading = false;
      } else {
        _navigationService.clearStackAndShow(router.Router.tabsView);
        isLoading = false;
      }
      notifyListeners();
    } on CustomError catch (e) {
      isLoading = false;
      _snackbarService.showSnackbar(message: e.message);
    }
  }
}

final landingViewProvider =
    ChangeNotifierProvider<LandingViewController>((ref) {
  return LandingViewController(
    navigationService: locator<NavigationService>(),
    snackbarService: locator<SnackbarService>(),
  );
});
