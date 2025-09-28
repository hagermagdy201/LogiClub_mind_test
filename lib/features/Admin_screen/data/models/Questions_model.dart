class questionsModel {
  final int id;
  final String questions;
  final String category;
  final List<String> options;
  final int correctAnswerIndex;

  questionsModel({
    required this.id,
    required this.category,
    required this.questions,
    required this.options,
    required this.correctAnswerIndex,
  });

  factory questionsModel.fromJson(Map<String, dynamic> json) {
    return questionsModel(
      id: json['id'],
      category: json['category'],
      questions: json['questions'],
      options: List<String>.from(json['options']),
      correctAnswerIndex: json['correctAnswerIndex'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'questions': questions,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
    };
  }

  factory questionsModel.fromMap(Map<String, dynamic> map) {
    return questionsModel(
      id: map['id'],
      category: map['category'],
      questions: map['questions'],
      options: List<String>.from(map['options']),
      correctAnswerIndex: map['correctAnswerIndex'],
    );
  }
}
