import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/profile/user.dart';

class Rating extends Equatable{
  const Rating({
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
  final User? user;

  @override
  // TODO: implement props
  List<Object?> get props => [id, star, comments];
}
