import 'package:dartz/dartz.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/repositories/auth_repository.dart';


import '../../../core/usecases/usecase.dart';


class ForgotAndResetPassword extends UseCase<Map<String, dynamic>, Params> {

  final AuthRepository _repository;
  ForgotAndResetPassword(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) {
    return _repository.forgotAndResetPassword(
      email: params.authParams?.email,
      otp: params.authParams?.otp,
      password: params.authParams?.password,
      confirmPassword: params.authParams?.confirmPassword
    );
  }
}
