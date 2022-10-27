// ignore_for_file: overridden_fields, annotate_overrides
import 'package:loby/domain/entities/home/static_data.dart';

class StaticDataModel extends StaticData{
  const StaticDataModel({
    this.id,
    this.key,
    this.realValue,
    this.label,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? key;
  final String? realValue;
  final String? label;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory StaticDataModel.fromJson(Map<String, dynamic> json) => StaticDataModel(
    id: json["id"],
    key: json["key"],
    realValue: json["value"],
    label: json["label"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "key": key,
    "value": realValue,
    "label": label,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };

  @override

  List<Object?> get props => [id, key, realValue, label];
}
