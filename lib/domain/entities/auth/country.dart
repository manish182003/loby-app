import 'package:equatable/equatable.dart';

class Country extends Equatable{
  const Country({
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

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, latitude, longitude, phonecode];
}
