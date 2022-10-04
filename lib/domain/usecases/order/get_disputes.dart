
import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/auth/country.dart';
import 'package:loby/domain/entities/response_entities/auth/country_response.dart';
import 'package:loby/domain/entities/response_entities/home/category_response.dart';
import 'package:loby/domain/entities/response_entities/order/dispute_response.dart';
import 'package:loby/domain/entities/response_entities/order/order_response.dart';
import 'package:loby/domain/repositories/auth_repository.dart';
import 'package:loby/domain/repositories/home_repository.dart';

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
