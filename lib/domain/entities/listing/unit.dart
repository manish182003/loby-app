import 'package:equatable/equatable.dart';

class Unit extends Equatable{
  const Unit({
    this.id,
    this.name,
  });

  final int? id;
  final String? name;

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}
