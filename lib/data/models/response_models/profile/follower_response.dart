// ignore_for_file: overridden_fields, annotate_overrides
import 'package:equatable/equatable.dart';
import 'package:loby/data/models/profile/user_model.dart';
import 'package:loby/domain/entities/profile/bank_detail.dart';
import 'package:loby/domain/entities/response_entities/profile/follower_response.dart';

import '../../../../data/models/User.dart';



class FollowerResponseModel extends FollowerResponse {
  final List<UserModel> followers;

  const FollowerResponseModel({
    required this.followers,
  }) : super(followers: followers);

  @override
  List<Object> get props => [ followers];

  factory FollowerResponseModel.fromJSON(Map<String, dynamic> json) =>
      FollowerResponseModel(
        followers: (json['data']['rows'] as List<dynamic>)
            .map<UserModel>((follower) => UserModel.fromJson(follower))
            .toList(),
      );
}
