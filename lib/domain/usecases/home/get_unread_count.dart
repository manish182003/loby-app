
import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/repositories/home_repository.dart';

class GetUnreadCount extends UseCase<int, Params> {
  final HomeRepository _repository;

  GetUnreadCount(this._repository);

  @override
  Future<Either<Failure, int>> call(Params params) {
    return _repository.getUnreadCount(
      type: params.homeParams?.type,
    );
  }
}
