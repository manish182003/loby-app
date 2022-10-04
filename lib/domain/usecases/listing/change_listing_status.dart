import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/listing/service_listing_response.dart';
import 'package:loby/domain/entities/response_entities/profile/rating_response.dart';
import 'package:loby/domain/entities/response_entities/profile/user_response.dart';
import 'package:loby/domain/repositories/listing_repository.dart';
import 'package:loby/domain/repositories/profile_repository.dart';

class ChangeListingStatus extends UseCase<Map<String, dynamic>, Params> {
  final ListingRepository _repository;

  ChangeListingStatus(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) {
    return _repository.changeListingStatus(
      listingId: params.listingParams?.listingId,
      type: params.listingParams?.type,
    );
  }
}
