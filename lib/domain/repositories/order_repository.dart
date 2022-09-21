import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/listing/configuration_response.dart';
import 'package:loby/domain/entities/response_entities/listing/service_listing_response.dart';
import 'package:loby/domain/entities/response_entities/orders/order_response.dart';
import 'package:loby/domain/entities/response_entities/profile/bank_detail_response.dart';
import 'package:loby/domain/entities/response_entities/profile/duel_response.dart';
import 'package:loby/domain/entities/response_entities/profile/rating_response.dart';
import 'package:loby/domain/entities/response_entities/profile/user_response.dart';

abstract class OrdersRepository{

  Future<Either<Failure, Map<String, dynamic>>> createOrder({int? listingId, int? quantity, String? price});

  Future<Either<Failure, OrderResponse>> getOrders({int? orderId, String? status});



}



