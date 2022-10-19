import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/services/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              auth.user?.displayName ?? "No Name",
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(height: 20.0),
            // ClipRRect(
            //     borderRadius: BorderRadius.circular(50.0),
            //     child: Image.network(
            //         auth.user?.photoURL ?? 'assets/images/logo.png')),
            Text(
              auth.user?.email ?? "No Email",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 50.0),
            MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  auth.signOut();
                },
                child: Text('Sign Out'))
          ],
        ),
      ),
    );
  }
}

showLoadingDialog(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return SizedBox(
        height: 30.0,
        width: 30.0,
        child: LottieBuilder.asset(
          'assets/images/loading.json',
          fit: BoxFit.contain,
        ),
      );
    },
  );
}
