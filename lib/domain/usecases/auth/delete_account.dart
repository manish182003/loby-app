import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/repositories/auth_repository.dart';

class DeleteAccount extends UseCase<Map<String, dynamic>, Params> {
  final AuthRepository _repository;

  DeleteAccount({required AuthRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) {
    return _repository.deleteAccount(params.authParams!.uid!);
  }
}
