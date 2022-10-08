import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/repositories/listing_repository.dart';

class CreateListing extends UseCase<Map<String, dynamic>, Params> {
  final ListingRepository _repository;

  CreateListing(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) {
    return _repository.createListing(
      listingId: params.listingParams?.listingId,
      categoryId: params.listingParams?.categoryId,
      gameId: params.listingParams?.gameId,
      title: params.listingParams?.title,
      description: params.listingParams?.description,
      price: params.listingParams?.price,
      stockAvl: params.listingParams?.stockAvl,
      estimateDeliveryTime: params.listingParams?.estimateDeliveryTime,
      priceUnitId: params.listingParams?.priceUnitId,
      serviceOptionId: params.listingParams?.serviceOptionId,
      files: params.listingParams?.files,
      fileTypes: params.listingParams?.fileTypes,
      optionAnswer: params.listingParams?.optionAnswer,
    );
  }
}
