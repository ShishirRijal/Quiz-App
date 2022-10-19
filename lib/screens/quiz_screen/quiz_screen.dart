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
    return Scaffold(
      backgroundColor: Color.fromARGB(242, 253, 253, 253),
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              Container(
                height: 250,
                width: size.width,
                decoration: const BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 200, 20, 0),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      AnserCard(isTapped: true, ans: 'true'),
                      SizedBox(height: 15.0),
                      AnserCard(isTapped: false, ans: 'false'),
                      SizedBox(height: 15.0),
                      AnserCard(isTapped: true, ans: 'false'),
                      SizedBox(height: 15.0),
                      AnserCard(isTapped: false, ans: 'false'),
                      //
                    ],
                  ),
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
                    // size: 14,
                    color: ColorManager.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnserCard extends StatelessWidget {
  const AnserCard({
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      width: double.infinity,
      height: 60.0,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: !isTapped
              ? Color.fromARGB(255, 205, 204, 204)
              : (checkAnswer() ? ColorManager.correct : ColorManager.error),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Nile River",
              style: getMediumTextStyle(color: ColorManager.darkGrey)),
          Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              color: !isTapped
                  ? Colors.transparent
                  : (checkAnswer() ? ColorManager.correct : ColorManager.error),
              borderRadius: BorderRadius.circular(15.0),
              border: isTapped
                  ? null
                  : Border.all(
                      color: const Color.fromARGB(255, 205, 204, 204),
                      width: 2.0,
                    ),
            ),
            child: !isTapped
                ? null
                : Icon(
                    checkAnswer() ? Icons.check : Icons.close,
                    color: Colors.white,
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      height: 200.0,
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              LabelledChip(isWrong: false, score: 06),
              LabelledChip(isWrong: true, score: 08),
            ],
          ),
          const SizedBox(height: 5.0),
          Flexible(
            child: RichText(
                textAlign: TextAlign.center,
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
  }) : super(key: key);
  final bool isWrong;
  final int score;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (!isWrong)
          Text(score < 10 ? '0$score' : '$score',
              style: getMediumTextStyle(color: Colors.green)),
        Container(
          height: 15.0,
          width: 40.0,
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            color: isWrong ? Colors.red : Colors.green,
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        if (isWrong)
          Text(score < 10 ? '0$score' : '$score',
              style: getMediumTextStyle(color: Colors.red)),
      ],
    );
  }
}
