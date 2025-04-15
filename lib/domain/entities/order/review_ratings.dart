import 'package:equatable/equatable.dart';

class ReviewRatings extends Equatable {
  final int? id;
  final int? userOrderId;
  final int? star;
  final String? comments;
  final int? userGameServiceId;
  final int? userId;

  const ReviewRatings({
    this.id,
    this.userOrderId,
    this.star,
    this.comments,
    this.userGameServiceId,
    this.userId,
  });

  @override
  List<Object?> get props => [
        id,
        userOrderId,
        star,
        comments,
        userGameServiceId,
        userId,
      ];
}
