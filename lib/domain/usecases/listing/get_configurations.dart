
import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/listing/configuration_response.dart';
import 'package:loby/domain/repositories/listing_repository.dart';

class GetConfigurations extends UseCase<ConfigurationResponse, Params> {
  final ListingRepository _repository;

  GetConfigurations(this._repository);

  @override
  Future<Either<Failure, ConfigurationResponse>> call(Params params) {
    return _repository.getConfigurations(
        categoryId: params.listingParams?.categoryId,
        gameId: params.listingParams?.gameId,
    );
  }
}
