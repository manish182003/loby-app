import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/listing/game_category_service.dart';
import 'package:loby/domain/entities/listing/service.dart';
// ignore_for_file: overridden_fields, annotate_overrides


class GameCategoryServiceModel extends GameCategoryService {
  const GameCategoryServiceModel({
    this.id,
    this.service,
  });

  final int? id;
  final Service? service;

  factory GameCategoryServiceModel.fromJson(Map<String, dynamic> json) => GameCategoryServiceModel(
    id: json["id"],
    service: Service.fromJson(json["service"]),
  );

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "service": service?.toJson(),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [id, service];
}