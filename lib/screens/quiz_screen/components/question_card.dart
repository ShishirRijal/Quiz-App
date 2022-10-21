import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/quiz.dart';
import '../../../services/services.dart';
import 'labelled_chip.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    final quiz = Provider.of<Quiz>(context);
    final bool isMobile = size.width < 480;
    final double scaleFactor = isMobile ? 1.0 : 1.5;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      height: isMobile ? 200 : 300,
      width: size.width * 0.9,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LabelledChip(
                  isWrong: false,
                  score: quiz.correctAnswers,
                  scaleFactor: scaleFactor),
              LabelledChip(
                  isWrong: true,
                  score: quiz.wrongAnswers,
                  scaleFactor: scaleFactor),
            ],
          ),
          const SizedBox(height: 5.0),
          Flexible(
            child: RichText(
                textAlign: TextAlign.center,
                textScaleFactor: scaleFactor,
                text: TextSpan(children: [
                  TextSpan(
                      text: "Question ",
                      style: getMediumTextStyle(color: ColorManager.primary)),
                  TextSpan(
                      text: '${quiz.currentIndex + 1}',
                      style: getBoldTextStyle(color: ColorManager.primary)),
                  TextSpan(
                      text: '/${quiz.questions.length}',
                      style: getMediumTextStyle(color: ColorManager.primary)),
                ])),
          ),
          const SizedBox(height: 20.0),
          Align(
            child: Text(quiz.currentQuestion,
                textAlign: TextAlign.center,
                textScaleFactor: scaleFactor,
                style: getMediumTextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorManager.darkGrey,
                )),
          )
        ],
      ),
    );
  }
}
