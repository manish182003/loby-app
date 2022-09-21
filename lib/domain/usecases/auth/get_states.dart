
import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/auth/country.dart';
import 'package:loby/domain/entities/response_entities/auth/country_response.dart';
import 'package:loby/domain/entities/response_entities/auth/state_response.dart';
import 'package:loby/domain/repositories/auth_repository.dart';

class GetStates extends UseCase<StateResponse, Params> {
  final AuthRepository _repository;

  GetStates(this._repository);

  @override
  Future<Either<Failure, StateResponse>> call(Params params) {


    return _repository.getStates(
      search: params.authParams?.search,
      countryId: params.authParams?.countryId,
      stateId: params.authParams?.stateId,
      page: params.authParams?.page,
    );
  }
}
