import 'package:flutter/material.dart';
import 'package:my_budget/core/barells/views.dart';

class Router {
  //Auth views
  static const landingView = '/landing';
  // static const onboardingView = '/onboarding';
  // static const forgotPasswordView = '/forgot-password';

  // static const homeView = '/home';
  // static const profileView = '/profile';
  // static const tabsView = '/tabs';
  // static const subscriptionView = '/subscription-view';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case landingView:
        return MaterialPageRoute(builder: (_) => const LandingView());
      // case homeView:
      //   return MaterialPageRoute(
      //     builder: (_) => const HomeView(),
      //   );
      // case profileView:
      //   return MaterialPageRoute(builder: (_) => const ProfileView());

      // case onboardingView:
      //   return MaterialPageRoute(builder: (_) => const FormView());

      // case tabsView:
      //   return MaterialPageRoute(builder: (_) => const TabsView());

      // case forgotPasswordView:
      //   return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      // case subscriptionView:
      //   return MaterialPageRoute(builder: (_) => const SubscriptionView());
      default:
        return null;
    }
  }
}
