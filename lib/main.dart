import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_budget/firebase_options.dart';
import 'package:my_budget/core/router/app_router.dart' as router;

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: router.Router.landingView,
      onGenerateRoute: router.Router.generateRoute,
    );
  }
}
