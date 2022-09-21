// ignore_for_file: overridden_fields, annotate_overrides

import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/orders/order_status.dart';

class OrderStatusModel extends OrderStatus{
  const OrderStatusModel({
    this.id,
    this.userOrderId,
    this.status,
    this.showBuyer,
    this.show,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? userOrderId;
  final String? status;
  final bool? showBuyer;
  final bool? show;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) => OrderStatusModel(
    id: json["id"],
    userOrderId: json["user_order_id"],
    status: json["status"],
    showBuyer: json["show_buyer"],
    show: json["show"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_order_id": userOrderId,
    "status": status,
    "show_buyer": showBuyer,
    "show": show,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [id, userOrderId, status];
}