
import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/auth/profile_tag_response.dart';
import 'package:loby/domain/repositories/auth_repository.dart';

class GetProfileTags extends UseCase<ProfileTagResponse, Params> {
  final AuthRepository _repository;

  GetProfileTags(this._repository);

  @override
  Future<Either<Failure, ProfileTagResponse>> call(Params params) {

    return _repository.getProfileTags(
      search: params.authParams?.search,
      page: params.authParams?.page,
    );
  }
}
