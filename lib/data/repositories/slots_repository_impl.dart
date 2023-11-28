import 'package:dartz/dartz.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:loby/core/utils/exceptions.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/data/datasources/slots_remote_datasource.dart';
import 'package:loby/data/models/response_models/slots/get_buyer_slots_response.dart';
import 'package:loby/domain/entities/response_entities/slots/delete_slot.dart';
import 'package:loby/domain/entities/response_entities/slots/get_slots_for_buyer.dart';
import 'package:loby/domain/entities/response_entities/slots/get_slots_for_seller_response.dart';
import 'package:loby/domain/repositories/slots_repository.dart';

class SlotsRepositoryImpl extends SlotsRepository {
  final SlotsRemoteDatasource _slotsRemoteDatasource;
  SlotsRepositoryImpl(this._slotsRemoteDatasource);

  @override
  Future<Either<Failure, Map<String, dynamic>>> addSlot(
      {int? slotId,int? day, String? from, String? to}) async {
    try {
      return Right(await _slotsRemoteDatasource.addSlots(
          slotId,  day, from, to));
    } on ServerException catch (e) {
      // Loggers can be added here for analyzation.
      return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String,dynamic>>> deleteSlot({int? slotId}) async {
    print("deleteSlot in repo_impl => ${slotId}");
    try {
      return Right(await _slotsRemoteDatasource.deleteSlots(slotId));
    } on ServerException catch (e) {
      // Loggers can be added here for analyzation.
      return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, GetSlotsForSellerResponse>> getSlots(
      {int? day, int? providerId}) async {
    try {
      return Right(await _slotsRemoteDatasource.getSlots(day, providerId));
    } on ServerException catch (e) {
      // Loggers can be added here for analyzation.
      return Left(ServerFailure(message: e.message.toString()));
    }
  }

  // @override
  // Future<Either<Failure, OrderResponse>> getOrders({int? orderId, String? status, int? page})async {
  //   try {
  //     return Right(await _orderRemoteDatasource.getOrders(orderId, status, page));
  //   } on ServerException catch (e) {
  //     // Loggers can be added here for analyzation.
  //     return Left(ServerFailure(message: e.message.toString()));
  //   }
  // }

  @override
  Future<Either<Failure, GetSlotsForBuyerResponse>> getBuyerSlots(
      {String? date, int? providerId}) async {
    try {
      return Right(
          await _slotsRemoteDatasource.getBuyerSlots(date, providerId));
    } on ServerException catch (e) {
      // Loggers can be added here for analyzation.
      return Left(ServerFailure(message: e.message.toString()));
    }
  }
  
  @override
  Future<Either<Failure, Map<String,dynamic>>> updateSlot({String? date, int? slotId, int? orderId}) async {
    try {
      return Right(
          await _slotsRemoteDatasource.editSlots(date, orderId, slotId));
    } on ServerException catch (e) {
      // Loggers can be added here for analyzation.
      return Left(ServerFailure(message: e.message.toString()));
    }
  }
}
