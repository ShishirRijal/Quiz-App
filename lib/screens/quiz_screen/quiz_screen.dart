import 'package:flutter/material.dart';
import 'package:quiz_app/services/resources/style_manger.dart';
import 'package:percent_indicator/percent_indicator.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 480;
    final double scaleFactor = isMobile ? 1.0 : 1.5;
    final padding = isMobile ? 20.0 : 40.0;
    final smallDevicePadding = size.height < 720 ? 120.0 : 180.0;
    return Scaffold(
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
                      const AnswerCard(isTapped: true, ans: 'true'),
                      SizedBox(height: isMobile ? 15.0 : 20.0),
                      const AnswerCard(isTapped: false, ans: 'false'),
                      SizedBox(height: isMobile ? 15.0 : 20.0),
                      const AnswerCard(isTapped: true, ans: 'false'),
                      SizedBox(height: isMobile ? 15.0 : 20.0),
                      const AnswerCard(isTapped: false, ans: 'false'),
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
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: CircularPercentIndicator(
                  backgroundColor: Colors.white,
                  radius: 50.0,
                  // animationDuration: 500,
                  lineWidth: 7.0,
                  // animation: true,
                  percent: 0.75,
                  progressColor: ColorManager.primary,
                  animateFromLastPercent: true,
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Text(
                    '18',
                    style: getBoldTextStyle(
                      color: ColorManager.primary,
                    ),
                    textScaleFactor: scaleFactor,
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

class AnswerCard extends StatelessWidget {
  const AnswerCard({
    Key? key,
    required this.isTapped,
    required this.ans,
  }) : super(key: key);
  final bool isTapped;
  final String ans;

  bool checkAnswer() {
    return ans == 'true';
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 480;
    final double scaleFactor = isMobile ? 1.0 : 1.5;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      width: double.infinity,
      height: isMobile ? 60.0 : 75.0,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: !isTapped
              ? const Color.fromARGB(255, 205, 204, 204)
              : (checkAnswer() ? ColorManager.correct : ColorManager.error),
          width: 2.0 * scaleFactor,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text("Nile River",
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
                    : (checkAnswer()
                        ? ColorManager.correct
                        : ColorManager.error),
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
                        checkAnswer() ? Icons.check : Icons.close,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
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
              LabelledChip(isWrong: false, score: 06, scaleFactor: scaleFactor),
              LabelledChip(isWrong: true, score: 08, scaleFactor: scaleFactor),
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
                      text: "13",
                      style: getBoldTextStyle(color: ColorManager.primary)),
                  TextSpan(
                      text: "/20",
                      style: getMediumTextStyle(color: ColorManager.primary)),
                ])),
          ),
          const SizedBox(height: 20.0),
          Align(
            child: Text("Which is the longest river in the world?",
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
