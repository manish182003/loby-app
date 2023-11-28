import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/repositories/slots_repository.dart';
import 'package:loby/core/usecases/slots_params.dart';


class AddSlots extends UseCase<Map<String, dynamic>, Params> {
  final SlotsRepository _repository;

  AddSlots(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) {
    return _repository.addSlot(
      // sellerId: params.slotsParams?.sellerId,
      day: params.slotsParams?.day,
      from: params.slotsParams?.from,
      to: params.slotsParams?.to,
    );
  }
}