import 'package:dartz/dartz.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/repositories/auth_repository.dart';


import '../../../core/usecases/usecase.dart';


class SendAndVerifyOTP extends UseCase<Map<String, dynamic>, Params> {

  final AuthRepository _repository;
  SendAndVerifyOTP(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) {
    return _repository.sendAndVerifyOTP(
      mobile: params.authParams?.mobile,
      otp: params.authParams?.otp,
    );
  }
}
