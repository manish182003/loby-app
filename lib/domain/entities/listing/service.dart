

import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/listing/service_option.dart';

class Service extends Equatable {
  Service({
    this.id,
    this.name,
    this.selectionType,
    this.index = 0,
    this.serviceOption,
  });

  final int? id;
  final String? name;
  final int? selectionType;
  int index;
  final List<ServiceOption>? serviceOption;



  @override
  // TODO: implement props
  List<Object?> get props => [id, name, selectionType, index];
}