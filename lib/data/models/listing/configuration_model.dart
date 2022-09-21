import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/listing/configuration.dart';

import 'game_category_service_model.dart';
import 'unit_model.dart';
// ignore_for_file: overridden_fields, annotate_overrides



class ConfigurationModel extends Configuration{
  const ConfigurationModel({
    this.gameCategoryServices,
    this.units,
    this.maximumEstimatedDeliveryTimeDays,
  });

  final List<GameCategoryServiceModel>? gameCategoryServices;
  final List<UnitModel>? units;
  final String? maximumEstimatedDeliveryTimeDays;

  factory ConfigurationModel.fromJson(Map<String, dynamic> json) => ConfigurationModel(
    gameCategoryServices: List<GameCategoryServiceModel>.from(json["gameCategoryServices"].map((x) => GameCategoryServiceModel.fromJson(x))),
    units: List<UnitModel>.from(json["unit_type"].map((x) => UnitModel.fromJson(x))),
    maximumEstimatedDeliveryTimeDays: json["Maximum_estimated_delivery_time_days"],
  );

  Map<String, dynamic> toJson() => {
    "gameCategoryServices": List<dynamic>.from(gameCategoryServices!.map((x) => x.toJson())),
    "unit_type": List<dynamic>.from(units!.map((x) => x.toJson())),
    "Maximum_estimated_delivery_time_days": maximumEstimatedDeliveryTimeDays,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [gameCategoryServices, units, maximumEstimatedDeliveryTimeDays];
}