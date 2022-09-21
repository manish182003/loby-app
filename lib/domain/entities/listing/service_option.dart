import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/listing/service.dart';

class ServiceOption extends Equatable {
  const ServiceOption({
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
  final Service? service;
  


  @override
  // TODO: implement props
  List<Object?> get props => [id, serviceOptionName];
}