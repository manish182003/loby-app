
import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/auth/country.dart';
import 'package:loby/domain/entities/response_entities/auth/city_response.dart';
import 'package:loby/domain/entities/response_entities/auth/country_response.dart';
import 'package:loby/domain/entities/response_entities/auth/state_response.dart';
import 'package:loby/domain/repositories/auth_repository.dart';

class GetCities extends UseCase<CityResponse, Params> {
  final AuthRepository _repository;

  GetCities(this._repository);

  @override
  Future<Either<Failure, CityResponse>> call(Params params) {

    return _repository.getCities(
      search: params.authParams?.search,
      cityId: params.authParams?.cityId,
      stateId: params.authParams?.stateId,
      page: params.authParams?.page,
    );
  }
}
