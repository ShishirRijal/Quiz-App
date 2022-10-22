import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/quiz_model.dart';
import '../models/report.dart';
import 'resources/style_manger.dart';

class QuizController with ChangeNotifier {
  static final url = Uri.parse(
      "https://quiz-app-33f81-default-rtdb.firebaseio.com/quiz.json"); // api url

  List<Question> _questions = [];
  List<Question> get questions => _questions;
  void setQuestions(List<Question> questions) {
    _questions = questions;
  }

// reset when done...

  void reset() {
    _correctAnswers = 0;
    _wrongAnswers = 0;
    _isTapped = false;
    _selectedIndex = 0;
    _isCompleted = false;
    _currentIndex = 0;
    _isAnswered = false;
  }

/* Quiz Controllers */

// score controllers
  int _correctAnswers = 0;
  int _wrongAnswers = 0;
  int get correctAnswers => _correctAnswers;
  int get wrongAnswers => _wrongAnswers;
  // change the score when use selects an answer
  void changeScore(bool isCorrect) {
    isCorrect ? _correctAnswers++ : _wrongAnswers++;
    notifyListeners();
  }
//

// Selected Index controllers
  late int _selectedIndex;
  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

// Tap events controllers
  bool _isTapped = false;
  bool getTapValue(index) {
    if (!_isTapped) {
      return false; // return false when no option is selected
    }
    if (index == questions[currentIndex].correctAnswerIndex) {
      return true;
    } else if (index == _selectedIndex) {
      return true;
    }
    return false;
  }

  // Quiz time and completion controllers

  // int get quizDuration => _questions.length * 10;
  int get quizDuration => 3;

  // check if the the quiz is completed
  bool _isCompleted = false;
  bool get isCompleted => _isCompleted;
  void setIsCompleted() {
    _isCompleted = true;
    notifyListeners();
  }

// question index
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  void changeQuestion() {
    _currentIndex++;
    notifyListeners();
  }

// get the option
  String getOption(int index) {
    return questions[currentIndex].answers[index];
  }

// get the no of quesitons
  int get noOfQuestions => _questions.length;
// get the current question
  String get currentQuestion => questions[currentIndex].questionText;

  // check if the answer is correct
  bool isCorrect(int index) {
    return questions[currentIndex].correctAnswerIndex == index;
  }

  // let's set a shared variable to check if the question is answered?
  //if it is answered , disable all other answers
  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;
  void setIsAnswered() {
    _isAnswered = true;
    notifyListeners();
  }

  void resetIsAnswered() {
    _isAnswered = false;
    notifyListeners();
  }

  /// Check if the answer is correct or not and implement all other functionalities
  void checkAnswer(int selectedIndex) {
    // sinche the user has tapped an answer, now disbale others...
    setIsAnswered();

    final question = questions[currentIndex]; // current question
    setSelectedIndex(selectedIndex); // set the selected answer index

    _isTapped =
        true; // the user has selected answer.. so change the card colors and more..

    // if answer is correct increase the correct answers count, else increase wrong answers count..
    question.correctAnswerIndex == selectedIndex
        ? changeScore(true)
        : changeScore(false);

    // let's change the question after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      // reset tap for new questions
      _isTapped = false;

      // if the quiz is completed, set the isCompleted to true , else go to next question
      currentIndex == questions.length - 1
          ? setIsCompleted()
          : changeQuestion(); // increment question index and get next question...
      resetIsAnswered(); // reset the isAnswered variable for upcoming question
    });
    // notifyListeners();
  }

  /// For Result Screen

  List<Result> get result {
    return [
      Result("Correct", correctAnswers, Colors.green),
      Result("Wrong", wrongAnswers, Colors.red),
      Result("Total Questions", questions.length, ColorManager.primary),
      Result("Achievement", (correctAnswers * 100) ~/ questions.length,
          Colors.purpleAccent, '%'),
    ];
  }

  // static const List<Question> _questions = [
  //   Question(
  //     id: 'longest-river-in-world',
  //     questionText: "Which is the longest river of the world?",
  //     answers: ['Nile', 'Ganga', 'Blue Tue', 'Dainy,'],
  //     correctAnswerIndex: 0,
  //   ),
  //   Question(
  //     id: 'gautam-buddha-birth-place',
  //     questionText: "Which one is the birth place of Gautam Buddha?",
  //     answers: [
  //       'Bahra - India',
  //       'Lumbini - Nepal',
  //       'Wuhan - China ',
  //       'Bangkok - Thailand',
  //     ],
  //     correctAnswerIndex: 1,
  //   ),
  //   Question(
  //       id: 'ceo-of-google',
  //       questionText: "Who is the CEO of GOOGLE?",
  //       answers: [
  //         'Sundar Paneru',
  //         'Pramesh Sundar',
  //         'Sundar Pichai',
  //         'Pichmesh Sundar',
  //       ],
  //       correctAnswerIndex: 2),
  //   Question(
  //     id: 'most-reputed-ioe-college',
  //     questionText:
  //         "Which the the most preveliged engineering campus of Nepal?",
  //     answers: [
  //       'Pulchowk Campus',
  //       'Paschimanchal Campus',
  //       'Purwanchal Campus',
  //       'Thapathali Campus',
  //     ],
  //     correctAnswerIndex: 0,
  //   ),
  // ];

// get the questions from the database....

  // Future<void> getQuestions() async {
  //   await http.get(url).then((response) {
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body) as Map<String, dynamic>;
  //       data.forEach((key, value) {
  //         _questions.add(Question(
  //           id: key,
  //           questionText: value['questionText'],
  //           answers: [
  //             value['answers'][0],
  //             value['answers'][1],
  //             value['answers'][2],
  //             value['answers'][3],
  //           ],
  //           correctAnswerIndex: value['correctAnswerIndex'],
  //         ));
  //       });
  //       notifyListeners();
  //     }
  //   });
  // }

  // Future<List<Question>> getQuestions() async {
  //   // List<Question> result = [];
  //   await http.get(url).then((response) {
  //     final data = json.decode(response.body) as Map<String, dynamic>;
  //     return data.forEach(
  //       (key, value) => Question(
  //         id: key,
  //         questionText: value['questionText'],
  //         answers: [
  //           value['answers'][0],
  //           value['answers'][1],
  //           value['answers'][2],
  //           value['answers'][3],
  //         ],
  //         correctAnswerIndex: value['correctAnswerIndex'],
  //       ),
  //     );

  //     // notifyListeners();
  //   });
  //   // return result;
  // }

  // post questions to the database...
  Future<void> addQuestion(Question question) async {
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

  // ends
}
