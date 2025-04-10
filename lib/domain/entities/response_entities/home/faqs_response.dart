import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/home/faqs.dart';

class FaqsResponse extends Equatable {
  final List<Faqs> allFaqs;

  const FaqsResponse({required this.allFaqs});

  @override
  List<Object?> get props => [allFaqs];
}
