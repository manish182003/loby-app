// ignore_for_file: overridden_fields, annotate_overrides

import 'package:loby/data/models/listing/game_category_service_option_model.dart';
import 'package:loby/domain/entities/listing/game_category_service.dart';
import 'service_model.dart';

class GameCategoryServiceModel extends GameCategoryService {
  const GameCategoryServiceModel({
    this.id,
    this.service,
    this.gameCategoryServiceOptions,
  });


  final int? id;
  final ServiceModel? service;
  final List<GameCategoryServiceOptionModel>? gameCategoryServiceOptions;

  factory GameCategoryServiceModel.fromJson(Map<String, dynamic> json) => GameCategoryServiceModel(
    id: json["id"],
    service: ServiceModel.fromJson(json["service"]),
    gameCategoryServiceOptions: List<GameCategoryServiceOptionModel>.from(json["gameCategoryServiceOptions"].map((x) => GameCategoryServiceOptionModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "service": service?.toJson(),
    "serviceOption": List<dynamic>.from(gameCategoryServiceOptions!.map((x) => x.toJson())),
  };

  @override
  
  List<Object?> get props => [id, service, gameCategoryServiceOptions];
}