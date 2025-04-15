import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/repositories/slots_repository.dart';

class CopyToAlldaysSlots extends UseCase<String, Params> {
  final SlotsRepository _repository;

  CopyToAlldaysSlots({required SlotsRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, String>> call(Params params) async {
    return await _repository.addSlotsForWeekend(params.slotsParams?.day ?? 0);
  }
}
