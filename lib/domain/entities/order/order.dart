import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/listing/service_listing.dart';
import 'package:loby/domain/entities/profile/user.dart';
import 'order_status.dart';

class Order extends Equatable{
  const Order({
    this.id,
    this.userGameServiceId,
    this.userId,
    this.disputeId,
    this.quantity,
    this.price,
    this.cronUpdatedTime,
    this.paymentSettlement,
    this.transactionFreeze,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.userGameService,
    this.orderStatuses,
  });

  final int? id;
  final int? userGameServiceId;
  final int? userId;
  final int? disputeId;
  final int? quantity;
  final int? price;
  final DateTime? cronUpdatedTime;
  final String? paymentSettlement;
  final String? transactionFreeze;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? user;
  final ServiceListing? userGameService;
  final List<OrderStatus>? orderStatuses;



  @override
  // TODO: implement props
  List<Object?> get props => [id, userGameServiceId, userId, disputeId, quantity];
}