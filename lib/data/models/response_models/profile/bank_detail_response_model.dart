// ignore_for_file: overridden_fields, annotate_overrides

import 'package:loby/data/models/listing/service_listing_model.dart';
import 'package:loby/data/models/profile/bank_detail_model.dart';
import 'package:loby/data/models/profile/duel_details_model.dart';
import 'package:loby/data/models/profile/user_model.dart';
import 'package:loby/domain/entities/listing/service_listing.dart';
import 'package:loby/domain/entities/response_entities/profile/bank_detail_response.dart';
import 'package:loby/domain/entities/response_entities/profile/duel_response.dart';
import 'package:loby/domain/entities/response_entities/profile/user_response.dart';


class BankDetailResponseModel extends BankDetailResponse {

  final List<BankDetailModel> bankDetails;

  const BankDetailResponseModel({
    required this.bankDetails,
  }) : super(bankDetails: bankDetails);

  @override
  List<Object> get props => [bankDetails];

  factory BankDetailResponseModel.fromJSON(Map<String, dynamic> json) =>
      BankDetailResponseModel(
        bankDetails: (json['data'] as List<dynamic>)
            .map<BankDetailModel>((ratings) => BankDetailModel.fromJson(ratings))
            .toList(),
      );
}
