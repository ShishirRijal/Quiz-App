import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/screens/result_screen.dart/result_screen.dart';
import 'package:quiz_app/screens/screens.dart';
import 'package:quiz_app/services/db_services.dart';
import 'package:quiz_app/services/resources/style_manger.dart';
import 'package:quiz_app/widgets/animated_timer.dart';

import '../../services/quiz.dart';
import 'components/answer_card.dart';
import 'components/question_card.dart';

class Quiz extends StatelessWidget {
  const Quiz({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = Provider.of<QuizController>(context);
    // Once the quiz time is complete, go to the result screen

    return FutureBuilder(
        future: DatabaseService().getQuestion(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            quiz.setQuestions(snapshot.data!);

            // return Text(snapshot.data!.length.toString());
            return const QuizScreen();
          } else {
            return const LoadingScreen();
////////
          }
        });
  }
}

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

class QuizScreen extends StatelessWidget {
  const QuizScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 480;
    final double scaleFactor = isMobile ? 1.0 : 1.5;
    final padding = isMobile ? 20.0 : 40.0;
    final smallDevicePadding = size.height < 720 ? 120.0 : 180.0;
    final quiz = Provider.of<QuizController>(context);

    Future.delayed(Duration(seconds: quiz.quizDuration)).then((value) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const ResultScreen()));
    });
    return Scaffold(
      body: quiz.isCompleted
          ? const ResultScreen()
          : SingleChildScrollView(
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
