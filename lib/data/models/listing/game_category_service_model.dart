// ignore_for_file: overridden_fields, annotate_overrides

import 'package:loby/domain/entities/listing/game_category_service.dart';
import 'service_model.dart';

class GameCategoryServiceModel extends GameCategoryService {
  const GameCategoryServiceModel({
    this.id,
    this.service,
  });


  final int? id;
  final ServiceModel? service;

  factory GameCategoryServiceModel.fromJson(Map<String, dynamic> json) => GameCategoryServiceModel(
    id: json["id"],
    service: ServiceModel.fromJson(json["service"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "service": service?.toJson(),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [id, service];
}