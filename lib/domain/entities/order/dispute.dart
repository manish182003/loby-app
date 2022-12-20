import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/profile/user.dart';

import 'dispute_proof.dart';
import 'order.dart';

class Dispute extends Equatable{
  const Dispute({
    this.id,
    this.userId,
    this.userOrderId,
    this.description,
    this.result,
    this.commissionPercent,
    this.disputeWinner,
    this.amount,
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
  final String? disputeWinner;
  final int? amount;
  final String? disputeNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Order? userOrder;
  final User? user;
  final List<DisputeProof>? disputeProofs;


  @override
  // TODO: implement props
  List<Object?> get props => [id, userId];
}
