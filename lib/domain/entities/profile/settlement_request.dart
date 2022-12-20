import 'package:equatable/equatable.dart';

class SettlementRequest extends Equatable{
  const SettlementRequest({
    this.id,
    this.userId,
    this.amount,
    this.token,
    this.bankDetailId,
    this.status,
    this.payoutId,
    this.time,
    this.walletTransactionId,
    this.cronUpdateTime,
    this.cronUpdateResponse,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? userId;
  final double? amount;
  final String? token;
  final int? bankDetailId;
  final String? status;
  final String? payoutId;
  final DateTime? time;
  final int? walletTransactionId;
  final DateTime? cronUpdateTime;
  final String? cronUpdateResponse;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => [id, userId, amount, status];
}
