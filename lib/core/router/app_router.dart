import 'package:flutter/material.dart';
import 'package:my_budget/core/barells/views.dart';

class Router {
  //Auth views
  static const landingView = '/landing';
  static const dashboardView = '/dashboard';
  static const profileView = '/profile';
  static const tabsView = '/tabs';
  static const onboardingView = '/onboarding';
  static const transactionView = '/transaction';
  // static const forgotPasswordView = '/forgot-password';
  // static const subscriptionView = '/subscription-view';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case landingView:
        return MaterialPageRoute(builder: (_) => const LandingView());
      case dashboardView:
        return MaterialPageRoute(builder: (_) => const DashboardView());
      case profileView:
        return MaterialPageRoute(builder: (_) => const ProfileView());
      case tabsView:
        return MaterialPageRoute(builder: (_) => const TabsView());
      case onboardingView:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case transactionView:
        return MaterialPageRoute(builder: (_) => const TransactionView());
      // case forgotPasswordView:
      //   return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      // case subscriptionView:
      //   return MaterialPageRoute(builder: (_) => const SubscriptionView());
      default:
        return null;
    }
  }
}
