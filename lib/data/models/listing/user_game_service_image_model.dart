import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/listing/user_game_service_image.dart';
// ignore_for_file: overridden_fields, annotate_overrides

class UserGameServiceImageModel extends UserGameServiceImage {
  const UserGameServiceImageModel({
    this.id,
    this.userGameServiceId,
    this.path,
    this.type,
  });

  final int? id;
  final int? userGameServiceId;
  final String? path;
  final int? type;


  factory UserGameServiceImageModel.fromJson(Map<String, dynamic> json) => UserGameServiceImageModel(
    id: json["id"],
    userGameServiceId: json["user_game_service_id"],
    path: json["path"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_game_service_id": userGameServiceId,
    "path": path,
    "type": type,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [id, userGameServiceId, path, type];
}
