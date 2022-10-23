import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/screens/quiz_screen/quiz_screen.dart';
import 'package:quiz_app/services/db_services.dart';

import '../../services/quiz_controller.dart';
import '../../widgets/loading_screen.dart';

class Quiz extends StatelessWidget {
  const Quiz({super.key, required this.topicId});
  final String topicId;

  @override
  Widget build(BuildContext context) {
    final quiz = Provider.of<QuizController>(context);
    quiz.setTopic(topicId);
    // Once the quiz time is complete, go to the result screen

    return FutureBuilder(
        future: DatabaseService().getQuestion(topicId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            quiz.setQuestions(snapshot.data!);
            // return Text(snapshot.data!.length.toString());
            return const QuizScreen();
          } else {
            return const LoadingScreen();
          }
        });
  }
}
