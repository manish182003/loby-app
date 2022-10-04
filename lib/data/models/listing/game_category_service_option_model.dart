// ignore_for_file: overridden_fields, annotate_overrides

import 'package:loby/data/models/listing/service_option_model.dart';
import 'package:loby/domain/entities/listing/game_category_service.dart';
import '../../../domain/entities/listing/game_category_service_option.dart';
import 'service_model.dart';

class GameCategoryServiceOptionModel extends GameCategoryServiceOption {
  const GameCategoryServiceOptionModel({
    this.id,
    this.serviceOption,
  });


  final int? id;
  final ServiceOptionModel? serviceOption;

  factory GameCategoryServiceOptionModel.fromJson(Map<String, dynamic> json) => GameCategoryServiceOptionModel(
    id: json["id"],
    serviceOption: ServiceOptionModel.fromJson(json["serviceOption"]),
    );

  Map<String, dynamic> toJson() => {
    "id": id,
    "serviceOption": serviceOption?.toJson(),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [id, serviceOption];
}