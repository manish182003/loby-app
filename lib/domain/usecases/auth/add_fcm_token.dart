import 'package:dartz/dartz.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/repositories/auth_repository.dart';


import '../../../core/usecases/usecase.dart';


class AddFCMToken extends UseCase<Map<String, dynamic>, Params> {

  final AuthRepository _repository;
  AddFCMToken(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) {
    return _repository.addFCMToken(
      fcmToken: params.authParams?.fcmToken,
    );
  }
}
