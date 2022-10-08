import 'package:loby/data/models/home/category_model.dart';
import 'package:loby/data/models/home/game_model.dart';
import 'package:loby/data/models/home/static_data_model.dart';
import 'package:loby/data/models/order/order_model.dart';
import 'package:loby/domain/entities/home/game.dart';
import 'package:loby/domain/entities/response_entities/home/category_response.dart';
import 'package:loby/domain/entities/response_entities/home/game_response.dart';
import 'package:loby/domain/entities/response_entities/home/static_data_response.dart';
import 'package:loby/domain/entities/response_entities/order/order_response.dart';

import '../../../../domain/entities/home/category.dart';
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
