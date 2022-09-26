import 'package:equatable/equatable.dart';

class WalletTransaction extends Equatable {
  const WalletTransaction({
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
  final int? amount;
  final int? totalAmount;
  final String? type;
  final String? reason;
  final String? details;
  final int? userOrderId;
  final int? disputeId;
  final int? walletSettlementId;
  final DateTime? createdAt;
  final DateTime? updatedAt;


  @override
  // TODO: implement props
  List<Object?> get props => [id, userId, previousAmount, amount, previousAmount, type];
}
