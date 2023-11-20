import 'package:loby/domain/entities/response_entities/kyc/get_kyc_token.dart';

abstract class KycRemoteDatasource {
  Future<Map<String, dynamic>> getKycToken(
      String? kycToken);
  Future<bool> sendKycOtp(String? kycToken, String? aadharNumber, String? type);

  Future<Map<String, dynamic>> verifyKycOtp(String? kycToken, String? otp, String? refId);
}