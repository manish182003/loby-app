
import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/repositories/order_repository.dart';

class ChangeOrderStatus extends UseCase<Map<String, dynamic>, Params> {
  final OrderRepository _repository;

  ChangeOrderStatus(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) {
    return _repository.changeOrderStatus(
      orderId: params.orderParams?.orderId,
      status: params.orderParams?.status,
    );
  }
}
