import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_budget/core/dependency_injection/locator.dart';
import 'package:my_budget/core/error/error_handling.dart';
import 'package:my_budget/core/router/app_router.dart';
import 'package:my_budget/transaction/domain/models/transaction_model.dart';
import 'package:my_budget/transaction/domain/repositories/transaction_repository.dart';
import 'package:my_budget/user/domain/models/user_model.dart';
import 'package:my_budget/user/domain/repositories/user_repository.dart';
import 'package:stacked_services/stacked_services.dart';

class DashboardViewController extends ChangeNotifier {
  final UserRepository _userRepository;
  final TransactionRepository _transactionRepository;
  final SnackbarService _snackbarService;

  DashboardViewController({
    required UserRepository userRepository,
    required TransactionRepository transactionRepository,
    required SnackbarService snackbarService,
  })  : _userRepository = userRepository,
        _transactionRepository = transactionRepository,
        _snackbarService = snackbarService;

  UserModel? _currentUser;
  List<TransactionModel?> _listTransactions = [];
  bool isLoading = false;

  //Getters
  UserModel? get currentUser => _currentUser;
  List<TransactionModel?> get listTransactions =>
      _transactionRepository.listTransactions;

  Future<void> getCurrentUser() async {
    try {
      _currentUser = await _userRepository.getUser(_userRepository.userId!);
      log(_currentUser.toString());
      notifyListeners();
    } on CustomError catch (err) {
      _snackbarService.showSnackbar(
        message: err.message,
        duration: const Duration(seconds: 3),
      );
      // print(err);
    }
  }

  Future<void> addTransaction() async {
    await _transactionRepository.addTransaction(_currentUser!.id);
  }

  Future<void> getTransactions() async {
    isLoading = true;
    notifyListeners();
    log(_currentUser!.id.toString());
    log('getTransactions');
    await _transactionRepository.getTransactions(_currentUser!.id);
    log('La de abajo es la lista');
    log(listTransactions.toString());
    isLoading = false;
    notifyListeners();
  }

  goToTransactionView() {
    locator<NavigationService>().navigateTo(Router.transactionView);
  }
}

final dashboardViewProvider = ChangeNotifierProvider(
  (ref) => DashboardViewController(
    // navigationService: locator<NavigationService>(),
    // authRepository: locator<AuthRepository>(),
    userRepository: locator<UserRepository>(),
    snackbarService: locator<SnackbarService>(),
    transactionRepository: locator<TransactionRepository>(),
  ),
);
