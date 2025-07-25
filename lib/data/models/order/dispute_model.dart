// ignore_for_file: overridden_fields, annotate_overrides

import 'package:loby/data/models/order/order_model.dart';
import 'package:loby/data/models/profile/user_model.dart';

import '../../../domain/entities/order/dispute.dart';
import 'dispute_proof_model.dart';

class DisputeModel extends Dispute {
  const DisputeModel({
    this.id,
    this.userId,
    this.userOrderId,
    this.description,
    this.result,
    this.commissionPercent,
    this.amount,
    this.disputeWinner,
    this.disputeNumber,
    this.createdAt,
    this.updatedAt,
    this.userOrder,
    this.user,
    this.disputeProofs,
  });

  final int? id;
  final int? userId;
  final int? userOrderId;
  final String? description;
  final String? result;
  final int? commissionPercent;
  final int? amount;
  final String? disputeWinner;
  final String? disputeNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final OrderModel? userOrder;
  final UserModel? user;
  final List<DisputeProofModel>? disputeProofs;

  factory DisputeModel.fromJson(Map<String, dynamic> json) => DisputeModel(
        id: json["id"],
        userId: json["user_id"],
        userOrderId: json["user_order_id"],
        description: json["description"],
        result: json["result"],
        commissionPercent: json["commission_percent"],
        disputeWinner: json['userOrder'] == null
            ? null
            : json['dispute_winner'] == json["userOrder"]["user"]["id"]
                ? json["userOrder"]["user"]["display_name"]
                : json['dispute_winner'] ==
                        json["userOrder"]["userGameService"]["user"]?["id"]
                    ? json["userOrder"]["userGameService"]["user"]
                        ["display_name"]
                    : "None",
        amount: json["amount"],
        disputeNumber: json["dispute_number"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        userOrder: json['userOrder'] == null
            ? null
            : OrderModel.fromJson(json["userOrder"]),
        user: json['user'] == null ? null : UserModel.fromJson(json["user"]),
        disputeProofs: json["disputeProofs"] == null
            ? null
            : List<DisputeProofModel>.from(json["disputeProofs"]
                .map((x) => DisputeProofModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_order_id": userOrderId,
        "description": description,
        "result": result,
        "commission_percent": commissionPercent,
        "amount": amount,
        "dispute_number": disputeNumber,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "userOrder": userOrder?.toJson(),
        "user": user?.toJson(),
        "disputeProofs":
            List<dynamic>.from(disputeProofs!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [id, userId];
}
