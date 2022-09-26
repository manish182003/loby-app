// ignore_for_file: overridden_fields, annotate_overrides
import 'package:equatable/equatable.dart';
import 'package:loby/data/models/profile/user_model.dart';
import 'package:loby/domain/entities/profile/bank_detail.dart';
import 'package:loby/domain/entities/response_entities/profile/follower_response.dart';

import '../../../../data/models/User.dart';



class FollowerResponseModel extends FollowerResponse {
  final int id;
  final String name;
  final String displayName;
  final List<UserModel> followers;

  const FollowerResponseModel({
    required this.id,
    required this.name,
    required this.displayName,
    required this.followers,
  }) : super(id: id, name: name,displayName: displayName,followers: followers);

  @override
  List<Object> get props => [id, name, displayName, followers];

  factory FollowerResponseModel.fromJSON(Map<String, dynamic> json) =>
      FollowerResponseModel(
        id: json['data']['id'],
        name: json['data']['name'],
        displayName: json['data']['display_name'],
        followers: (json['data']['followTo'] as List<dynamic>)
            .map<UserModel>((follower) => UserModel.fromJson(follower))
            .toList(),
      );
}
