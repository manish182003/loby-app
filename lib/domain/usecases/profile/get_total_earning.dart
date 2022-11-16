import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/profile/wallet_transaction_response.dart';
import 'package:loby/domain/repositories/profile_repository.dart';

class GetTotalEarning extends UseCase<double, Params> {
  final ProfileRepository _repository;

  GetTotalEarning(this._repository);

  @override
  Future<Either<Failure, double>> call(Params params) {
    return _repository.getTotalEarning();
  }
}
