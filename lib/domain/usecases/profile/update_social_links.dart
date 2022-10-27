import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/repositories/profile_repository.dart';

class UpdateSocialLinks extends UseCase<Map<String, dynamic>, Params> {
  final ProfileRepository _repository;

  UpdateSocialLinks(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) {
    return _repository.updateSocialLinks(
      insta: params.profileParams?.insta,
      youtube: params.profileParams?.youtube,
      twitch: params.profileParams?.twitch,
      discord: params.profileParams?.discord,
    );
  }
}
