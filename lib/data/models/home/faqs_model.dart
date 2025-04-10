// ignore_for_file: overridden_fields, annotate_overrides
import 'package:loby/domain/entities/home/faqs.dart';

class FaqsModel extends Faqs {
  const FaqsModel({
    this.id,
    this.question,
    this.answer,
    this.createdAt,
  });

  final int? id;

  final String? question;

  final String? answer;

  final DateTime? createdAt;
  factory FaqsModel.fromJson(Map<String, dynamic> map) {
    return FaqsModel(
      id: map['id'] ?? 0,
      question: map['question'] ?? '',
      answer: map['answer'] ?? '',
      createdAt: DateTime.parse(map['createdAt']).toUtc(),
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "answer": answer,
        "createdAt": createdAt?.toUtc(),
      };
  @override
  List<Object?> get props => [id, question, answer, createdAt];
}
