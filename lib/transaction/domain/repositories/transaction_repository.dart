import 'package:my_budget/transaction/domain/models/transaction_model.dart';

abstract class TransactionRepository {
  Future<void> addTransaction(String userId);
  Future<List<TransactionModel?>> getTransactions(String userId);

  List<TransactionModel?> get listTransactions;
}
