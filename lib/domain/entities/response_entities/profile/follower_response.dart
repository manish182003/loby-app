import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/profile/bank_detail.dart';
import 'package:loby/domain/entities/profile/user.dart';




class FollowerResponse extends Equatable {
  final int id;
  final String name;
  final String displayName;
  final List<User> followers;

  const FollowerResponse({
    required this.id,
    required this.name,
    required this.displayName,
    required this.followers,
  });

  @override
  List<Object> get props => [id, name, displayName, followers];
}
