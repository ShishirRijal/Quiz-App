class Question {
  final String id;
  final String questionText;
  final List<String> answers;
  final int correctAnswerIndex;
  const Question({
    required this.id,
    required this.questionText,
    required this.answers,
    required this.correctAnswerIndex,
  });
}
