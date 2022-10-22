import 'package:flutter/material.dart';

import '../../../services/services.dart';

class Stats extends StatelessWidget {
  const Stats(
    this.title,
    this.score,
    this.scaleFactor, {
    Key? key,
  }) : super(key: key);
  final String title;
  final int score;
  final double scaleFactor;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.blur_circular,
          color: ColorManager.white,
          size: 30.0 * scaleFactor,
        ),
        FittedBox(
          child: Text(
            title,
            textScaleFactor: scaleFactor,
            maxLines: 1,
            style: getRegularTextStyle(color: Colors.white70),
          ),
        ),
        const SizedBox(height: 5.0),
        FittedBox(
          child: Text(
            "$score",
            textScaleFactor: scaleFactor,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: getBoldTextStyle(color: ColorManager.white),
          ),
        ),
      ],
    );
  }
}
