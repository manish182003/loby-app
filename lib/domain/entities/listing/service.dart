import 'package:equatable/equatable.dart';

class Service extends Equatable {
  Service({
    this.id,
    this.name,
    this.selectionType,
    this.serviceOption,
  });

  int id;
  String name;
  int selectionType;
  List<ServiceOption> serviceOption;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
    name: json["name"],
    selectionType: json["selection_type"],
    serviceOption: List<ServiceOption>.from(json["serviceOption"].map((x) => ServiceOption.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "selection_type": selectionType,
    "serviceOption": List<dynamic>.from(serviceOption.map((x) => x.toJson())),
  };
}