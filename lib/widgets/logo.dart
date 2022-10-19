import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../services/services.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 120.0,
        child: LottieBuilder.asset(
          AssetManager.logoJson,
          fit: BoxFit.cover,
        ));
  }
}
