import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/screens/home_screen.dart/home_screen.dart';
import 'package:quiz_app/services/services.dart';

import 'login_screen/login_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: Provider.of<AuthService>(context).getAuthStatus(),
        builder: (context, snapshot) =>
            (snapshot.connectionState == ConnectionState.waiting)
                ? const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : (snapshot.data == true)
                    ? const HomeScreen()
                    : const LoginScreen());
  }
}
