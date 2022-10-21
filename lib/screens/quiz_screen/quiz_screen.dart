import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/screens/result_screen.dart/result_screen.dart';
import 'package:quiz_app/services/resources/style_manger.dart';
import 'package:quiz_app/widgets/animated_timer.dart';

import '../../services/quiz.dart';
import '../../services/resources/routes_manager.dart';
import 'components/answer_card.dart';
import 'components/question_card.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 480;
    final double scaleFactor = isMobile ? 1.0 : 1.5;
    final padding = isMobile ? 20.0 : 40.0;
    final smallDevicePadding = size.height < 720 ? 120.0 : 180.0;
    final quiz = Provider.of<Quiz>(context);

    // Once the quiz time is complete, go to the result screen
    Future.delayed(Duration(seconds: quiz.quizDuration), () {
      Navigator.pushReplacementNamed(context, Routes.resultRoute);
    });

    return quiz.isCompleted
        ? const ResultScreen()
        : Scaffold(
            body: SingleChildScrollView(
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        alignment: Alignment.topCenter,
                        height: isMobile ? 250 : 350,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: ColorManager.primary,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                        ),
                        child: FittedBox(
                          child: Text(
                            "QUIZ",
                            style: getBoldTextStyle(
                              color: Colors.white38,
                              size: 200.0,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            padding, smallDevicePadding, padding, padding),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AnswerCard(0, deviceWidth: size.width),
                            SizedBox(height: isMobile ? 15.0 : 20.0),
                            AnswerCard(1, deviceWidth: size.width),
                            SizedBox(height: isMobile ? 15.0 : 20.0),
                            AnswerCard(2, deviceWidth: size.width),
                            SizedBox(height: isMobile ? 15.0 : 20.0),
                            AnswerCard(3, deviceWidth: size.width),
                            SizedBox(height: isMobile ? 15.0 : 20.0),

                            //
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 150,
                    child: QuestionCard(size: size),
                  ),
                  Positioned(
                      top: 100.0,
                      child: AnimatedTimer(
                        scaleFactor: scaleFactor,
                        time: quiz.quizDuration,
                      )),
                ],
              ),
            ),
          );
  }
}
