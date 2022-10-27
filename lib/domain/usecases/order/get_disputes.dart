
import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/order/dispute_response.dart';

import '../../repositories/order_repository.dart';

class GetDisputes extends UseCase<DisputeResponse, Params> {
  final OrderRepository _repository;

  GetDisputes(this._repository);

  @override
  Future<Either<Failure, DisputeResponse>> call(Params params) {
    return _repository.getDisputes(
      page: params.orderParams?.page,
      status: params.orderParams?.status,
    );
  }
}
