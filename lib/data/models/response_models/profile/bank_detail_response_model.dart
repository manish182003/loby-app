// ignore_for_file: overridden_fields, annotate_overrides

import 'package:loby/data/models/profile/bank_detail_model.dart';
import 'package:loby/domain/entities/response_entities/profile/bank_detail_response.dart';


class BankDetailResponseModel extends BankDetailResponse {

  final List<BankDetailModel> bankDetails;

  const BankDetailResponseModel({
    required this.bankDetails,
  }) : super(bankDetails: bankDetails);

  @override
  List<Object> get props => [bankDetails];

  factory BankDetailResponseModel.fromJSON(Map<String, dynamic> json) =>
      BankDetailResponseModel(
        bankDetails: (json['data']['rows'] as List<dynamic>)
            .map<BankDetailModel>((ratings) => BankDetailModel.fromJson(ratings))
            .toList(),
      );
}
