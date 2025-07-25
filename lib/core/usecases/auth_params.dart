// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:equatable/equatable.dart';

class AuthParams extends Equatable {
  final String? name;
  final String? email;
  final String? password;
  final String? confirmPassword;
  final String? search;
  final int? page;
  final int? uid;
  final String? type;
  final File? avatar;
  final File? cover;
  final String? fullName;
  final String? displayName;
  final int? countryId;
  final int? stateId;
  final int? cityId;
  final String? DOB;
  final List<Map<String, dynamic>>? profileTags;
  final String? bio;
  final String? socialLoginId;
  final int? socialLoginType;
  final String? fcmToken;
  final String? otp;
  final String? mobile;

  const AuthParams(
      {this.cover,
      this.name,
      this.email,
      this.password,
      this.confirmPassword,
      this.search,
      this.page,
      this.type,
      this.uid,
      this.countryId,
      this.stateId,
      this.cityId,
      this.socialLoginId,
      this.socialLoginType,
      this.avatar,
      this.fullName,
      this.displayName,
      this.profileTags,
      this.bio,
      this.DOB,
      this.fcmToken,
      this.otp,
      this.mobile});

  @override
  List<Object> get props => [];
}
