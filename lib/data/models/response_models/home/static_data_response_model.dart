import 'package:loby/data/models/home/static_data_model.dart';
import 'package:loby/domain/entities/response_entities/home/static_data_response.dart';

// ignore_for_file: overridden_fields, annotate_overrides


class StaticDataResponseModel extends StaticDataResponse {

  final List<StaticDataModel> staticData;

  const StaticDataResponseModel({
    required this.staticData,
  }) : super(staticData: staticData);

  @override
  List<Object> get props => [staticData];

  factory StaticDataResponseModel.fromJSON(Map<String, dynamic> json) =>
      StaticDataResponseModel(
        staticData: (json['data'] as List<dynamic>)
            .map<StaticDataModel>((order) => StaticDataModel.fromJson(order))
            .toList(),
      );
}
