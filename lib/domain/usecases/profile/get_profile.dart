import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/listing/service_listing_response.dart';
import 'package:loby/domain/entities/response_entities/profile/user_response.dart';
import 'package:loby/domain/repositories/listing_repository.dart';
import 'package:loby/domain/repositories/profile_repository.dart';

class GetProfile extends UseCase<UserResponse, Params> {
  final ProfileRepository _repository;

  GetProfile(this._repository);

  @override
  Future<Either<Failure, UserResponse>> call(Params params) {
    return _repository.getProfile(
      userId: params.profileParams?.userId,
    );
  }
}
