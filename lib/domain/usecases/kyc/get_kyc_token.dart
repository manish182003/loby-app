import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/kyc/get_kyc_token.dart';
import 'package:loby/domain/repositories/kyc_repository.dart';

class GetKycToken extends UseCase<Map<String, dynamic>, Params> {
  final KycRepository _repository;

  GetKycToken(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) {
    return _repository.getKycToken(
      kycToken: params.kycTokenParams?.kycToken
    );
  }

  
}