// ignore_for_file: overridden_fields, annotate_overrides

import 'package:loby/data/models/profile/duel_details_count_model.dart';
import 'package:loby/data/models/profile/duel_details_model.dart';
import 'package:loby/domain/entities/response_entities/profile/duel_response.dart';


class DuelResponseModel extends DuelResponse {

  final DuelDetailsCountModel duelDetailsCount;
  final List<DuelDetailsModel> duelDetailsList;

  const DuelResponseModel({
    required this.duelDetailsCount,
    required this.duelDetailsList,
  }) : super(duelDetailsCount: duelDetailsCount, duelDetailsList: duelDetailsList);

  @override
  List<Object> get props => [duelDetailsCount, duelDetailsList];

  factory DuelResponseModel.fromJSON(Map<String, dynamic> json) =>
      DuelResponseModel(
          duelDetailsCount: DuelDetailsCountModel.fromJson(json["data"]["duelDetails"]),
          duelDetailsList: (json['data']['data']["rows"] as List<dynamic>)
              .map<DuelDetailsModel>((duel) => DuelDetailsModel.fromJson(duel))
              .toList(),
      );
}
