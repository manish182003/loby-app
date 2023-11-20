import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/kyc/get_kyc_token.dart';
import 'package:loby/domain/entities/response_entities/kyc/send_kyc_otp.dart';
import 'package:loby/domain/repositories/kyc_repository.dart';

class SendKycOtp extends UseCase<bool, Params> {
  final KycRepository _repository;

  SendKycOtp(this._repository);

  @override
  Future<Either<Failure, bool>> call(Params params) {
    return _repository.sendKycOtp(
      kycToken: params.sendKycOtpParams?.kycToken,
      aadharNumber: params.sendKycOtpParams?.aadharNumber,
      type: params.sendKycOtpParams?.type
    );
  }

  
}