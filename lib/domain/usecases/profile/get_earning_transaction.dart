import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/profile/wallet_transaction_response.dart';
import 'package:loby/domain/repositories/profile_repository.dart';

class GetEarningTransactions extends UseCase<WalletTransactionResponse, Params> {
  final ProfileRepository _repository;

  GetEarningTransactions(this._repository);

  @override
  Future<Either<Failure, WalletTransactionResponse>> call(Params params) {
    return _repository.getEarningTransactions(
      page: params.profileParams?.page,
      type: params.profileParams?.type,
    );
  }
}
