import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/order/order_response.dart';

abstract class OrderRepository{

  Future<Either<Failure, Map<String, dynamic>>> createOrder({int? listingId, int? quantity, String? price});

  Future<Either<Failure, OrderResponse>> getOrders({int? orderId, String? status});

  Future<Either<Failure, Map<String, dynamic>>> changeOrderStatus({int? orderId, String? status});

  Future<Either<Failure, Map<String, dynamic>>> uploadDeliveryProof({int? orderId, List<int>? fileType, List<File>? file});

  Future<Either<Failure, Map<String, dynamic>>> submitRating({int? orderId, double? stars, String? review});

  Future<Either<Failure, Map<String, dynamic>>> selectDuelWinner({int? winnerId, int? orderId});


}



