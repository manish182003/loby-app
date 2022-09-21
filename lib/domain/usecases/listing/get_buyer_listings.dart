import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/listing/service_listing_response.dart';
import 'package:loby/domain/repositories/listing_repository.dart';

class GetBuyerListings extends UseCase<ServiceListingResponse, Params> {
  final ListingRepository _repository;

  GetBuyerListings(this._repository);

  @override
  Future<Either<Failure, ServiceListingResponse>> call(Params params) {
    return _repository.getBuyerListings(
      categoryId: params.listingParams?.categoryId,
      gameId: params.listingParams?.gameId,
      listingId: params.listingParams?.listingId,
      userId: params.listingParams?.userId,
      page: params.listingParams?.page,
      search: params.listingParams?.search,
    );
  }
}
