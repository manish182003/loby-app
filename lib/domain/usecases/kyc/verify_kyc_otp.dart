import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/kyc/get_kyc_token.dart';
import 'package:loby/domain/entities/response_entities/kyc/send_kyc_otp.dart';
import 'package:loby/domain/repositories/kyc_repository.dart';

class VerifyKycOtp extends UseCase<Map<String, dynamic>, Params> {
  final KycRepository _repository;

  VerifyKycOtp(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) {
    return _repository.verifyKycOtp(
      kycToken: params.verifyKycOtpParams?.kycToken,
      otp: params.verifyKycOtpParams?.otp,
      refId: params.verifyKycOtpParams?.refId
      // aadharNumber: params.sendKycOtpParams?.aadharNumber,
      // type: params.sendKycOtpParams?.type
    );
  }

  
}