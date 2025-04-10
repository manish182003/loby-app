import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/home/faqs_response.dart';
import 'package:loby/domain/repositories/home_repository.dart';

class GetAllFaqs extends UseCase<FaqsResponse, Params> {
  final HomeRepository _repository;

  GetAllFaqs({required HomeRepository repository}) : _repository = repository;
  @override
  Future<Either<Failure, FaqsResponse>> call(Params params) {
    return _repository.getAllFaqsData();
  }
}
