import 'package:flutter/material.dart';
import 'package:quiz_app/models/quiz_topic.dart';
import 'package:quiz_app/services/resources/routes_manager.dart';
import 'package:quiz_app/services/resources/style_manger.dart';

class QuizDetailScreen extends StatelessWidget {
  const QuizDetailScreen(this.topic, {super.key});
  final QuizTopic topic;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(topic.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.4,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
                color: ColorManager.primary,
              ),
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                  child: Hero(
                      tag: topic.id,
                      child: Image.network(topic.image, fit: BoxFit.cover))),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                topic.description,
                style: getRegularTextStyle(),
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: size.width * 0.9,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.quizRoute);
                },
                child: const Text("Start Quiz"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
