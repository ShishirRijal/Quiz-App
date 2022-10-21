import 'package:flutter/material.dart';
import '../models/quiz_model.dart';
import '../models/report.dart';
import 'resources/style_manger.dart';

class Quiz with ChangeNotifier {
  static final url = Uri.parse(
      "https://quiz-app-33f81-default-rtdb.firebaseio.com/quiz.json"); // api url

  // final List<Question> _questions = [];
  List<Question> get questions => _questions;

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

  int get quizDuration => _questions.length * 10;
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

  static const List<Question> _questions = [
    Question(
      id: 'longest-river-in-world',
      questionText: "Which is the longest river of the world?",
      answers: ['Nile', 'Ganga', 'Blue Tue', 'Dainy,'],
      correctAnswerIndex: 0,
    ),
    Question(
      id: 'gautam-buddha-birth-place',
      questionText: "Which one is the birth place of Gautam Buddha?",
      answers: [
        'Bahra - India',
        'Lumbini - Nepal',
        'Wuhan - China ',
        'Bangkok - Thailand',
      ],
      correctAnswerIndex: 1,
    ),
    Question(
        id: 'ceo-of-google',
        questionText: "Who is the CEO of GOOGLE?",
        answers: [
          'Sundar Paneru',
          'Pramesh Sundar',
          'Sundar Pichai',
          'Pichmesh Sundar',
        ],
        correctAnswerIndex: 2),
    Question(
      id: 'most-reputed-ioe-college',
      questionText:
          "Which the the most preveliged engineering campus of Nepal?",
      answers: [
        'Pulchowk Campus',
        'Paschimanchal Campus',
        'Purwanchal Campus',
        'Thapathali Campus',
      ],
      correctAnswerIndex: 0,
    ),
  ];

// get the questions from the database....

  // void getQuestions() {
  //   http.get(url).then((response) {
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body) as Map<String, dynamic>;
  //       data.forEach((key, value) {
  //         _questions.add(Question(
  //           id: key,
  //           questionText: value['questionText'],
  //           answers: [
  //             Answer(value['answers']['option1']['value'],
  //                 value['answers']['option1']['isCorrect']),
  //             Answer(value['answers']['option2']['value'],
  //                 value['answers']['option2']['isCorrect']),
  //             Answer(value['answers']['option3']['value'],
  //                 value['answers']['option3']['isCorrect']),
  //             Answer(value['answers']['option1']['value'],
  //                 value['answers']['option1']['isCorrect']),
  //           ],
  //         ));
  //       });
  //       notifyListeners();
  //     }
  //   });
  // }

  // post questions to the database...
  // void addQuestion(Question question) {
  //   http.post(url,
  //       body: json.encode({
  //         "questionText": question.questionText,
  //         "answers": {
  //           "option1": {
  //             "value": question.answers[0].answerText,
  //             "isCorrect": question.answers[0].isCorrect,
  //           },
  //           "option2": {
  //             "value": question.answers[1].answerText,
  //             "isCorrect": question.answers[1].isCorrect,
  //           },
  //           "option3": {
  //             "value": question.answers[2].answerText,
  //             "isCorrect": question.answers[2].isCorrect,
  //           },
  //           "option4": {
  //             "value": question.answers[3].answerText,
  //             "isCorrect": question.answers[3].isCorrect,
  //           },
  //         },
  //       }));
  // }

  // ends
}
