import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/listing/service_option.dart';

class UserGameServiceOption extends Equatable{
  const UserGameServiceOption({
    this.id,
    this.userGameServiceId,
    this.serviceOptionId,
    this.optionAnswer,
    this.createdAt,
    this.updatedAt,
    this.serviceOptions,
  });

  final int? id;
  final int? userGameServiceId;
  final int? serviceOptionId;
  final String? optionAnswer;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<ServiceOption>? serviceOptions;


  @override
  // TODO: implement props
  List<Object?> get props => [id, userGameServiceId, serviceOptionId];
}