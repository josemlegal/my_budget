import 'package:flutter/material.dart';
import 'package:my_budget/application/services/shared_preferences_service.dart';
import 'package:my_budget/auth/domain/repositories/auth_repository.dart';
import 'package:my_budget/core/dependency_injection/locator.dart';
import 'package:my_budget/core/mixin/validation_mixin.dart';
import 'package:my_budget/user/domain/repositories/user_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../user/domain/models/user_model.dart';
import 'package:my_budget/core/router/app_router.dart' as router;

class OnboardingViewController extends ChangeNotifier with Validation {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final NavigationService _navigationService;
  final SharedPreferenceApi _sharedPreferences;
  final PageController pageController = PageController();
  final FocusNode nameFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final SnackbarService _snackbarService;

  GlobalKey<FormState> get formKey => _formKey;

  OnboardingViewController({
    AuthRepository? authRepository,
    NavigationService? navigationService,
    SharedPreferenceApi? sharedPreferences,
    UserRepository? userRepository,
    SnackbarService? snackbarService,
  })  : _authRepository = authRepository ?? locator(),
        _sharedPreferences = sharedPreferences ?? locator(),
        _navigationService = navigationService ?? locator(),
        _userRepository = userRepository ?? locator(),
        _snackbarService = snackbarService ?? locator();

  String _name = '';
  String _nameValidationMessage = '';
  bool _isLoading = false;
  List<Map<String, dynamic>> listDiets = [];
  final List<String> _listDietsString = [];
  String? _dropDownValue;

  String get name => _name;
  String get nameValidationMessage => _nameValidationMessage;
  List<Map<String, dynamic>> get diets => listDiets;
  String? get dropDownValue => _dropDownValue;
  List<String> get listDietsString => _listDietsString;
  bool get isLoading => _isLoading;

  void onFormInit() {
    if (!isEmptyOrNull(_sharedPreferences.getUserName())) {
      _name = _sharedPreferences.getUserName()!;
      _nameValidationMessage = validateName(_name);
      notifyListeners();
    }
  }

  void updateName(String value) {
    _name = value;
    _nameValidationMessage = validateName(_name);
    notifyListeners();
  }

  bool validateInfoForm() {
    _nameValidationMessage = validateName(name);

    if (_nameValidationMessage.isEmpty) {
      return true;
    }
    return false;
  }

  Future<void> submitForm() async {
    bool canSubmit = validateInfoForm();

    if (!canSubmit) {
      _snackbarService.showSnackbar(
          message: validateName(_name), duration: const Duration(seconds: 3));
      notifyListeners();
      return;
    }

    final newUserModel = UserModel(
      id: _authRepository.userId!,
      name: name,
      email: _authRepository.userEmail!,
    );

    await _userRepository.createUser(newUserModel);

    await _navigationService.navigateTo(router.Router.tabsView);
  }
}

final onboardingViewProvider = ChangeNotifierProvider<OnboardingViewController>(
  (ref) {
    return OnboardingViewController(
        navigationService: locator<NavigationService>(),
        authRepository: locator<AuthRepository>(),
        sharedPreferences: locator<SharedPreferenceApi>(),
        snackbarService: locator<SnackbarService>());
  },
);
