class Question {
  String id;
  String questionText;
  List<String> answers;
  int correctAnswerIndex;
  Question({
    required this.id,
    required this.questionText,
    required this.answers,
    required this.correctAnswerIndex,
  });

  factory Question.fromMap(Map<String, dynamic> data) {
    return Question(
      id: data['id'],
      questionText: data['questionText'],
      answers: List<String>.from(data['answers']),
      correctAnswerIndex: data['correctAnswerIndex'],
    );
  }
  // Question.fromMap(Map data) {
  //   id = data['id'];
  //   questionText = data['questionText'];
  //   answers = data['answers'];
  //   correctAnswerIndex = data['correctAnswerIndex'];
  // }
}
