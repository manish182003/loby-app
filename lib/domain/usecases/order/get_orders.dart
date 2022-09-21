
import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/auth/country.dart';
import 'package:loby/domain/entities/response_entities/auth/country_response.dart';
import 'package:loby/domain/entities/response_entities/home/category_response.dart';
import 'package:loby/domain/entities/response_entities/orders/order_response.dart';
import 'package:loby/domain/repositories/auth_repository.dart';
import 'package:loby/domain/repositories/home_repository.dart';

class GetOrders extends UseCase<OrderResponse, Params> {
  final HomeRepository _repository;

  GetOrders(this._repository);

  @override
  Future<Either<Failure, OrderResponse>> call(Params params) {
    return _repository.getOrders(
      orderId: params.homeParams?.orderId,
      status: params.homeParams?.status,
    );
  }
}
