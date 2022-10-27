
import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/repositories/home_repository.dart';

import '../../entities/response_entities/home/category_games_response.dart';

class GetCategoryGames extends UseCase<CategoryGamesResponse, Params> {
  final HomeRepository _repository;

  GetCategoryGames(this._repository);

  @override
  Future<Either<Failure, CategoryGamesResponse>> call(Params params) {


    return _repository.getCategoryGames(
      categoryId: params.homeParams?.categoryId,
      search: params.homeParams?.search,
    );
  }
}
