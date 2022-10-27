// ignore_for_file: overridden_fields, annotate_overrides


import 'package:loby/domain/entities/response_entities/order/dispute_response.dart';

import '../../order/dispute_model.dart';


class DisputeResponseModel extends DisputeResponse {

  final int count;
  final List<DisputeModel> disputes;

  const DisputeResponseModel({
    required this.count,
    required this.disputes,
  }) : super(count: count, disputes: disputes);

  @override
  List<Object> get props => [disputes];

  factory DisputeResponseModel.fromJSON(Map<String, dynamic> json) =>
      DisputeResponseModel(
        count: json['data']['count'],
        disputes: (json['data']['rows'] as List<dynamic>)
            .map<DisputeModel>((dispute) => DisputeModel.fromJson(dispute))
            .toList(),
      );
}
