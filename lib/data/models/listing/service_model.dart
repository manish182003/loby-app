// ignore_for_file: must_be_immutable

import 'package:loby/domain/entities/listing/service.dart';
// ignore_for_file: overridden_fields, annotate_overrides



class ServiceModel extends Service {
  ServiceModel({
    this.id,
    this.name,
    this.previewName,
    this.selectionType,
    this.index = 0,
  });

  final int? id;
  final String? name;
  final String? previewName;
  final int? selectionType;
  int index;

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
    id: json["id"],
    name: json["name"],
    previewName: json["preview_name"],
    selectionType: json["selection_type"],
    );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "selection_type": selectionType,
  };


  List<Object?> get props => [id, name, selectionType, index];
}