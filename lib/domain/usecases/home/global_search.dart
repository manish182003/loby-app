
import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/home/global_search_response.dart';
import 'package:loby/domain/repositories/home_repository.dart';

class GlobalSearch extends UseCase<GlobalSearchResponse, Params> {
  final HomeRepository _repository;

  GlobalSearch(this._repository);

  @override
  Future<Either<Failure, GlobalSearchResponse>> call(Params params) {
    return _repository.globalSearch(
      search: params.homeParams?.search,
    );
  }
}
