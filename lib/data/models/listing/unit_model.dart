import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/listing/unit.dart';
// ignore_for_file: overridden_fields, annotate_overrides


class UnitModel extends Unit{
  const UnitModel({
    this.id,
    this.name,
  });

  final int? id;
  final String? name;

  factory UnitModel.fromJson(Map<String, dynamic> json) => UnitModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}
