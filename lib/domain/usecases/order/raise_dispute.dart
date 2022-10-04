
import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/auth/country.dart';
import 'package:loby/domain/entities/response_entities/auth/country_response.dart';
import 'package:loby/domain/entities/response_entities/home/category_response.dart';
import 'package:loby/domain/repositories/auth_repository.dart';
import 'package:loby/domain/repositories/home_repository.dart';
import 'package:loby/domain/repositories/order_repository.dart';

class RaiseDispute extends UseCase<Map<String, dynamic>, Params> {
  final OrderRepository _repository;

  RaiseDispute(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) {
    return _repository.raiseDispute(
      orderId: params.orderParams?.orderId,
      description: params.orderParams?.description,
    );
  }
}
