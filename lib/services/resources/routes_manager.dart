import 'package:flutter/material.dart';
import 'package:quiz_app/screens/result_screen.dart/result_screen.dart';
import 'package:quiz_app/screens/screens.dart';

class Routes {
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPasswordRoute = '/forgot-password';
  static const String profileRoute = '/profile';
  static const String quizRoute = '/quiz';
  static const String resultRoute = '/result';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(
            builder: (context) => const ForgotPasswordScreen());
      case Routes.profileRoute:
        return MaterialPageRoute(builder: (context) => const ProfileScreen());
      case Routes.quizRoute:
        return MaterialPageRoute(builder: (context) => const QuizScreen());
      case Routes.resultRoute:
        return MaterialPageRoute(builder: (context) => const ResultScreen());
      default:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
    }
  }
}
