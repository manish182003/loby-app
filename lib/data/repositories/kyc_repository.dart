import 'package:loby/core/utils/exceptions.dart';
import 'package:loby/data/datasources/key_remote_datasource.dart';
import 'package:loby/domain/entities/response_entities/kyc/get_kyc_token.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:loby/domain/repositories/kyc_repository.dart';

class KycRepositoryImpl extends KycRepository {
  final KycRemoteDatasource _kycRemoteDatasource;
  KycRepositoryImpl(this._kycRemoteDatasource);
  @override
  Future<Either<Failure, Map<String, dynamic>>> getKycToken({String? kycToken}) async {
     try {
      return Right(await _kycRemoteDatasource.getKycToken(kycToken));
    } on ServerException catch (e) {
      // Loggers can be added here for analyzation.
      return Left(ServerFailure(message: e.message.toString()));
    }
  }
  
  @override
  Future<Either<Failure, bool>> sendKycOtp({String? kycToken, String? aadharNumber, String? type}) async{
   try {
      return Right(await _kycRemoteDatasource.sendKycOtp(kycToken, aadharNumber,type));
    } on ServerException catch (e) {
      // Loggers can be added here for analyzation.
      return Left(ServerFailure(message: e.message.toString()));
    } 
  }
  
  @override
  Future<Either<Failure, Map<String, dynamic>>> verifyKycOtp({String? kycToken, String? otp, String? refId, String? aadharNum}) async {
    try {
      return Right(await _kycRemoteDatasource.verifyKycOtp(kycToken, otp, refId, aadharNum));
    } on ServerException catch (e) {
      // Loggers can be added here for analyzation.
      return Left(ServerFailure(message: e.message.toString()));
    } 
  }

}