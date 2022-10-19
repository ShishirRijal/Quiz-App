import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/screens/homescreen/home_screen.dart';
import 'package:quiz_app/screens/login_screen/login_screen.dart';
import 'package:quiz_app/screens/profile_screen/profile_screen.dart';
import 'package:quiz_app/screens/quiz_screen/quiz_screen.dart';
import 'package:quiz_app/services/register_validation.dart';
import 'package:quiz_app/services/services.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginValidation>(
            create: (context) => LoginValidation()),
        ChangeNotifierProvider<RegisterValidation>(
            create: (context) => RegisterValidation()),
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: Builder(builder: (context) {
        final auth = Provider.of<AuthService>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: quizTheme,
          onGenerateRoute: RouteGenerator.getRoute,
          home: const QuizScreen(),
        );
      }),
    );
  }
}
