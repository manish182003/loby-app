


import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/order/order.dart';


class OrderResponse extends Equatable {

  final List<Order> orders;

  const OrderResponse({
    required this.orders,
  });

  @override
  List<Object> get props => [orders];
}
