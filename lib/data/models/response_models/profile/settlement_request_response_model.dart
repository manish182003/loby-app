// ignore_for_file: overridden_fields, annotate_overrides



import 'package:loby/data/models/profile/settlement_request_model.dart';
import 'package:loby/domain/entities/response_entities/profile/settlement_request_response.dart';

// import '../../../../domain/entities/response_entities/profile/wallet_transaction_response.dart';
// import '../../profile/wallet_transaction_model.dart';


class SettlementRequestResponseModel extends SettlementRequestResponse {

  final int count;
  final List<SettlementRequestModel> settlementRequests;

  const SettlementRequestResponseModel({
    required this.count,
    required this.settlementRequests,
  }) : super(count: count, settlementRequests: settlementRequests);

  @override
  List<Object> get props => [settlementRequests];

  factory SettlementRequestResponseModel.fromJSON(Map<String, dynamic> json) =>
      SettlementRequestResponseModel(
        count: json['data']['count'],
        settlementRequests: (json['data']['rows'] as List<dynamic>)
            .map<SettlementRequestModel>((transaction) => SettlementRequestModel.fromJson(transaction))
            .toList(),
      );
}
