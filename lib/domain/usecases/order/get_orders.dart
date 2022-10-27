
import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/order/order_response.dart';

import '../../repositories/order_repository.dart';

class GetOrders extends UseCase<OrderResponse, Params> {
  final OrderRepository _repository;

  GetOrders(this._repository);

  @override
  Future<Either<Failure, OrderResponse>> call(Params params) {
    return _repository.getOrders(
      orderId: params.orderParams?.orderId,
      status: params.orderParams?.status,
      page: params.orderParams?.page,
    );
  }
}
