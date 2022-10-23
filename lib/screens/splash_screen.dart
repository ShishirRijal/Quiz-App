import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/services/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // init state
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Routes.wrapperRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: double.infinity),
            Image.asset('assets/images/logo.png'),
            const SizedBox(height: 10.0),
            Text("Quizzey",
                style: getBoldTextStyle(color: Colors.white70, size: 30.0)),
            const SizedBox(height: 30.0),
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.white70,
              ),
              child: FittedBox(
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Made with ❤️ by Shishir Rijal',
                      textAlign: TextAlign.center,
                      speed: const Duration(milliseconds: 70),
                    ),
                  ],
                  onTap: () {
                    // nothing
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
