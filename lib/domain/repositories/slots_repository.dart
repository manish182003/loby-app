import 'package:dartz/dartz.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/slots/get_slots_for_buyer.dart';
import 'package:loby/domain/entities/response_entities/slots/get_slots_for_seller_response.dart';

abstract class SlotsRepository {
  Future<Either<Failure, Map<String, dynamic>>> addSlot(
      {int? day, String? from, String? to});

  Future<Either<Failure, GetSlotsForSellerResponse>> getSlots(
      {int? day, int? providerId});

  Future<Either<Failure, GetSlotsForBuyerResponse>> getBuyerSlots(
      {String? date, int? providerId});

  Future<Either<Failure, Map<String, dynamic>>> deleteSlot({int? slotId});

  Future<Either<Failure, Map<String, dynamic>>> updateSlot(
      {String? date, int? slotId, int? orderId});

  Future<Either<Failure, String>> addSlotsForWeekend(int dayId);
}

// abstract class SlotsRepository {
//   Future<Either<Failure, Map<String, dynamic>>> addSlots(
//       {int? sellerId, int? slotId, int? day, String? from, String? to});
// }
