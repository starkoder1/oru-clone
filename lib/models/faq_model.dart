// lib/models/faq_model.dart
class FaqModel {
  final String id;
  final String question;
  final String answer;

  FaqModel({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      id: json['_id'] ?? '', // Use a default value if _id is null
      question: json['question'] ?? '', // Use a default value if question is null
      answer: json['answer'] ?? '',     // Use a default value if answer is null
    );
  }
}