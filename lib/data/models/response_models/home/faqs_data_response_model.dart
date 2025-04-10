import 'package:loby/data/models/home/faqs_model.dart';
import 'package:loby/domain/entities/response_entities/home/faqs_response.dart';

// ignore_for_file: overridden_fields, annotate_overrides
class FaqsDataResponseModel extends FaqsResponse {
  @override
  final List<FaqsModel> allFaqs;
  const FaqsDataResponseModel({required this.allFaqs})
      : super(allFaqs: allFaqs);

  @override
  List<Object> get props => [allFaqs];
  factory FaqsDataResponseModel.fromJson(Map<String, dynamic> json) {
    return FaqsDataResponseModel(
      allFaqs: (json['data'] as List<dynamic>)
          .map<FaqsModel>(
            (faq) => FaqsModel.fromJson(faq),
          )
          .toList(),
    );
  }
}
