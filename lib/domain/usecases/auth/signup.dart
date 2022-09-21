import 'package:dartz/dartz.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/repositories/auth_repository.dart';


import '../../../core/usecases/usecase.dart';


class Signup extends UseCase<Map<String, dynamic>, Params> {

  final AuthRepository _repository;
  Signup(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) {
    return _repository.signup(
      name: params.authParams?.name,
      email: params.authParams?.email,
      password: params.authParams?.password,
      confirmPassword: params.authParams?.confirmPassword,
    );
  }
}
