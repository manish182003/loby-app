// ignore_for_file: overridden_fields, annotate_overrides
import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/profile/wallet_transaction.dart';

class WalletTransactionModel extends WalletTransaction {
  const WalletTransactionModel({
    this.id,
    this.userId,
    this.previousAmount,
    this.amount,
    this.totalAmount,
    this.type,
    this.reason,
    this.details,
    this.userOrderId,
    this.disputeId,
    this.walletSettlementId,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? userId;
  final int? previousAmount;
  final double? amount;
  final int? totalAmount;
  final String? type;
  final String? reason;
  final String? details;
  final int? userOrderId;
  final int? disputeId;
  final int? walletSettlementId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory WalletTransactionModel.fromJson(Map<String, dynamic> json) => WalletTransactionModel(
    id: json["id"],
    userId: json["user_id"],
    previousAmount: json["previous_amount"],
    amount: json["amount"].toDouble(),
    totalAmount: json["total_amount"],
    type: json["type"],
    reason: json["reason"],
    details: json["details"],
    userOrderId: json["user_order_id"],
    disputeId: json["dispute_id"],
    walletSettlementId: json["wallet_settlement_id"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "previous_amount": previousAmount,
    "amount": amount,
    "total_amount": totalAmount,
    "type": type,
    "reason": reason,
    "details": details,
    "user_order_id": userOrderId,
    "dispute_id": disputeId,
    "wallet_settlement_id": walletSettlementId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [id, userId, previousAmount, amount, previousAmount, type];
}
