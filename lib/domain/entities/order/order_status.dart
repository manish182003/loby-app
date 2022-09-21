import 'package:equatable/equatable.dart';

class OrderStatus extends Equatable{
  const OrderStatus({
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



  @override
  // TODO: implement props
  List<Object?> get props => [id, userOrderId, status];
}