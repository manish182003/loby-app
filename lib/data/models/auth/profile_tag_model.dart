import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/auth/profile_tag.dart';
// ignore_for_file: overridden_fields, annotate_overrides


class ProfileTagModel extends ProfileTag{
  const ProfileTagModel({
    this.id,
    this.name,
  });

  final int? id;
  final String? name;

  factory ProfileTagModel.fromJson(Map<String, dynamic> json) => ProfileTagModel(
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