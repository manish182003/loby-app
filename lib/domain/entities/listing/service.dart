// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Service extends Equatable {
  Service({
    this.id,
    this.name,
    this.previewName,
    this.selectionType,
    this.index = 0,
  });

  final int? id;
  final String? name;
  final String? previewName;
  final int? selectionType;
  int index;



  @override
  // TODO: implement props
  List<Object?> get props => [id, name, previewName, selectionType, index];
}