import 'package:equatable/equatable.dart';

class ServiceOption extends Equatable {
  const ServiceOption({
    this.id,
    this.serviceOptionName,
  });

  final int? id;
  final String? serviceOptionName;

  factory ServiceOption.fromJson(Map<String, dynamic> json) => ServiceOption(
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