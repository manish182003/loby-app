// ignore_for_file: overridden_fields, annotate_overrides
import 'package:loby/data/models/home/game_model.dart';
import 'package:loby/data/models/listing/service_listing_model.dart';
import 'package:loby/data/models/profile/user_model.dart';
import 'package:loby/domain/entities/response_entities/home/global_search_response.dart';

class GlobalSearchResponseModel extends GlobalSearchResponse {
  const GlobalSearchResponseModel({
    required this.userGameServiceDetails,
    required this.userDetails,
    required this.gameDetails,
  }) : super(userGameServiceDetails: userGameServiceDetails, userDetails: userDetails, gameDetails: gameDetails);

  final List<ServiceListingModel> userGameServiceDetails;
  final List<UserModel> userDetails;
  final List<GameModel> gameDetails;

  factory GlobalSearchResponseModel.fromJson(Map<String, dynamic> json) => GlobalSearchResponseModel(
    userGameServiceDetails: (json['data']['userGameServiceDetails'] as List<dynamic>)
        .map<ServiceListingModel>((listing) => ServiceListingModel.fromJson(listing))
        .toList(),
    userDetails: (json['data']['userDetails'] as List<dynamic>)
        .map<UserModel>((user) => UserModel.fromJson(user))
        .toList(),
    gameDetails: (json['data']['gameDetails'] as List<dynamic>)
        .map<GameModel>((user) => GameModel.fromJson(user))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    "userGameServiceDetails": List<dynamic>.from(userGameServiceDetails.map((x) => x.toJson())),
    "userDetails": List<dynamic>.from(userDetails.map((x) => x)),
    "gameDetails": List<dynamic>.from(gameDetails.map((x) => x)),
  };
}