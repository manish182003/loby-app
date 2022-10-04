import 'package:loby/data/models/listing/service_option_model.dart';
import 'package:loby/domain/entities/listing/service.dart';
// ignore_for_file: overridden_fields, annotate_overrides



class ServiceModel extends Service {
  ServiceModel({
    this.id,
    this.name,
    this.selectionType,
    this.index = 0,
  });

  final int? id;
  final String? name;
  final int? selectionType;
  int index;

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
    id: json["id"],
    name: json["name"],
    selectionType: json["selection_type"],
    );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "selection_type": selectionType,
  };

  // TODO: implement props
  List<Object?> get props => [id, name, selectionType, index];
}