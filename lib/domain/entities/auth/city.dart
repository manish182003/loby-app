import 'package:equatable/equatable.dart';

class City extends Equatable{
  const City({
    this.id,
    this.name,
    this.stateId,
    this.stateCode,
    this.countryId,
    this.countryCode,
    this.latitude,
    this.longitude,
    this.flag,
    this.wikiDataId,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? name;
  final int? stateId;
  final String? stateCode;
  final int? countryId;
  final String? countryCode;
  final String? latitude;
  final String? longitude;
  final bool? flag;
  final String? wikiDataId;
  final DateTime? createdAt;
  final DateTime? updatedAt;


  @override
  // TODO: implement props
  List<Object?> get props => [name, id, stateCode, stateId, countryCode, countryId];
}
