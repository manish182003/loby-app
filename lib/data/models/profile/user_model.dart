import 'package:equatable/equatable.dart';
// ignore_for_file: overridden_fields, annotate_overrides

import '../../../domain/entities/profile/user.dart';

class UserModel extends User{
  const UserModel({
    this.id,
    this.name,
    this.email,
    this.image,
    this.cityId,
    this.displayName,
    this.countryId,
    this.stateId,
    this.bio,
    this.verifiedProfile,
    this.facebookId,
    this.instagramId,
    this.youtubeId,
    this.twitchId,
    this.discordId,
    this.memberSince,
    this.followersCount,
    this.listingsCount,
    this.orderCount,
    this.avgRatingCount,
    this.commentCount,
    this.userFollowStatus,
  });

  final int? id;
  final String? name;
  final String? email;
  final String? image;
  final int? cityId;
  final String? displayName;
  final int? countryId;
  final int? stateId;
  final String? bio;
  final bool? verifiedProfile;
  final int? facebookId;
  final String? instagramId;
  final String? youtubeId;
  final String? twitchId;
  final String? discordId;
  final DateTime? memberSince;
  final int? followersCount;
  final int? listingsCount;
  final int? orderCount;
  final int? avgRatingCount;
  final int? commentCount;
  final String? userFollowStatus;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    image: json["image"],
    cityId: json["city_id"],
    displayName: json["display_name"],
    countryId: json["country_id"],
    stateId: json["state_id"],
    bio: json["bio"],
    verifiedProfile: json["verified_profile"],
    facebookId: json["facebook_id"],
    instagramId: json["instagram_id"],
    youtubeId: json["youtube_id"],
    twitchId: json["twitch_id"],
    discordId: json["discord_id"],
    memberSince: DateTime.parse(json["member_since"]),
    followersCount: json["followersCount"],
    listingsCount: json["listingsCount"],
    orderCount: json["orderCount"],
    avgRatingCount: json["avg_rating_count"],
    commentCount: json["comment_count"],
    userFollowStatus: json["user_follow_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "image": image,
    "city_id": cityId,
    "display_name": displayName,
    "country_id": countryId,
    "state_id": stateId,
    "bio": bio,
    "verified_profile": verifiedProfile,
    "facebook_id": facebookId,
    "instagram_id": instagramId,
    "youtube_id": youtubeId,
    "twitch_id": twitchId,
    "discord_id": discordId,
    "member_since": memberSince?.toIso8601String(),
    "followersCount": followersCount,
    "listingsCount": listingsCount,
    "orderCount": orderCount,
    "avg_rating_count": avgRatingCount,
    "comment_count": commentCount,
    "user_follow_status": userFollowStatus,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, email, image];
}