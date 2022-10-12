import 'package:flutter/material.dart';

import '../services/style_manger.dart';

class ImageButton extends StatelessWidget {
  const ImageButton({
    Key? key,
    required this.imagePath,
    this.onPressed,
  }) : super(key: key);
  final String imagePath;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        splashColor: ColorManager.primary.withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          child: Image.asset(
            imagePath,
            height: 40.0,
          ),
        ),
      ),
    );
  }
}
