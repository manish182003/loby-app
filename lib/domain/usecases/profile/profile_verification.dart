import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/listing/service_listing_response.dart';
import 'package:loby/domain/entities/response_entities/profile/rating_response.dart';
import 'package:loby/domain/entities/response_entities/profile/user_response.dart';
import 'package:loby/domain/repositories/listing_repository.dart';
import 'package:loby/domain/repositories/profile_repository.dart';

class ProfileVerification extends UseCase<Map<String, dynamic>, Params> {
  final ProfileRepository _repository;

  ProfileVerification(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) {
    return _repository.profileVerification(
      displayName: params.profileParams?.displayName,
      name: params.profileParams?.name,
      message: params.profileParams?.message,
      instagram: params.profileParams?.insta,
      youtube: params.profileParams?.youtube,
      twitch: params.profileParams?.twitch,
      idCard: params.profileParams?.idCard,
      selfie: params.profileParams?.selfie,
    );
  }
}
