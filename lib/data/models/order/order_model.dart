// ignore_for_file: overridden_fields, annotate_overrides

import 'package:equatable/equatable.dart';
import 'package:loby/data/models/listing/service_listing_model.dart';
import 'package:loby/domain/entities/listing/service_listing.dart';
import 'package:loby/domain/entities/order/order.dart';
import 'package:loby/domain/entities/order/order_status.dart';

import 'order_status_model.dart';


class OrderModel extends Order{
  const OrderModel({
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
  final dynamic transactionFreeze;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ServiceListingModel? userGameService;
  final List<OrderStatusModel>? orderStatuses;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json["id"],
    userGameServiceId: json["user_game_service_id"],
    userId: json["user_id"],
    disputeId: json["dispute_id"],
    quantity: json["quantity"],
    price: json["price"],
    cronUpdatedTime: json["cron_updated_time"] == null ? null : DateTime.parse(json["cron_updated_time"]),
    paymentSettlement: json["payment_settlement"],
    transactionFreeze: json["transaction_freeze"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    userGameService: ServiceListingModel.fromJson(json["userGameService"]),
    orderStatuses: List<OrderStatusModel>.from(json["orderStatuses"].map((x) => OrderStatusModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_game_service_id": userGameServiceId,
    "user_id": userId,
    "dispute_id": disputeId,
    "quantity": quantity,
    "price": price,
    "cron_updated_time": cronUpdatedTime,
    "payment_settlement": paymentSettlement,
    "transaction_freeze": transactionFreeze,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "userGameService": userGameService?.toJson(),
    "orderStatuses": List<dynamic>.from(orderStatuses!.map((x) => x.toJson())),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [id, userGameServiceId, userId, disputeId, quantity];
}