
import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/auth/country.dart';
import 'package:loby/domain/entities/response_entities/auth/city_response.dart';
import 'package:loby/domain/entities/response_entities/auth/country_response.dart';
import 'package:loby/domain/entities/response_entities/auth/state_response.dart';
import 'package:loby/domain/repositories/auth_repository.dart';

class UpdateProfile extends UseCase<bool, Params> {
  final AuthRepository _repository;

  UpdateProfile(this._repository);

  @override
  Future<Either<Failure, bool>> call(Params params) {

    return _repository.updateProfile(
      avatar: params.authParams?.avatar,
      fullName: params.authParams?.fullName,
      displayName: params.authParams?.displayName,
      countryId: params.authParams?.countryId,
      cityId: params.authParams?.cityId,
      stateId: params.authParams?.stateId,
      DOB: params.authParams?.DOB,
      profileTags: params.authParams?.profileTags,
      bio: params.authParams?.bio,
    );
  }
}
