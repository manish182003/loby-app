import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/repositories/listing_repository.dart';

class DeleteListingImage extends UseCase<Map<String, dynamic>, Params> {
  final ListingRepository _repository;

  DeleteListingImage(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) {
    return _repository.deleteListingImage(
      id: params.listingParams?.imageId,
      path: params.listingParams?.imagePath,
    );
  }
}
