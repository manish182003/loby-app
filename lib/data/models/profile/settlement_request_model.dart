// ignore_for_file: overridden_fields, annotate_overrides
// import 'package:equatable/equatable.dart';

import '../../../domain/entities/profile/settlement_request.dart';

class SettlementRequestModel extends SettlementRequest {
  const SettlementRequestModel({
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

  factory SettlementRequestModel.fromJson(Map<String, dynamic> json) =>
      SettlementRequestModel(
        id: json["id"],
        userId: json["user_id"],
        amount: json["amount"] == null
            ? 0.0
            : double.tryParse(json["amount"].toString()),
        token: json["token"].toString(),
        bankDetailId: json["bank_detail_id"],
        status: json["status"],
        payoutId: json["payout_id"],
        time: DateTime.parse(json["time"]),
        walletTransactionId: json["wallet_transaction_id"],
        cronUpdateTime: json["cron_update_time"] == null
            ? null
            : DateTime.parse(json["cron_update_time"]),
        cronUpdateResponse: json["cron_update_response"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "amount": amount,
        "token": token,
        "bank_detail_id": bankDetailId,
        "status": status,
        "payout_id": payoutId,
        "time": time?.toIso8601String(),
        "wallet_transaction_id": walletTransactionId,
        "cron_update_time": cronUpdateTime?.toIso8601String(),
        "cron_update_response": cronUpdateResponse,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props => [id, userId, amount, status];
}
