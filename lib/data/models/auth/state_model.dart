import 'package:loby/domain/entities/auth/state.dart';
// ignore_for_file: overridden_fields, annotate_overrides


class StateModel extends State{
  const StateModel({
    this.id,
    this.name,
    this.countryId,
    this.countryCode,
    this.fipsCode,
    this.iso2,
    this.type,
    this.latitude,
    this.longitude,
    this.flag,
    this.wikiDataId,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? name;
  final int? countryId;
  final String? countryCode;
  final String? fipsCode;
  final String? iso2;
  final String? type;
  final String? latitude;
  final String? longitude;
  final bool? flag;
  final String? wikiDataId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
    id: json["id"],
    name: json["name"],
    countryId: json["country_id"],
    countryCode: json["country_code"],
    fipsCode: json["fips_code"],
    iso2: json["iso2"],
    type: json["type"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    flag: json["flag"],
    wikiDataId: json["wikiDataId"],
    createdAt: json["createdAt"] == null ? null :  DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country_id": countryId,
    "country_code": countryCode,
    "fips_code": fipsCode,
    "iso2": iso2,
    "type": type,
    "latitude": latitude,
    "longitude": longitude,
    "flag": flag,
    "wikiDataId": wikiDataId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };

  @override
  List<Object?> get props => [id, name, countryId, countryCode];
}
