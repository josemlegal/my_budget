import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_budget/auth/domain/repositories/auth_repository.dart';
import 'package:my_budget/core/error/error_handling.dart';
import 'package:my_budget/transaction/domain/models/transaction_model.dart';
import 'package:my_budget/transaction/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImplementation implements TransactionRepository {
  final FirebaseFirestore _firestore;
  final AuthRepository _authRepository;

  TransactionRepositoryImplementation({
    required FirebaseFirestore firestore,
    required AuthRepository authRepository,
  })  : _firestore = firestore,
        _authRepository = authRepository;

  String? get userId => _authRepository.userId;
  List<TransactionModel?> _listTransactions = [];

  @override
  List<TransactionModel?> get listTransactions => _listTransactions;

  @override
  Future<void> addTransaction(String userId) async {
    await _call(() async {
      await _firestore.collection('transactions').doc().set({
        'title': 'title',
        'amount': 0.0,
        'date': DateTime.now(),
        'userId': userId,
      });
    });
  }

  @override
  Future<List<TransactionModel?>> getTransactions(String userId) {
    return _call(() async {
      final response = await _firestore
          .collection('transactions')
          .where('userId', isEqualTo: userId)
          .get();

      _listTransactions = response.docs
          .map((doc) => TransactionModel.fromFirestore(doc))
          .toList();
      log(_listTransactions.toString());
      return _listTransactions;
    });
  }
}

Future<T> _call<T>(Future<T> Function() function) async {
  try {
    return await function();
  } catch (e, stack) {
    if (e is FirebaseException) {
      throw CustomErrorHandler.fromFirebaseException(e,
          stack: stack, devMessage: 'Transaction Repository');
    }

    throw CustomErrorHandler.fromGenericError(
        stack: stack,
        devMessage: "Transaction Repository",
        errorCode: 'Transaction-repo-error-code',
        errorType: 'Transaction-repo-error-type');
  }
}
