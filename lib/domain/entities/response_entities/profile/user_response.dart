import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/profile/user.dart';



class UserResponse extends Equatable {
  final User user;

  const UserResponse({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}
