import 'package:flutter/material.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction'),
      ),
      body: const Center(
        child: Text('Transaction'),
      ),
    );
  }
}
