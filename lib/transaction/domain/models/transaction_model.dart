import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String userId;

  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.userId,
  });

  factory TransactionModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return TransactionModel(
      id: document.id,
      title: data?["title"],
      amount: data?["amount"],
      date: data?["date"].toDate(),
      userId: data?["userId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "amount": amount,
        "date": date,
      };

  TransactionModel copyWith({
    String? id,
    String? title,
    double? amount,
    DateTime? date,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      userId: userId,
    );
  }

  @override
  String toString() {
    return 'Transaction(id: $id, title: $title, amount: $amount, date: $date, userId: $userId)';
  }
}
