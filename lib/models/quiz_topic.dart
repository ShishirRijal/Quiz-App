class QuizTopic {
  final String id;
  final String title;
  final String image;
  final String description;

  QuizTopic({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
  });

  QuizTopic.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        image = map['imageUrl'],
        description = map['description'];
}
