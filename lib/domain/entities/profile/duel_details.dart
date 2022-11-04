import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/listing/service_listing.dart';
import 'package:loby/domain/entities/profile/user.dart';
import '../order/order.dart';


class DuelDetails extends Equatable {
  const DuelDetails({
    this.id,
    this.userOrderId,
    this.winnerSelectedBuyer,
    this.winnerSelectedSeller,
    this.userGameServiceId,
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
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? winner;
  final User? loser;
  final Order? userOrder;
  final ServiceListing? userGameService;

  @override
  // TODO: implement props
  List<Object?> get props => [id, winner, loser];

}
