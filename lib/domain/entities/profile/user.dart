import 'package:equatable/equatable.dart';

class User extends Equatable{
  const User({
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


  @override
  // TODO: implement props
  List<Object?> get props => [id, name, email, image];
}