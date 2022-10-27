import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/repositories/profile_repository.dart';

class WithdrawMoney extends UseCase<Map<String, dynamic>, Params> {
  final ProfileRepository _repository;
  WithdrawMoney(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) {
    return _repository.withdrawMoney(
      bankDetailId: params.profileParams?.bankDetailId,
      amount: params.profileParams?.amount,
    );
  }
}
