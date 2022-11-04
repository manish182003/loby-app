// ignore_for_file: prefer_null_aware_operators

import 'package:loby/core/utils/helpers.dart';
import 'package:loby/data/models/auth/city_model.dart';
import 'package:loby/data/models/auth/country_model.dart';
import 'package:loby/data/models/auth/profile_tag_model.dart';
import 'package:loby/data/models/auth/state_model.dart';
// ignore_for_file: overridden_fields, annotate_overrides

import '../../../domain/entities/profile/user.dart';

class UserModel extends User{
  UserModel(
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
        this.profileTags,
        this.followStatus
      });

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
  final String? avgRatingCount;
  final int? commentCount;
  final String? userFollowStatus;
  final StateModel? state;
  final CountryModel? country;
  final CityModel? city;
  final List<ProfileTagModel>? profileTags;
  String? followStatus;


  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerified: json["email_verified"],
    mobile: json["mobile"],
    mobileVerified: json["mobile_verified"],
    password: json["password"],
    resetToken: json["reset_token"],
    status: json["status"],
    image: json["image"] == null ? null : Helpers.getImage(json["image"]),
    cityId: json["city_id"],
    displayName: json["display_name"],
    countryId: json["country_id"],
    stateId: json["state_id"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    bio: json["bio"],
    walletMoney: json["wallet_money"],
    verifiedProfile: json["verified_profile"],
    lobbyCoins: json["lobby_coins"],
    fcmToken: json["fcm_token"],
    socialLoginId: json["social_login_id"],
    socialLoginType: json["social_login_type"],
    facebookId: json["facebook_id"],
    instagramId: json["instagram_id"],
    youtubeId: json["youtube_id"],
    twitchId: json["twitch_id"],
    discordId: json["discord_id"],
    coverImage: json["cover_image"] == null ? null : Helpers.getImage(json["cover_image"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    followersCount: json["followersCount"],
    listingsCount: json["listingsCount"],
    orderCount: json["orderCount"],
    avgRatingCount: json["avg_rating_count"],
    commentCount: json["comment_count"],
    userFollowStatus: json["user_follow_status"],
    state: json["state"] == null ? null : StateModel.fromJson(json["state"]),
    country: json["country"] == null ? null : CountryModel.fromJson(json["country"]),
    city: json["city"] == null ? null : CityModel.fromJson(json["city"]),
    profileTags: json["profileTags"] == null ? null : json["profileTags"].map<ProfileTagModel>((profileTags) => ProfileTagModel.fromJson(profileTags)).toList(),
    followStatus: json["userFollowingTo"] == null ? json["userFollowers"] == null ? null : json["userFollowers"]["followStatus"] == 0 ? 'N' : 'Y' : json["userFollowingTo"]["followStatus"] == 0 ? 'N' : 'Y',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified": emailVerified,
    "mobile": mobile,
    "mobile_verified": mobileVerified,
    "password": password,
    "reset_token": resetToken,
    "status": status,
    "image": image,
    "city_id": cityId,
    "display_name": displayName,
    "country_id": countryId,
    "state_id": stateId,
    "dob": dob?.toIso8601String(),
    "bio": bio,
    "wallet_money": walletMoney,
    "verified_profile": verifiedProfile,
    "lobby_coins": lobbyCoins,
    "fcm_token": fcmToken,
    "social_login_id": socialLoginId,
    "social_login_type": socialLoginType,
    "facebook_id": facebookId,
    "instagram_id": instagramId,
    "youtube_id": youtubeId,
    "twitch_id": twitchId,
    "discord_id": discordId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "followersCount": followersCount,
    "listingsCount": listingsCount,
    "orderCount": orderCount,
    "avg_rating_count": avgRatingCount,
    "comment_count": commentCount,
    "state": state?.toJson(),
    "country": country?.toJson(),
    "city": city?.toJson(),
    "profileTags": profileTags == null ? null : List<dynamic>.from(profileTags!.map((x) => x)),
  };

  @override
  List<Object?> get props => [id, name, email, image, followStatus];
}