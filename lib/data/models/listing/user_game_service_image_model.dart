import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/listing/user_game_service_image.dart';

import '../../../core/utils/environment.dart';
import '../../../core/utils/helpers.dart';
// ignore_for_file: overridden_fields, annotate_overrides

class UserGameServiceImageModel extends UserGameServiceImage {
  const UserGameServiceImageModel({
    this.id,
    this.userGameServiceId,
    this.path,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? userGameServiceId;
  final String? path;
  final int? type;
  final DateTime? createdAt;
  final DateTime? updatedAt;


  factory UserGameServiceImageModel.fromJson(Map<String, dynamic> json) => UserGameServiceImageModel(
    id: json["id"],
    userGameServiceId: json["user_game_service_id"],
    path: Helpers.getImage(json["path"]),
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
