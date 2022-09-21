// ignore_for_file: overridden_fields, annotate_overrides


import 'package:flutter/cupertino.dart';
import 'package:loby/data/models/auth/city_model.dart';
import 'package:loby/data/models/auth/country_model.dart';
import 'package:loby/data/models/auth/profile_tag_model.dart';
import 'package:loby/domain/entities/auth/city.dart';
import 'package:loby/domain/entities/auth/country.dart';
import 'package:loby/domain/entities/auth/profile_tag.dart';
import 'package:loby/domain/entities/response_entities/auth/city_response.dart';
import 'package:loby/domain/entities/response_entities/auth/country_response.dart';
import 'package:loby/domain/entities/response_entities/auth/profile_tag_response.dart';


class ProfileTagResponseModel extends ProfileTagResponse {

  final List<ProfileTag> profileTags;

  const ProfileTagResponseModel({
    required this.profileTags,
  }) : super(profileTags: profileTags);

  @override
  List<Object> get props => [profileTags];

  factory ProfileTagResponseModel.fromJSON(Map<String, dynamic> json) =>
      ProfileTagResponseModel(
        profileTags: (json['data'] as List<dynamic>)
            .map<ProfileTagModel>((profileTags) => ProfileTagModel.fromJson(profileTags))
            .toList(),
      );
}
