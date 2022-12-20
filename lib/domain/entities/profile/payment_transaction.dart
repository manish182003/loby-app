import 'package:equatable/equatable.dart';

class PaymentTransaction extends Equatable{
  const PaymentTransaction({
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
  final double? totalAmount;
  final String? currency;
  final int? walletTransactionId;
  final String? paymentStatus;
  final String? cronUpdate;
  final DateTime? cronUpdatedTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;


  @override
  // TODO: implement props
  List<Object?> get props => [id, userId, tnxId, totalAmount, paymentStatus];
}
