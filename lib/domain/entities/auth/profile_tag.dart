import 'package:equatable/equatable.dart';


class ProfileTag extends Equatable{
  const ProfileTag({
    this.id,
    this.name,
  });

  final int? id;
  final String? name;

  factory ProfileTag.fromJson(Map<String, dynamic> json) => ProfileTag(
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