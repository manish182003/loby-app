
import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/repositories/order_repository.dart';

class SubmitDisputeProof extends UseCase<Map<String, dynamic>, Params> {
  final OrderRepository _repository;

  SubmitDisputeProof(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) {
    return _repository.submitDisputeProof(
        disputeId: params.orderParams?.disputeId,
        description: params.orderParams?.description,
      files: params.orderParams?.files,
      fileTypes: params.orderParams?.fileTypes,
      link: params.orderParams?.link,

    );
  }
}
