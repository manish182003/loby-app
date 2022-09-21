import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/listing/service_option.dart';

import 'service_model.dart';
// ignore_for_file: overridden_fields, annotate_overrides

class ServiceOptionModel extends ServiceOption {
  const ServiceOptionModel({
    this.id,
    this.serviceId,
    this.serviceOptionName,
    this.createdAt,
    this.updatedAt,
    this.service,

  });

  final int? id;
  final int? serviceId;
  final String? serviceOptionName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ServiceModel? service;

  factory ServiceOptionModel.fromJson(Map<String, dynamic> json) => ServiceOptionModel(
    id: json["id"],
    serviceOptionName: json["service_option"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "service_option": serviceOptionName,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [id, serviceOptionName];
}