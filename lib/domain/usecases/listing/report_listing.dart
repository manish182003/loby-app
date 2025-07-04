import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/repositories/listing_repository.dart';

class ReportListing extends UseCase<Map<String, dynamic>, Params> {
  final ListingRepository _repository;

  ReportListing(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) {
    return _repository.reportListing(
      userId: params.listingParams?.userId,
      userGameServiceId: params.listingParams?.userGameServiceId,
    );
  }
}
