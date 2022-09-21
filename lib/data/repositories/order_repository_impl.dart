import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:loby/core/utils/exceptions.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/data/datasources/home_remote_datasource.dart';
import 'package:loby/data/datasources/order_remote_datasource.dart';
import 'package:loby/domain/entities/response_entities/home/category_games_response.dart';
import 'package:loby/domain/entities/response_entities/home/category_response.dart';
import 'package:loby/domain/entities/response_entities/home/game_response.dart';
import 'package:loby/domain/entities/response_entities/home/notification_response.dart';
import 'package:loby/domain/entities/response_entities/order/order_response.dart';
import 'package:loby/domain/repositories/home_repository.dart';

import '../../domain/entities/response_entities/order/order_response.dart';
import '../../domain/repositories/order_repository.dart';

class OrderRepositoryImpl extends OrderRepository{

  final OrderRemoteDatasource _orderRemoteDatasource;

  OrderRepositoryImpl(this._orderRemoteDatasource);


  @override
  Future<Either<Failure, Map<String, dynamic>>> createOrder({int? listingId, int? quantity, String? price}) async{
    try {
      return Right(await _orderRemoteDatasource.createOrder(listingId, quantity, price));
    } on ServerException catch (e) {
      // Loggers can be added here for analyzation.
      return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, OrderResponse>> getOrders({int? orderId, String? status})async {
    try {
      return Right(await _orderRemoteDatasource.getOrders(orderId, status));
    } on ServerException catch (e) {
      // Loggers can be added here for analyzation.
      return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> changeOrderStatus({int? orderId, String? status})async{
    try {
      return Right(await _orderRemoteDatasource.changeOrderStatus(orderId, status));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> uploadDeliveryProof({int? orderId, List<int>? fileType, List<File>? file}) async{
    try {
      return Right(await _orderRemoteDatasource.uploadDeliveryProof(orderId, fileType, file));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> submitRating({int? orderId, double? stars, String? review})async {
    try {
      return Right(await _orderRemoteDatasource.submitRating(orderId, stars, review));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> selectDuelWinner({int? winnerId, int? orderId})async {
    try {
      return Right(await _orderRemoteDatasource.selectDuelWinner(winnerId, orderId));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }


}