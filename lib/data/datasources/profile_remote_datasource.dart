import 'dart:io';

import 'package:loby/data/models/response_models/profile/bank_detail_response_model.dart';
import 'package:loby/data/models/response_models/profile/duel_response_model.dart';
import 'package:loby/data/models/response_models/profile/follower_response.dart';
import 'package:loby/data/models/response_models/profile/rating_response_model.dart';
import 'package:loby/data/models/response_models/profile/user_response_model.dart';

import '../models/response_models/profile/payment_transaction_response_model.dart';
import '../models/response_models/profile/wallet_transaction_response_model.dart';

abstract class ProfileRemoteDatasource{

  Future<UserResponseModel> getProfile(int? userId);

  Future<RatingResponseModel> getRatings(int? userId, int? page);

  Future<DuelResponseModel> getDuel(int? userId);

  Future<Map<String, dynamic>> addFunds(int? amount);

  Future<Map<String, dynamic>> verifyPayment(String? signature, String? paymentId, String? paymentStatus, String? orderId);

  Future<Map<String, dynamic>> followUnfollow(int? userId);

  Future<Map<String, dynamic>> updateSocialLinks(String? insta, String? youtube, String? twitch, String? discord);

  Future<Map<String, dynamic>> profileVerification(String? displayName, String? name, String? message, String? youtube, String? twitch, String? instagram, File? idCard, File? selfie);

  Future<Map<String, dynamic>> addBankDetails(String? bankName, String? branchName, String? accountNumber, String? confirmAccountNumber, String? ifscCode, String? holderName, String? upiId, String? type);

  Future<BankDetailResponseModel> getBankDetails();

  Future<Map<String, dynamic>> withdrawMoney(int? bankDetailId, int? amount);

  Future<PaymentTransactionResponseModel> getPaymentTransactions(int? page);

  Future<WalletTransactionResponseModel> getWalletTransactions(int? page, String? type);

  Future<FollowerResponseModel> getFollowers(int? page, String? type);

  Future<Map<String, dynamic>> submitFeedback(String? feedback, String? email);


}