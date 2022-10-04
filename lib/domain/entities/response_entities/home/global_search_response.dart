import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/home/game.dart';

import 'package:loby/domain/entities/listing/service_listing.dart';
import 'package:loby/domain/entities/profile/user.dart';

class GlobalSearchResponse extends Equatable{
  const GlobalSearchResponse({
    required this.userGameServiceDetails,
    required this.userDetails,
    required this.gameDetails,
  });

  final List<ServiceListing> userGameServiceDetails;
  final List<User> userDetails;
  final List<Game> gameDetails;

  @override
  // TODO: implement props
  List<Object?> get props => [userGameServiceDetails, userDetails, gameDetails];

}