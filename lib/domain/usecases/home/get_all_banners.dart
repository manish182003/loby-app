import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/home/banner_response.dart';
import 'package:loby/domain/repositories/home_repository.dart';

class GetAllBanners extends UseCase<BannerResponse, Params> {
  final HomeRepository _repository;

  GetAllBanners(this._repository);
  @override
  Future<Either<Failure, BannerResponse>> call(Params params) {
    return _repository.getAllBannersData();
  }
}
