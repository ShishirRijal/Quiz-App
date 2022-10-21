import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/screens/result_screen.dart/result_screen.dart';
import 'package:quiz_app/screens/screens.dart';
import 'package:quiz_app/services/quiz.dart';
import 'package:quiz_app/services/register_validation.dart';
import 'package:quiz_app/services/services.dart';

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
          create: (context) => LoginValidation(),
        ),
        ChangeNotifierProvider<RegisterValidation>(
          create: (context) => RegisterValidation(),
        ),
        ChangeNotifierProvider<AuthService>(
          create: (context) => AuthService(),
        ),
        ChangeNotifierProvider<Quiz>(
          create: (context) => Quiz(),
        ),
      ],
      child: Builder(builder: (context) {
        final auth = Provider.of<AuthService>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: quizTheme,
          onGenerateRoute: RouteGenerator.getRoute,
          home: FutureBuilder<bool>(
              future: auth.getAuthStatus(),
              builder: (context, snapshot) =>
                  (snapshot.connectionState == ConnectionState.waiting)
                      ? const Scaffold(
                          body: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : (snapshot.data == true)
                          ? const QuizScreen()
                          : const LoginScreen()),
        );
      }),
    );
  }
}
