import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_budget/application/services/shared_preferences_service.dart';
import 'package:my_budget/core/dependency_injection/locator.dart';
import 'package:my_budget/core/theme/app_theme.dart';
import 'package:my_budget/firebase_options.dart';
import 'package:my_budget/core/router/app_router.dart' as router;
import 'package:stacked_services/stacked_services.dart' as services;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  final sharedPreferences = locator<SharedPreferenceApi>();
  await sharedPreferences.init();
  runApp(
    const ProviderScope(child: MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  bool get isUserLoggedIn => FirebaseAuth.instance.currentUser != null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute:
          isUserLoggedIn ? router.Router.tabsView : router.Router.landingView,
      onGenerateRoute: router.Router.generateRoute,
      navigatorKey: services.StackedService.navigatorKey,
    );
  }
}
