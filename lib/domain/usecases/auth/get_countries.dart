
import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/auth/country.dart';
import 'package:loby/domain/entities/response_entities/auth/country_response.dart';
import 'package:loby/domain/repositories/auth_repository.dart';

class GetCountries extends UseCase<CountryResponse, Params> {
  final AuthRepository _repository;

  GetCountries(this._repository);

  @override
  Future<Either<Failure, CountryResponse>> call(Params params) {


    return _repository.getCountries(
      search: params.authParams?.search,
      page: params.authParams?.page,
    );
  }
}
