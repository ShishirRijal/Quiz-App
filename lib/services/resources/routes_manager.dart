import 'package:flutter/material.dart';
import 'package:quiz_app/screens/home_screen.dart/home_screen.dart';
import 'package:quiz_app/screens/result_screen.dart/result_screen.dart';
import 'package:quiz_app/screens/screens.dart';
import 'package:quiz_app/screens/splash_screen.dart';
import 'package:quiz_app/screens/wrapper.dart';

class Routes {
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPasswordRoute = '/forgot-password';
  static const String profileRoute = '/profile';
  static const String quizRoute = '/quiz';
  static const String resultRoute = '/result';
  static const String quizDetailRoute = '/quiz-detail';
  static const String topicRoute = '/topics';
  static const String splashRoute = '/splash-screen';
  static const String wrapperRoute = '/wrapper';
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
        return MaterialPageRoute(
            builder: (context) =>
                HomeScreen(selectedPageIndex: TabScreens.profileScreen.index));
      case Routes.topicRoute:
        return MaterialPageRoute(
            builder: (context) =>
                HomeScreen(selectedPageIndex: TabScreens.topicScreen.index));
      // case Routes.quizRoute:
      //   return MaterialPageRoute(builder: (context) => const Quiz());
      case Routes.resultRoute:
        return MaterialPageRoute(builder: (context) => const ResultScreen());
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case Routes.wrapperRoute:
        return MaterialPageRoute(builder: (context) => const Wrapper());

      default:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
    }
  }
}
