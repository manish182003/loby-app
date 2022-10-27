import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/profile/rating_response.dart';
import 'package:loby/domain/repositories/profile_repository.dart';

class GetRatings extends UseCase<RatingResponse, Params> {
  final ProfileRepository _repository;

  GetRatings(this._repository);

  @override
  Future<Either<Failure, RatingResponse>> call(Params params) {
    return _repository.getRatings(
      userId: params.profileParams?.userId,
      page: params.profileParams?.page,
    );
  }
}
