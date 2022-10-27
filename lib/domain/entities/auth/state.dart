import 'package:equatable/equatable.dart';

class State extends Equatable{
  const State({
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


  @override
  List<Object?> get props => [id, name, countryId, countryCode];
}
