
import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/auth/country.dart';
import 'package:loby/domain/entities/response_entities/auth/country_response.dart';
import 'package:loby/domain/entities/response_entities/home/category_response.dart';
import 'package:loby/domain/repositories/auth_repository.dart';
import 'package:loby/domain/repositories/home_repository.dart';

class GetCategories extends UseCase<CategoryResponse, Params> {
  final HomeRepository _repository;

  GetCategories(this._repository);

  @override
  Future<Either<Failure, CategoryResponse>> call(Params params) {


    return _repository.getCategories(
      name: params.homeParams?.name,
      page: params.homeParams?.page,
      categoryId: params.homeParams?.categoryId,
    );
  }
}
