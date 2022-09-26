import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/auth/city.dart';
import 'package:loby/domain/entities/auth/country.dart';
import 'package:loby/domain/entities/auth/profile_tag.dart';
import 'package:loby/domain/entities/auth/state.dart';

class User extends Equatable{
  const User(
      {this.id,
      this.name,
      this.email,
      this.emailVerified,
      this.mobile,
      this.mobileVerified,
      this.password,
      this.resetToken,
      this.status,
      this.image,
      this.cityId,
      this.displayName,
      this.countryId,
      this.stateId,
      this.dob,
      this.bio,
      this.walletMoney,
      this.verifiedProfile,
      this.lobbyCoins,
      this.fcmToken,
      this.socialLoginId,
      this.socialLoginType,
      this.facebookId,
      this.instagramId,
      this.youtubeId,
      this.twitchId,
      this.discordId,
      this.coverImage,
      this.createdAt,
      this.updatedAt,
      this.memberSince,
      this.followersCount,
      this.listingsCount,
      this.orderCount,
      this.avgRatingCount,
      this.commentCount,
      this.userFollowStatus,
      this.state,
      this.country,
      this.city,
      this.profileTags});

  final int? id;
  final String? name;
  final String? email;
  final String? emailVerified;
  final String? mobile;
  final String? mobileVerified;
  final String? password;
  final String? resetToken;
  final int? status;
  final String? image;
  final int? cityId;
  final String? displayName;
  final int? countryId;
  final int? stateId;
  final DateTime? dob;
  final String? bio;
  final int? walletMoney;
  final bool? verifiedProfile;
  final int? lobbyCoins;
  final String? fcmToken;
  final String? socialLoginId;
  final int? socialLoginType;
  final String? facebookId;
  final String? instagramId;
  final String? youtubeId;
  final String? twitchId;
  final String? discordId;
  final String? coverImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? memberSince;
  final int? followersCount;
  final int? listingsCount;
  final int? orderCount;
  final int? avgRatingCount;
  final int? commentCount;
  final String? userFollowStatus;
  final State? state;
  final Country? country;
  final City? city;
  final List<ProfileTag>? profileTags;


  @override
  // TODO: implement props
  List<Object?> get props => [id, name, email, image];
}