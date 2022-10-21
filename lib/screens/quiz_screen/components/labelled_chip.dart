import 'package:flutter/material.dart';

import '../../../services/services.dart';

class LabelledChip extends StatelessWidget {
  const LabelledChip({
    Key? key,
    required this.isWrong,
    required this.score,
    required this.scaleFactor,
  }) : super(key: key);
  final bool isWrong;
  final int score;
  final double scaleFactor;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (!isWrong)
          FittedBox(
            child: Text(
              score < 10 ? '0$score' : '$score',
              style: getMediumTextStyle(color: Colors.green),
              textScaleFactor: scaleFactor,
            ),
          ),
        FittedBox(
          child: Container(
            height: 15.0 * scaleFactor,
            width: 40.0 * scaleFactor,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: isWrong ? Colors.red : Colors.green,
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
        if (isWrong)
          Text(
            score < 10 ? '0$score' : '$score',
            style: getMediumTextStyle(
              color: Colors.red,
            ),
            textScaleFactor: scaleFactor,
          ),
      ],
    );
  }
}
