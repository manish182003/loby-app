// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Service extends Equatable {
  Service({
    this.id,
    this.name,
    this.selectionType,
    this.index = 0,
  });

  final int? id;
  final String? name;
  final int? selectionType;
  int index;



  @override
  // TODO: implement props
  List<Object?> get props => [id, name, selectionType, index];
}