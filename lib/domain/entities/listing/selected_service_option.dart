// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class SelectedServiceOption extends Equatable{

  int? id;
  String? name;

  SelectedServiceOption({
    this.id,
    this.name,
  });

  @override
  List<Object?> get props => [id, name];

}