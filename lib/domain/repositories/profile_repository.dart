import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/data/models/profile/settlement_request_model.dart';
import 'package:loby/domain/entities/response_entities/profile/bank_detail_response.dart';
import 'package:loby/domain/entities/response_entities/profile/duel_response.dart';
import 'package:loby/domain/entities/response_entities/profile/rating_response.dart';
import 'package:loby/domain/entities/response_entities/profile/settlement_request_response.dart';
import 'package:loby/domain/entities/response_entities/profile/user_response.dart';

import '../entities/response_entities/profile/follower_response.dart';
import '../entities/response_entities/profile/payment_transaction_response.dart';
import '../entities/response_entities/profile/wallet_transaction_response.dart';

abstract class ProfileRepository{

  Future<Either<Failure, UserResponse>> getProfile({int? userId});

  Future<Either<Failure, RatingResponse>> getRatings({int? userId, int? page});

  Future<Either<Failure, DuelResponse>> getDuel({int? userId, int? page});

  Future<Either<Failure, Map<String, dynamic>>> addFunds({int? amount});

  Future<Either<Failure, Map<String, dynamic>>> verifyPayment({String? signature, String? paymentId, String? paymentStatus, String? orderId});

  Future<Either<Failure, Map<String, dynamic>>> followUnfollow({int? userId});

  Future<Either<Failure, Map<String, dynamic>>> updateSocialLinks({String? insta, String? youtube, String? twitch, String? discord});

  Future<Either<Failure, Map<String, dynamic>>> profileVerification({String? displayName, String? name, String? message, String? youtube, String? twitch, String? instagram, File? idCard, File? selfie});

  Future<Either<Failure, Map<String, dynamic>>> addBankDetails({
    // String? bankName, 
    // String? branchName, 
    String? accountNumber, 
    String? confirmAccountNumber, 
    String? ifscCode, 
    // String? holderName, 
    String? upiId, 
    String? type});

  Future<Either<Failure, BankDetailResponse>> getBankDetails();

  Future<Either<Failure, Map<String, dynamic>>> withdrawMoney({int? bankDetailId, int? amount});

  Future<Either<Failure, PaymentTransactionResponse>> getPaymentTransactions({int? page});

  Future<Either<Failure, WalletTransactionResponse>> getWalletTransactions({int? page, String? type});

  Future<Either<Failure, FollowerResponse>> getFollowers({int? page, String? type});

  Future<Either<Failure, Map<String, dynamic>>> submitFeedback({String? feedback, String? email});

  Future<Either<Failure, SettlementRequestResponse>> getSettlementRequests({int? page, String? type});

  Future<Either<Failure, double>> getTotalEarning();

  Future<Either<Failure, WalletTransactionResponse>> getEarningTransactions({int? page, String? type});


}



