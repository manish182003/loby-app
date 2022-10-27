import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/profile/follower_response.dart';
import 'package:loby/domain/repositories/profile_repository.dart';

class GetFollowers extends UseCase<FollowerResponse, Params> {
  final ProfileRepository _repository;

  GetFollowers(this._repository);

  @override
  Future<Either<Failure, FollowerResponse>> call(Params params) {
    return _repository.getFollowers(
      page: params.profileParams?.page,
      type: params.profileParams?.type,
    );
  }
}
