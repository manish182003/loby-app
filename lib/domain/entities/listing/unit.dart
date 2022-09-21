import 'package:equatable/equatable.dart';

class Unit extends Equatable{
  const Unit({
    this.id,
    this.name,
  });

  final int? id;
  final String? name;

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}
