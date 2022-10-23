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
  final String score;
  final double scaleFactor;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Icon(
        //   Icons.blur_circular,
        //   color: ColorManager.white,
        //   size: 30.0 * scaleFactor,
        // ),

        FittedBox(
          child: RichText(
            textScaleFactor: scaleFactor,
            text: TextSpan(
              children: [
                TextSpan(
                  text: score.split('/').first,
                  style:
                      getBoldTextStyle(color: ColorManager.white, size: 30.0),
                ),
                TextSpan(
                  text: '/${score.split('/').last}',
                  style: getRegularTextStyle(
                      color: ColorManager.white, size: 18.0),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 5.0),

        FittedBox(
          child: Text(
            title.replaceAll(" ", "\n"),
            textAlign: TextAlign.center,
            textScaleFactor: scaleFactor,
            maxLines: 2,
            style: getRegularTextStyle(color: Colors.white70, size: 17.0),
          ),
        ),
      ],
    );
  }
}
