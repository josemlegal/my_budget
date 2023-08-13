import 'package:flutter/material.dart';

class LandingView extends StatelessWidget {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Landing View'),
      ),
      body: const Center(
        child: Text('Landing View'),
      ),
    );
  }
}
