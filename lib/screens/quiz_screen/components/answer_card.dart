import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/quiz.dart';
import '../../../services/services.dart';

class AnswerCard extends StatelessWidget {
  const AnswerCard(
    this.index, {
    Key? key,
    required this.deviceWidth,
  }) : super(key: key);
  final int index;
  final double deviceWidth;
  @override
  Widget build(BuildContext context) {
    final quiz = Provider.of<Quiz>(context);
    final bool isCorrect = quiz.isCorrect(index);
    final bool isMobile = deviceWidth < 480;
    final double scaleFactor = isMobile ? 1.0 : 1.5;
    final isTapped = quiz.getTapValue(index);
    return InkWell(
      splashColor: ColorManager.primary,
      onTap: quiz.isAnswered
          ? null
          : () {
              quiz.checkAnswer(index);
            },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        width: double.infinity,
        height: isMobile ? 60.0 : 75.0,
        decoration: BoxDecoration(
          color: !isTapped
              ? Colors.white
              : (isCorrect
                  ? ColorManager.correct.withOpacity(0.3)
                  : ColorManager.error.withOpacity(0.3)),
          border: Border.all(
            color: !isTapped
                ? const Color.fromARGB(255, 205, 204, 204)
                : (isCorrect ? ColorManager.correct : ColorManager.error),
            width: 2.0 * scaleFactor,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FittedBox(
              child: Text(quiz.getOption(index),
                  textScaleFactor: scaleFactor,
                  style: getMediumTextStyle(color: ColorManager.darkGrey)),
            ),
            Flexible(
              child: Container(
                height: isMobile ? 25 : 35,
                width: isMobile ? 25 : 35,
                decoration: BoxDecoration(
                  color: !isTapped
                      ? Colors.transparent
                      : (isCorrect ? ColorManager.correct : ColorManager.error),
                  borderRadius: BorderRadius.circular(15.0),
                  border: isTapped
                      ? null
                      : Border.all(
                          color: const Color.fromARGB(255, 205, 204, 204),
                          width: 2.0 * scaleFactor,
                        ),
                ),
                child: !isTapped
                    ? null
                    : FittedBox(
                        child: Icon(
                          isCorrect ? Icons.check : Icons.close,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
