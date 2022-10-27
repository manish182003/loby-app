// ignore_for_file: overridden_fields, annotate_overrides

import 'package:loby/data/models/profile/duel_details_model.dart';
import 'package:loby/domain/entities/response_entities/profile/duel_response.dart';


class DuelResponseModel extends DuelResponse {

  final DuelDetailsModel duelDetails;

  const DuelResponseModel({
    required this.duelDetails,
  }) : super(duelDetails: duelDetails);

  @override
  List<Object> get props => [duelDetails];

  factory DuelResponseModel.fromJSON(Map<String, dynamic> json) =>
      DuelResponseModel(
          duelDetails: DuelDetailsModel.fromJson(json['data']['duelDetails'])
      );
}
