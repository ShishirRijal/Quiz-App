import 'package:flutter/material.dart';

import '../services/resources/style_manger.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key? key,
    this.title,
  }) : super(key: key);
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.primary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                color: ColorManager.white,
                strokeWidth: 3.0,
              ),
              const SizedBox(height: 20.0),
              Text(title ?? "Loading Questions...",
                  style: getBoldTextStyle(size: 20.0, color: Colors.white)),
            ],
          ),
        ));
  }
}
