import 'package:flutter/material.dart';

class TransactionDetailsView extends StatelessWidget {
  const TransactionDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
      ),
      body: const Center(
        child: Text('Transaction Details'),
      ),
    );
  }
}
