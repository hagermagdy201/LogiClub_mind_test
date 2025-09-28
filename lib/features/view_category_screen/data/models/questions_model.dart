class QuestionsModel {
  final int id;
  final String question;
  final String category;
  final int answer;
  final List<String> options;

  QuestionsModel({
    required this.id,
    required this.question,
    required this.category,
    required this.answer,
    required this.options,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'category': category,
      'answer': answer,
      'options': options,
    };
  }

  factory QuestionsModel.fromJson(Map<String, dynamic> json) {
    return QuestionsModel(
      id: json['id'],
      question: json['question'],
      category: json['category'],
      answer: json['answer'],
      options: List<String>.from(json['options']),
    );
  }
}
