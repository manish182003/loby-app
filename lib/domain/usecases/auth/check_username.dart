import 'package:dartz/dartz.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/repositories/auth_repository.dart';


import '../../../core/usecases/usecase.dart';


class CheckUsername extends UseCase<String, Params> {

  final AuthRepository _repository;
  CheckUsername(this._repository);

  @override
  Future<Either<Failure, String>> call(Params params) {
    return _repository.checkUsername(
      username: params.authParams?.displayName,
    );
  }
}
