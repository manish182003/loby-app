// ignore_for_file: overridden_fields, annotate_overrides
import 'package:loby/data/models/listing/service_listing_model.dart';
import 'package:loby/data/models/order/order_model.dart';
import 'package:loby/data/models/profile/user_model.dart';
// import 'package:loby/domain/entities/listing/service_listing.dart';
import 'package:loby/domain/entities/profile/duel_details.dart';


class DuelDetailsModel extends DuelDetails{
  const DuelDetailsModel({
    this.id,
    this.userOrderId,
    this.winnerSelectedBuyer,
    this.winnerSelectedSeller,
    this.userGameServiceId,
    this.disputeWinner,
    this.createdAt,
    this.updatedAt,
    this.winner,
    this.loser,
    this.userOrder,
    this.userGameService,
  });

  final int? id;
  final int? userOrderId;
  final int? winnerSelectedBuyer;
  final int? winnerSelectedSeller;
  final int? userGameServiceId;
  final int? disputeWinner;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final UserModel? winner;
  final UserModel? loser;
  final OrderModel? userOrder;
  final ServiceListingModel? userGameService;

factory DuelDetailsModel.fromJson(Map<String, dynamic> json) => DuelDetailsModel(
  id: json["id"],
  userOrderId: json["user_order_id"],
  winnerSelectedBuyer: json["winner_selected_buyer"],
  winnerSelectedSeller: json["winner_selected_seller"],
  userGameServiceId: json["user_game_service_id"],
  disputeWinner: json["dispute_winner"],
  createdAt: DateTime.parse(json["createdAt"]),
  updatedAt: DateTime.parse(json["updatedAt"]),
  winner: json["dispute_winner"] != 0 ? json["dispute_winner"] == json["userOrder"]["user"]["id"] ? UserModel.fromJson(json["userOrder"]["user"]) : UserModel.fromJson(json["userGameService"]["user"]) : json["winner_selected_buyer"] == json["userOrder"]["user"]["id"] ? UserModel.fromJson(json["userOrder"]["user"]) : UserModel.fromJson(json["userGameService"]["user"]),
  loser: json["dispute_winner"] != 0 ? json["dispute_winner"] == json["userOrder"]["user"]["id"] ? UserModel.fromJson(json["userGameService"]["user"]) : UserModel.fromJson(json["userOrder"]["user"])  : json["winner_selected_buyer"] == json["userOrder"]["user"]["id"] ? UserModel.fromJson(json["userGameService"]["user"]) : UserModel.fromJson(json["userOrder"]["user"]),
  userOrder: OrderModel.fromJson(json["userOrder"]),
  userGameService: ServiceListingModel.fromJson(json["userGameService"]),
);

Map<String, dynamic> toJson() => {
  "id": id,
  "user_order_id": userOrderId,
  "winner_selected_buyer": winnerSelectedBuyer,
  "winner_selected_seller": winnerSelectedSeller,
  "user_game_service_id": userGameServiceId,
  "createdAt": createdAt?.toIso8601String(),
  "updatedAt": updatedAt?.toIso8601String(),
  "userOrder": userOrder?.toJson(),
  "userGameService": userGameService?.toJson(),
};
}
