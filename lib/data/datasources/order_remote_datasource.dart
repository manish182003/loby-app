import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/data/models/response_models/home/category_games_response_model.dart';
import 'package:loby/data/models/response_models/home/category_response_model.dart';
import 'package:loby/data/models/response_models/home/game_response_model.dart';
import 'package:loby/data/models/response_models/home/notification_response_model.dart';
import 'package:loby/data/models/response_models/order/order_response_model.dart';

abstract class OrderRemoteDatasource{

  Future<Map<String, dynamic>> createOrder(int? listingId, int? quantity, String? price);

  Future<OrderResponseModel> getOrders(int? orderId, String? status);

  Future<Map<String, dynamic>> changeOrderStatus(int? orderId, String? status);

  Future<Map<String, dynamic>> uploadDeliveryProof(int? orderId, List<int>? fileType ,List<File>? file);

  Future<Map<String, dynamic>> submitRating(int? orderId, double? stars, String? review);

  Future<Map<String, dynamic>> selectDuelWinner(int? winnerId, int? orderId);

}