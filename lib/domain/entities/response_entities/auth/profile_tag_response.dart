import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:loby/domain/entities/auth/city.dart';
import 'package:loby/domain/entities/auth/country.dart';
import 'package:loby/domain/entities/auth/profile_tag.dart';



class ProfileTagResponse extends Equatable {
  final List<ProfileTag> profileTags;

  const ProfileTagResponse({
    required this.profileTags,
  });

  @override
  List<Object> get props => [profileTags];
}
