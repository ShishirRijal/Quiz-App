import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/services/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    final user = auth.user;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              user?.displayName ?? "Default Name",
              style: getMediumTextStyle(),
            ),
            const SizedBox(height: 20.0),
            Text(
              user?.email ?? "Default Email",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 50.0),
            MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () async {
                  await auth.signOut();
                },
                child: Text('Sign Out'))
          ],
        ),
      ),
    );
  }
}
