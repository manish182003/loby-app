import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/slots/get_slots_for_buyer.dart';
import 'package:loby/domain/entities/response_entities/slots/get_slots_for_seller_response.dart';
import 'package:loby/domain/repositories/slots_repository.dart';
import 'package:loby/core/usecases/slots_params.dart';

class GetBuyerSlots extends UseCase<GetSlotsForBuyerResponse, Params> {
  final SlotsRepository _repository;

  GetBuyerSlots(this._repository);

  @override
  Future<Either<Failure, GetSlotsForBuyerResponse>> call(Params params) {
    return _repository.getBuyerSlots(
      date: params.buyerSlotsParams?.date,
      // slotId: params.slotsParams?.slotId,
      providerId: params.buyerSlotsParams?.providerId,
    );
  }
}