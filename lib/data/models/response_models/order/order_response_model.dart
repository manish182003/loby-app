import 'package:loby/data/models/order/order_model.dart';
import 'package:loby/domain/entities/response_entities/order/order_response.dart';

// ignore_for_file: overridden_fields, annotate_overrides


class OrderResponseModel extends OrderResponse {

  final List<OrderModel> orders;

  const OrderResponseModel({
    required this.orders,
  }) : super(orders: orders);

  @override
  List<Object> get props => [orders];

  factory OrderResponseModel.fromJSON(Map<String, dynamic> json) =>
      OrderResponseModel(
        orders: (json['data']['rows'] as List<dynamic>)
            .map<OrderModel>((order) => OrderModel.fromJson(order))
            .toList(),
      );
}
