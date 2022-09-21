import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/listing/service_option.dart';
// ignore_for_file: overridden_fields, annotate_overrides

class ServiceOptionModel extends ServiceOption {
  const ServiceOptionModel({
    this.id,
    this.serviceOptionName,
  });

  final int? id;
  final String? serviceOptionName;

  factory ServiceOptionModel.fromJson(Map<String, dynamic> json) => ServiceOptionModel(
    id: json["id"],
    serviceOptionName: json["service_option"],
  );

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "service_option": serviceOptionName,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [id, serviceOptionName];
}