// ignore_for_file: overridden_fields, annotate_overrides
import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/profile/payment_transaction.dart';

class PaymentTransactionModel extends PaymentTransaction{
  const PaymentTransactionModel({
    this.id,
    this.userId,
    this.orderId,
    this.tnxId,
    this.paymentJsonResponse,
    this.paymentJsonRequest,
    this.orderJsonResponse,
    this.totalAmount,
    this.currency,
    this.walletTransactionId,
    this.paymentStatus,
    this.cronUpdate,
    this.cronUpdatedTime,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? userId;
  final String? orderId;
  final String? tnxId;
  final String? paymentJsonResponse;
  final String? paymentJsonRequest;
  final String? orderJsonResponse;
  final int? totalAmount;
  final String? currency;
  final int? walletTransactionId;
  final String? paymentStatus;
  final String? cronUpdate;
  final DateTime? cronUpdatedTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory PaymentTransactionModel.fromJson(Map<String, dynamic> json) => PaymentTransactionModel(
    id: json["id"],
    userId: json["user_id"],
    orderId: json["order_id"],
    tnxId: json["tnx_id"],
    paymentJsonResponse: json["payment_json_response"],
    paymentJsonRequest: json["payment_json_request"],
    orderJsonResponse: json["order_json_response"],
    totalAmount: json["total_amount"],
    currency: json["currency"],
    walletTransactionId: json["wallet_transaction_id"],
    paymentStatus: json["payment_status"],
    cronUpdate: json["cron_update"],
    cronUpdatedTime: json["cron_updated_time"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "order_id": orderId,
    "tnx_id": tnxId,
    "payment_json_response": paymentJsonResponse,
    "payment_json_request": paymentJsonRequest,
    "order_json_response": orderJsonResponse,
    "total_amount": totalAmount,
    "currency": currency,
    "wallet_transaction_id": walletTransactionId,
    "payment_status": paymentStatus,
    "cron_update": cronUpdate,
    "cron_updated_time": cronUpdatedTime,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [id, userId, tnxId, totalAmount, paymentStatus];
}
