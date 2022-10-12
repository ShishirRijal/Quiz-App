import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  // making it responsive for tab and phone only
  // it's not designed for desktop
  final Widget mobile;
  final Widget tablet;

  const Responsive({super.key, required this.mobile, required this.tablet});
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width <= 720;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width > 720;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width <= 720) {
      return mobile;
    } else {
      return tablet;
    }
  }
}
