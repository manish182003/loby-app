import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/listing/service_listing_response.dart';
import 'package:loby/domain/entities/response_entities/profile/rating_response.dart';
import 'package:loby/domain/entities/response_entities/profile/user_response.dart';
import 'package:loby/domain/entities/response_entities/profile/wallet_transaction_response.dart';
import 'package:loby/domain/repositories/listing_repository.dart';
import 'package:loby/domain/repositories/profile_repository.dart';

class GetWalletTransactions extends UseCase<WalletTransactionResponse, Params> {
  final ProfileRepository _repository;

  GetWalletTransactions(this._repository);

  @override
  Future<Either<Failure, WalletTransactionResponse>> call(Params params) {
    return _repository.getWalletTransactions(
      page: params.profileParams?.page,
      type: params.profileParams?.type,
    );
  }
}
