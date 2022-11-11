import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:loby/core/utils/exceptions.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/data/datasources/profile_remote_datasource.dart';
import 'package:loby/domain/entities/response_entities/profile/bank_detail_response.dart';
import 'package:loby/domain/entities/response_entities/profile/duel_response.dart';
import 'package:loby/domain/entities/response_entities/profile/follower_response.dart';
import 'package:loby/domain/entities/response_entities/profile/payment_transaction_response.dart';
import 'package:loby/domain/entities/response_entities/profile/rating_response.dart';
import 'package:loby/domain/entities/response_entities/profile/settlement_request_response.dart';
import 'package:loby/domain/entities/response_entities/profile/user_response.dart';
import 'package:loby/domain/entities/response_entities/profile/wallet_transaction_response.dart';
import 'package:loby/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository{
  final ProfileRemoteDatasource _profileRemoteDatasource;

  ProfileRepositoryImpl(this._profileRemoteDatasource);

  @override
  Future<Either<Failure, UserResponse>> getProfile({int? userId})async {
    try {
      return Right(await _profileRemoteDatasource.getProfile(userId));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, RatingResponse>> getRatings({int? userId, int? page})async {
    try {
      return Right(await _profileRemoteDatasource.getRatings(userId, page));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, DuelResponse>> getDuel({int? userId, int? page})async {
    try {
      return Right(await _profileRemoteDatasource.getDuel(userId, page));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> addFunds({int? amount}) async{
    try {
      return Right(await _profileRemoteDatasource.addFunds(amount));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> verifyPayment({String? signature, String? paymentId, String? paymentStatus, String? orderId})async {
    try {
      return Right(await _profileRemoteDatasource.verifyPayment(signature, paymentId, paymentStatus, orderId));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> followUnfollow({int? userId}) async{
    try {
      return Right(await _profileRemoteDatasource.followUnfollow(userId));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> updateSocialLinks({String? insta, String? youtube, String? twitch, String? discord}) async{
    try {
      return Right(await _profileRemoteDatasource.updateSocialLinks(insta, youtube, twitch, discord));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> profileVerification({String? displayName, String? name, String? message, String? youtube, String? twitch, String? instagram, File? idCard, File? selfie})async {
    try {
      return Right(await _profileRemoteDatasource.profileVerification(displayName, name, message, youtube, twitch, instagram, idCard, selfie));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> addBankDetails({String? bankName, String? branchName, String? accountNumber, String? confirmAccountNumber, String? ifscCode, String? holderName, String? upiId, String? type}) async{
    try {
      return Right(await _profileRemoteDatasource.addBankDetails(bankName, branchName, accountNumber, confirmAccountNumber, ifscCode, holderName, upiId, type));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, BankDetailResponse>> getBankDetails()async {
    try {
      return Right(await _profileRemoteDatasource.getBankDetails());
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> withdrawMoney({int? bankDetailId, int? amount})async {
    try {
      return Right(await _profileRemoteDatasource.withdrawMoney(bankDetailId, amount));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, PaymentTransactionResponse>> getPaymentTransactions({int? page})async {
    try {
      return Right(await _profileRemoteDatasource.getPaymentTransactions(page));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, WalletTransactionResponse>> getWalletTransactions({int? page, String? type}) async{
    try {
      return Right(await _profileRemoteDatasource.getWalletTransactions(page, type));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, FollowerResponse>> getFollowers({int? page, String? type}) async{
    try {
      return Right(await _profileRemoteDatasource.getFollowers(page, type));
    } on ServerException catch (e) {
      // Loggers can be added here for analyzation.
      return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> submitFeedback({String? feedback, String? email})async {
    try {
      return Right(await _profileRemoteDatasource.submitFeedback(feedback, email));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, SettlementRequestResponse>> getSettlementRequests({int? page, String? type})async {
    try {
      return Right(await _profileRemoteDatasource.getSettlementRequests(page, type));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }



}