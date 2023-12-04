import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/kyc/get_kyc_token.dart';

abstract class KycRepository {
  Future<Either<Failure, Map<String, dynamic>>> getKycToken(
      {String? kycToken});

  Future<Either<Failure, bool>> sendKycOtp({String? kycToken, String? aadharNumber, String? type});

  Future<Either<Failure, Map<String, dynamic>>> verifyKycOtp({String? kycToken, String? otp, String? refId, String? aadharNum});

}