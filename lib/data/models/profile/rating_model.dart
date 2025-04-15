import 'package:loby/data/models/profile/user_model.dart';
import 'package:loby/domain/entities/profile/rating.dart';
// ignore_for_file: overridden_fields, annotate_overrides

class RatingModel extends Rating {
  const RatingModel({
    this.id,
    this.userOrderId,
    this.star,
    this.comments,
    this.userGameServiceId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  final int? id;
  final int? userOrderId;
  final int? star;
  final String? comments;
  final int? userGameServiceId;
  final int? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final UserModel? user;

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        id: json["id"],
        userOrderId: json["user_order_id"],
        star: json["star"],
        comments: json["comments"],
        userGameServiceId: json["user_game_service_id"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        user: UserModel.fromJson(json['user']), //json["userOrder"]['user']
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_order_id": userOrderId,
        "star": star,
        "comments": comments,
        "user_game_service_id": userGameServiceId,
        "user_id": userId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "userOrder": user,
      };

  @override
  List<Object?> get props => [id, star, comments];
}
