import 'package:equatable/equatable.dart';

class Faqs extends Equatable {
  const Faqs({
    this.id,
    this.question,
    this.answer,
    this.createdAt,
  });
  final int? id;
  final String? question;
  final String? answer;
  final DateTime? createdAt;
  @override
  List<Object?> get props => [id, question, answer, createdAt];
}
