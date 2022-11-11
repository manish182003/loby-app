import 'dart:io';

import 'package:dio/dio.dart';
import 'package:loby/core/utils/constants.dart';
import 'package:loby/core/utils/exceptions.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/data/datasources/profile_remote_datasource.dart';
import 'package:loby/data/models/response_models/profile/bank_detail_response_model.dart';
import 'package:loby/data/models/response_models/profile/duel_response_model.dart';
import 'package:loby/data/models/response_models/profile/follower_response.dart';
import 'package:loby/data/models/response_models/profile/payment_transaction_response_model.dart';
import 'package:loby/data/models/response_models/profile/rating_response_model.dart';
import 'package:loby/data/models/response_models/profile/settlement_request_response_model.dart';
import 'package:loby/data/models/response_models/profile/user_response_model.dart';
import 'package:loby/data/models/response_models/profile/wallet_transaction_response_model.dart';


class ProfileRemoteDatasourceImpl extends ProfileRemoteDatasource{
  final Dio _dio;

  ProfileRemoteDatasourceImpl(this._dio);

  @override
  Future<UserResponseModel> getProfile(int? userId) async{
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        userId == null ? ApiEndpoints.getProfile : ApiEndpoints.getOtherProfile,
        queryParams: {'user_id': '$userId'},
        headers: headers,
      );

      return UserResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<RatingResponseModel> getRatings(int? userId, int? page) async{
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getRatings,
        queryParams: {'user_id': '$userId', 'page' : '${page ?? ''}'},
        headers: headers,
      );

      return RatingResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<DuelResponseModel> getDuel(int? userId, int? page) async{
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getDuel,
        queryParams: {'user_id': '$userId'},
        headers: headers,
      );

      return DuelResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> addFunds(int? amount) async{
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.addFunds,
        queryParams: {'total_amount': '$amount'},
        headers: headers,
      );

      return response!['data']!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> verifyPayment(String? signature, String? paymentId, String? paymentStatus, String? orderId) async{
    try {

      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.verifyPayment,
        queryParams: {
          if(signature != null) 'signature': signature,
          if(paymentId != null) 'payment_id': paymentId,
          'payment_status': paymentStatus,
          if(orderId != null) 'order_id': orderId
        },
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> followUnfollow(int? userId)async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.followUnfollow,
        queryParams: {'followed_to': "$userId"},
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> updateSocialLinks(String? insta, String? youtube, String? twitch, String? discord) async{
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.updateSocialLinks,
        queryParams: {'instagram_id': insta ?? "", 'youtube_id' : youtube ?? "", 'twitch_id' : twitch ?? "", 'discord_id' : discord ?? ''},
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> profileVerification(String? displayName, String? name, String? message, String? youtube, String? twitch, String? instagram, File? idCard, File? selfie) async{
    try {
      final headers = await Helpers.getApiHeaders();

      // print(displayName);
      // print(name);
      // print(message);
      // print(youtube);
      // print(twitch);
      // print(instagram);
      // print(idCard);
      // print(selfie);

      FormData formData = FormData()
        ..fields.add(
          MapEntry('display_name', displayName!),
        )
        ..fields.add(
          MapEntry('name', name!),
        )
        ..fields.add(
          MapEntry('message', message!),
        )
        ..fields.add(
          MapEntry('youtube_id', youtube!),
        )
        ..fields.add(
          MapEntry('twitch_id', twitch!),
        )
        ..fields.add(
          MapEntry('instagram_id', instagram!),
        );

      if(idCard!.path.isNotEmpty) {
        formData.files.add(MapEntry('identity_proof',
            MultipartFile.fromFileSync(idCard.path,
              // contentType: MediaType('image', 'jpg'),
                )));
      }


      if(selfie!.path.isNotEmpty) {
        formData.files.add(MapEntry('selfie',
            MultipartFile.fromFileSync(selfie.path,
              // contentType: MediaType('image', 'jpg'),
            )));
      }



      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.profileVerification,
        data: formData,
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> addBankDetails(String? bankName, String? branchName, String? accountNumber, String? confirmAccountNumber, String? ifscCode, String? holderName, String? upiId, String? type) async{
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.addBankDetails,
        queryParams: type == "bank_account" ? {
          'bank_name': bankName ?? "",
          'branch_name' : branchName ?? "",
          'bank_account_number' : accountNumber ?? "",
          'confirm_bank_account_number' : confirmAccountNumber ?? "",
          'ifsc_code' : ifscCode ?? "",
          'full_registered_name' : holderName ?? "",
          'bank_account_type' : type ?? "",
        } : {
          'full_registered_name' : holderName ?? "",
          'upi_id' : upiId ?? "",
          'bank_account_type' : type ?? "",
        },
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<BankDetailResponseModel> getBankDetails()async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getBankDetails,
        // queryParams: {'instagram_id': insta ?? "", 'youtube_id' : youtube ?? "", 'twitch_id' : twitch ?? "", 'discord_id' : discord ?? ''},
        headers: headers,
      );

      return BankDetailResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> withdrawMoney(int? bankDetailId, int? amount)async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.withdrawMoney,
        queryParams: {'total_amount': amount ?? "", 'bank_detail_id' : bankDetailId ?? ""},
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<PaymentTransactionResponseModel> getPaymentTransactions(int? page)async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getPaymentTransactions,
        queryParams: {'page': page ?? ""},
        headers: headers,
      );

      return PaymentTransactionResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<WalletTransactionResponseModel> getWalletTransactions(int? page, String? type)async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getWalletTransactions,
        queryParams: {'page': page ?? "", 'type' : type ?? ""},
        headers: headers,
      );

      return WalletTransactionResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<FollowerResponseModel> getFollowers(int? page, String? type)async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        type == "following" ? ApiEndpoints.getFollowing : ApiEndpoints.getFollowers,
        // queryParams: {'page': page ?? "", 'type' : type ?? ""},
        headers: headers,
      );

      return FollowerResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> submitFeedback(String? feedback, String? email) async{
    try {
      final headers = await Helpers.getApiHeaders();

      FormData formData = FormData()
        ..fields.add(
          MapEntry('description', feedback!),
        )
        ..fields.add(
          MapEntry('email', email!),
        );

      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.submitFeedback,
        data: formData,
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<SettlementRequestResponseModel> getSettlementRequests(int? page, String? type)async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getSettlementRequests,
        queryParams: {'page': page ?? ""},
        headers: headers,
      );

      return SettlementRequestResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}