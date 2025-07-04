// ignore_for_file: implementation_imports

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:file_picker/src/platform_file.dart';
import 'package:loby/core/utils/exceptions.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/data/datasources/order_remote_datasource.dart';
import 'package:loby/domain/entities/response_entities/order/dispute_response.dart';
import 'package:loby/domain/entities/response_entities/order/order_response.dart';

import '../../domain/repositories/order_repository.dart';

class OrderRepositoryImpl extends OrderRepository{

  final OrderRemoteDatasource _orderRemoteDatasource;

  OrderRepositoryImpl(this._orderRemoteDatasource);


  @override
  Future<Either<Failure, Map<String, dynamic>>> createOrder({int? listingId, int? quantity, String? price, String? bookFromTime, String? bookToTime, String? bookDate, bool? isUpdatingTime}) async{
    try {
      return Right(await _orderRemoteDatasource.createOrder(listingId, quantity, price, bookDate, bookFromTime, bookToTime , isUpdatingTime));
      // print("orderrepo >>> ${bookDate}");
    } on ServerException catch (e) {
      // Loggers can be added here for analyzation.
      return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, OrderResponse>> getOrders({int? orderId, String? status, int? page})async {
    try {
      return Right(await _orderRemoteDatasource.getOrders(orderId, status, page));
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
  Future<Either<Failure, Map<String, dynamic>>> uploadDeliveryProof({int? orderId, List<int>? fileType, List<File>? file, String? link}) async{
    try {
      return Right(await _orderRemoteDatasource.uploadDeliveryProof(orderId, fileType, file, link));
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

  @override
  Future<Either<Failure, Map<String, dynamic>>> raiseDispute({int? orderId, String? description}) async{
    try {
      return Right(await _orderRemoteDatasource.raiseDispute(orderId, description));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, DisputeResponse>> getDisputes({int? id, int? page, String? status})async {
    try {
      return Right(await _orderRemoteDatasource.getDisputes(id, page, status));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> submitDisputeProof({int? disputeId, String? description, List<int>? fileTypes, List<PlatformFile>? files, String? link})async {
    try {
      return Right(await _orderRemoteDatasource.submitDisputeProof(disputeId, description, fileTypes, files, link));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }


}