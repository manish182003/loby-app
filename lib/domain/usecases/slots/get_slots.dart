import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/slots/get_slots_for_seller_response.dart';
import 'package:loby/domain/repositories/slots_repository.dart';
import 'package:loby/core/usecases/slots_params.dart';

class GetSlots extends UseCase<GetSlotsForSellerResponse, Params> {
  final SlotsRepository _repository;

  GetSlots(this._repository);

  @override
  Future<Either<Failure, GetSlotsForSellerResponse>> call(Params params) {
    return _repository.getSlots(
      day: params.slotsParams?.day,
      // slotId: params.slotsParams?.slotId,
      providerId: params.slotsParams?.providerId,
    );
  }
}
