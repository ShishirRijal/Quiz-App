import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/services/quiz_controller.dart';
import 'package:quiz_app/services/services.dart';

import '../../models/report.dart';
import '../../services/db_services.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quiz = Provider.of<QuizController>(context);
    final size = MediaQuery.of(context).size;
    final containerHeight = size.height * 0.5;
    // let's update the score in the database
    DatabaseService()
        .updateUserReport(quiz.topic, quiz.correctAnswers, quiz.noOfQuestions);

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.loose,
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Container(
                  height: containerHeight,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Stack(
                    // for those ripple effects
                    alignment: Alignment.center,
                    children: [
                      Ripple(size.width * 0.6, Colors.white24),
                      Ripple(size.width * 0.5, Colors.white54),
                      Ripple(size.width * 0.4, Colors.white70),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Your score",
                              style: getMediumTextStyle(
                                  color: ColorManager.primary, size: 20.0)),
                          Text("${quiz.correctAnswers}",
                              style: getBoldTextStyle(
                                  color: ColorManager.primary, size: 50.0)),
                        ],
                      ),
                    ],
                  )),
              Container(
                width: size.width * 0.9,
                padding: EdgeInsets.only(top: size.height * 0.2),
                child: ElevatedButton(
                  onPressed: () {
                    quiz.reset(); // reset all the values for next quiz
                    Navigator.pushReplacementNamed(context, Routes.topicRoute);
                  },
                  child: const Text("Continue..."),
                ),
              ),
            ],
          ),
          Positioned(
            top: containerHeight - 90, // 90 = 180/2
            child: ResultStatsCard(size: size, quiz: quiz),
          ),
        ],
      ),
    );
  }
}

class ResultStatsCard extends StatelessWidget {
  const ResultStatsCard({
    Key? key,
    required this.size,
    required this.quiz,
  }) : super(key: key);

  final Size size;
  final QuizController quiz;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
      height: 180.0,
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ResultItem(quiz.result[0]),
              ResultItem(quiz.result[1]),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ResultItem(quiz.result[2]),
              ResultItem(quiz.result[3]),
            ],
          ),
        ],
      ),
    );
  }
}

class ResultItem extends StatelessWidget {
  const ResultItem(
    this.result, {
    Key? key,
  }) : super(key: key);
  final Result result;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 12.0),
          height: 10.0,
          width: 10.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: result.color,
          ),
        ),
        const SizedBox(width: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
                child: Text('${result.value}${result.trailingSymbol ?? ''}',
                    style: getBoldTextStyle(color: result.color))),
            FittedBox(
              child: Text(result.title,
                  style: getMediumTextStyle(
                      color: ColorManager.darkGrey, size: 14.0)),
            ),
          ],
        ),
      ],
    );
  }
}

//
//
//

class Ripple extends StatelessWidget {
  const Ripple(
    this.radius,
    this.color, {
    Key? key,
  }) : super(key: key);
  final Color color;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
      width: radius,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
