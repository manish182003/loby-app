
import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/repositories/order_repository.dart';

class SubmitRating extends UseCase<Map<String, dynamic>, Params> {
  final OrderRepository _repository;

  SubmitRating(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) {
    return _repository.submitRating(
      orderId: params.orderParams?.orderId,
      stars: params.orderParams?.stars,
      review: params.orderParams?.review,
    );
  }
}
