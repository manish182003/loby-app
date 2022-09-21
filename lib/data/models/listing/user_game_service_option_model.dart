import 'package:equatable/equatable.dart';
import 'package:loby/data/models/listing/service_option_model.dart';
import 'package:loby/domain/entities/listing/service_option.dart';
import 'package:loby/domain/entities/listing/user_game_service_option.dart';
// ignore_for_file: overridden_fields, annotate_overrides


class UserGameServiceOptionModel extends UserGameServiceOption{
  const UserGameServiceOptionModel({
    this.id,
    this.userGameServiceId,
    this.serviceOptionId,
    this.optionAnswer,
    this.createdAt,
    this.updatedAt,
    this.serviceOptions,
  });

  final int? id;
  final int? userGameServiceId;
  final int? serviceOptionId;
  final String? optionAnswer;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<ServiceOptionModel>? serviceOptions;

  factory UserGameServiceOptionModel.fromJson(Map<String, dynamic> json) => UserGameServiceOptionModel(
    id: json["id"],
    userGameServiceId: json["user_game_service_id"],
    serviceOptionId: json["service_option_id"],
    optionAnswer: json["option_answer"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    serviceOptions: List<ServiceOptionModel>.from(json["serviceOptions"].map((x) => ServiceOptionModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_game_service_id": userGameServiceId,
    "service_option_id": serviceOptionId,
    "option_answer": optionAnswer,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "serviceOptions": List<dynamic>.from(serviceOptions!.map((x) => x.toJson())),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [id, userGameServiceId, serviceOptionId];
}