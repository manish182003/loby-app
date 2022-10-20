import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/profile/bank_detail.dart';
import 'package:loby/domain/entities/profile/user.dart';




class FollowerResponse extends Equatable {
  final List<User> followers;

  const FollowerResponse({
    required this.followers,
  });

  @override
  List<Object> get props => [followers];
}
