// ignore_for_file: overridden_fields, annotate_overrides

import 'package:loby/data/models/profile/user_model.dart';
import 'package:loby/domain/entities/response_entities/profile/user_response.dart';


class UserResponseModel extends UserResponse {

  final UserModel user;

  const UserResponseModel({
    required this.user,
  }) : super(user: user);

  @override
  List<Object> get props => [user];

  factory UserResponseModel.fromJSON(Map<String, dynamic> json) =>
      UserResponseModel(
        user: UserModel.fromJson(json['data'])
      );
}
