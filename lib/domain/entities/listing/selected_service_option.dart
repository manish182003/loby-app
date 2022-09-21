import 'package:equatable/equatable.dart';

class SelectedServiceOption extends Equatable{

  int? id;
  String? name;

  SelectedServiceOption({
    this.id,
    this.name,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];

}