
import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/home/static_data_response.dart';
import 'package:loby/domain/repositories/home_repository.dart';

class GetStaticData extends UseCase<StaticDataResponse, Params> {
  final HomeRepository _repository;

  GetStaticData(this._repository);

  @override
  Future<Either<Failure, StaticDataResponse>> call(Params params) {
    return _repository.getStaticData();
  }
}
