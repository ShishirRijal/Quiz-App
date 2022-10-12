import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/services/register_validation.dart';
import 'package:quiz_app/services/services.dart';

void main() {
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
      ],
      child: MaterialApp(
        theme: quizTheme,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.loginRoute,
      ),
    );
  }
}
