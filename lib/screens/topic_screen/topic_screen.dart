import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../models/quiz_topic.dart';
import '../../services/services.dart';
import '../quiz_detail_screen.dart/quiz_detail_screen.dart';

class TopicScreen extends StatelessWidget {
  const TopicScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(),
      appBar: AppBar(
        title: const Text("Quizzey"),
        centerTitle: true,
        // automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: StaggeredGrid.count(
              axisDirection: AxisDirection.down,
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              children: _staggeredGridItems(),
            ),
          ),
        ),
      ),
    );
  }
}

///

List<StaggeredGridTile> _staggeredGridItems() {
  int count = 0;
  double mainAxisCount = 1;
  return quizTopic.map((topic) {
    if (count % 4 == 0) {
      mainAxisCount = 1.4;
    } else if (count % 3 == 0) {
      mainAxisCount = 1.4;
    } else if (count % 2 == 0) {
      mainAxisCount = 1.4;
    } else {
      mainAxisCount = 1.6;
    }
    count++;
    return StaggeredGridTile.count(
      crossAxisCellCount: 1,
      mainAxisCellCount: mainAxisCount,
      child: QuizTopicCard(topic),
    );
  }).toList();
}

class QuizTopicCard extends StatelessWidget {
  const QuizTopicCard(
    this.quizTopic, {
    Key? key,
  }) : super(key: key);
  final QuizTopic quizTopic;

  @override
  Widget build(BuildContext context) {
    final bool isMultipleWord = quizTopic.title.contains(" ");
    late String first, second;
    if (isMultipleWord) {
      first = quizTopic.title.split(" ").first;
      second = quizTopic.title.split(" ").last;
    }
    return InkWell(
      splashColor: ColorManager.primary,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return QuizDetailScreen(quizTopic);
        }));
      },
      child: Hero(
        tag: quizTopic.id,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage(quizTopic.image),
              colorFilter:
                  const ColorFilter.mode(Colors.black45, BlendMode.darken),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: FittedBox(
              child: Text(
                !isMultipleWord ? quizTopic.title : "$first\n$second",
                textAlign: TextAlign.center,
                style: getBoldTextStyle(
                  size: 40.0,
                  color: ColorManager.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
