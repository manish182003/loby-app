// ignore_for_file: overridden_fields, annotate_overrides

import 'package:loby/domain/entities/order/review_ratings.dart';

class ReviewModel extends ReviewRatings {
  final int? id;
  final int? userOrderId;
  final int? star;
  final String? comments;
  final int? userGameServiceId;
  final int? userId;
  const ReviewModel({
    this.id,
    this.userOrderId,
    this.star,
    this.comments,
    this.userGameServiceId,
    this.userId,
  });

  factory ReviewModel.fromJSON(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      userOrderId: json['user_order_id'],
      comments: json['comments'],
      star: json['star'],
      userGameServiceId: json['user_game_service_id'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_order_id": userOrderId,
        "star": star,
        "comments": comments,
        "user_game_service_id": userGameServiceId,
        "user_id": userId,
      };
}
