import 'package:dartz/dartz.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/repositories/auth_repository.dart';


import '../../../core/usecases/usecase.dart';


class Login extends UseCase<bool, Params> {

  final AuthRepository _repository;
  Login(this._repository);

  @override
  Future<Either<Failure, bool>> call(Params params) {
    return _repository.login(
      mobile: params.authParams?.mobile,
      email: params.authParams?.email,
      password: params.authParams?.password,
      socialLoginId: params.authParams?.socialLoginId,
      socialLoginType: params.authParams?.socialLoginType,
      name: params.authParams?.name,
    );
  }
}
