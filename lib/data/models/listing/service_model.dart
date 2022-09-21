import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/listing/service_option.dart';

class ServiceModel extends Service {
  ServiceModel({
    this.id,
    this.name,
    this.selectionType,
    this.serviceOption,
  });

  int? id;
  String? name;
  int? selectionType;
  List<ServiceOption>? serviceOption;

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
    id: json["id"],
    name: json["name"],
    selectionType: json["selection_type"],
    serviceOption: List<ServiceOption>.from(json["serviceOption"].map((x) => ServiceOption.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "selection_type": selectionType,
    "serviceOption": List<dynamic>.from(serviceOption!.map((x) => x.toJson())),
  };

  // TODO: implement props
  List<Object?> get props => [id, name, selectionType];
}