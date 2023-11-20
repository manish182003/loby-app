import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/slots/delete_slot.dart';
import 'package:loby/domain/entities/response_entities/slots/get_slots_for_seller_response.dart';
import 'package:loby/domain/repositories/slots_repository.dart';
import 'package:loby/core/usecases/slots_params.dart';

class DeleteSlots extends UseCase<Map<String,dynamic>, Params> {
  final SlotsRepository _repository;

  DeleteSlots(this._repository);

  @override
  Future<Either<Failure, Map<String,dynamic>>> call(Params params) {
    print('DeleteSlots extends UseCase<DeleteSlotResponse, Params> => ${params.slotsParams?.slotId}');
    return _repository.deleteSlot(slotId: params.deleteSlotsParams?.slotId);
  }
}
