import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/repositories/profile_repository.dart';

class FollowUnfollow extends UseCase<Map<String, dynamic>, Params> {
  final ProfileRepository _repository;

  FollowUnfollow(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) {
    return _repository.followUnfollow(
      userId: params.profileParams?.userId,
    );
  }
}
