import 'package:loby/domain/entities/auth/country.dart';
// ignore_for_file: overridden_fields, annotate_overrides


class CountryModel extends Country{
  const CountryModel({
    this.id,
    this.name,
    this.iso3,
    this.numericCode,
    this.latitude,
    this.longitude,
    this.flag,
    this.wikiDataId,
    this.iso2,
    this.phonecode,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? name;
  final String? iso3;
  final String? numericCode;
  final String? latitude;
  final String? longitude;
  final bool? flag;
  final String? wikiDataId;
  final String? iso2;
  final String? phonecode;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    id: json["id"],
    name: json["name"],
    iso3: json["iso3"],
    numericCode: json["numeric_code"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    flag: json["flag"],
    wikiDataId: json["wikiDataId"],
    iso2: json["iso2"],
    phonecode: json["phonecode"],
    createdAt: json["createdAt"] == null ? null :  DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "iso3": iso3,
    "numeric_code": numericCode,
    "latitude": latitude,
    "longitude": longitude,
    "flag": flag,
    "wikiDataId": wikiDataId,
    "iso2": iso2,
    "phonecode": phonecode,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };

  @override

  List<Object?> get props => [id, name, latitude, longitude, phonecode];
}
