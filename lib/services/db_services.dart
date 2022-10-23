import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/models/quiz_topic.dart';

import '../models/quiz_model.dart';

class DatabaseService {
  // the base url to the quesitons
  static const questionUrl =
      "https://quiz-app-33f81-default-rtdb.firebaseio.com/quiz";

  /// Add questions to the database
  Future<void> addQuestion(String topicId, Question question) async {
    final url = Uri.parse("$questionUrl/$topicId.json");
    await http.post(url,
        body: json.encode({
          "questionText": question.questionText,
          "answers": [
            question.answers[0],
            question.answers[1],
            question.answers[2],
            question.answers[3],
          ],
          "correctAnswerIndex": question.correctAnswerIndex,
        }));
  }

  /// fetch questions from the database
  Future<List<Question>> getQuestion(String topicId) async {
    final url = Uri.parse("$questionUrl/$topicId.json");
    return await http.get(url).then((response) {
      final data = json.decode(response.body) as Map<String, dynamic>;

      return data.values
          .map((e) => Question(
                id: data.keys.firstWhere((key) => data[key] == e),
                questionText: e['questionText'],
                answers: List<String>.from(e['answers']),
                correctAnswerIndex: e['correctAnswerIndex'],
              ))
          .toList()
          .cast<Question>();
    });
  }

  // upload user data to the database
  void registerUserData(User user, {String? name}) {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      users.doc(user.uid).set({
        'name': name ?? user.displayName,
        'email': user.email,
        'photoUrl': user.photoURL ?? "",
        'uid': user.uid,
        // 'lastSeen': DateTime.now(),
      });
    } catch (e) {
      print("Error adding data $e");
    }
  }

  void updatePicture(String imgUrl) {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      users.doc(user.uid).set({
        'photoUrl': imgUrl,
      }, SetOptions(merge: true));
    } catch (e) {
      print("Error updating image $e");
    }
  }

  Future<void> addQuizTopic(QuizTopic topic) async {
    try {
      CollectionReference topics =
          FirebaseFirestore.instance.collection('topics');
      await topics.doc(topic.title).set({
        'id': topic.id,
        'title': topic.title,
        'description': topic.description,
        'imageUrl': topic.image,
        // 'lastSeen': DateTime.now(),
      });
    } catch (e) {
      print("Error adding data $e");
    }
  }

  Future<List<QuizTopic>> fetchQuizTopics() async {
    try {
      CollectionReference topics =
          FirebaseFirestore.instance.collection('topics');
      final data = await topics.get();
      return data.docs
          .map((snapshot) =>
              QuizTopic.fromMap(snapshot.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error adding data $e");
    }
    return [];
  }

  // Update user reports to the database
  Future<void> updateUserReport(String topic, int score, int total) async {
    // int allTimeTotal = 0;
    // int allTimeBest = 0;
    // int totalQuestions = 0;
    // int previousScore = 0;
    // int previousAttempt = 0;

    final user = FirebaseAuth.instance.currentUser!;
    CollectionReference reports =
        FirebaseFirestore.instance.collection('reports');

    try {
      //   // let's first retrive data , so we can change it...
      // await reports.doc(user.uid).get().then((value) {
      //   if (value.exists) {
      //     final x = value[topic] ?? "0/0";
      //     previousScore = int.parse(x.toString().split('/').first);
      //     previousAttempt = int.parse(x.toString().split('/').last);
      //     allTimeTotal = value['total-score'] ?? 0;
      //     allTimeBest = value['highest-score'] ?? 0;
      //     totalQuestions = value['total-questions'] ?? 0;
      //     print(
      //         "prevous high $allTimeBest previous score $previousScore, all time total $allTimeTotal");
      //   }
      // });

      // / now let's change the data accordingly
      await reports.doc(user.uid).set({
        //     'highest-score': allTimeBest > score ? allTimeBest : score,
        //     'total-score': allTimeTotal + score - previousScore,
        //     'total-questions': totalQuestions + total - previousAttempt,
        topic: "$score/$total",
      }, SetOptions(merge: true));
    } catch (e) {
      print("Error updating score $e");
    }
  }

  // Get user reports from the database
  Future<List<TopicScore>> getUserReport() async {
    final user = FirebaseAuth.instance.currentUser!;
    CollectionReference reports =
        FirebaseFirestore.instance.collection('reports');

    try {
      final data = await reports.doc(user.uid).get();
      return (data.data() as Map<String, dynamic>)
          .entries
          .map((e) => TopicScore(e.key, e.value))
          .toList();
    } catch (e) {
      print("Error updating score $e");
    }
    return [];
  }
}

class TopicScore {
  String topic;
  String score;
  TopicScore(this.topic, this.score);
}
