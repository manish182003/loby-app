import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/repositories/profile_repository.dart';

import '../../entities/response_entities/profile/payment_transaction_response.dart';

class GetPaymentTransactions extends UseCase<PaymentTransactionResponse, Params> {
  final ProfileRepository _repository;

  GetPaymentTransactions(this._repository);

  @override
  Future<Either<Failure, PaymentTransactionResponse>> call(Params params) {
    return _repository.getPaymentTransactions(
      page: params.profileParams?.page,
    );
  }
}
