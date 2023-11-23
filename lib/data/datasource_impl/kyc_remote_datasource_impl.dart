import 'package:dio/dio.dart';
import 'package:loby/core/utils/constants.dart';
import 'package:loby/core/utils/exceptions.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/data/datasources/key_remote_datasource.dart';
import 'package:loby/data/models/response_models/kyc/get_kyc_token_response_model.dart';
import 'package:loby/domain/entities/response_entities/kyc/get_kyc_token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KycRemoteDatasourceImpl extends KycRemoteDatasource {

  final Dio _dio;

  KycRemoteDatasourceImpl(this._dio);
  @override
  Future<Map<String, dynamic>> getKycToken(String? kycToken) async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getKycToken,
        // queryParams: {'day':},
        headers: headers,
      );
      if(response != null){
        print("kyctoken >^&* ${response['token']}");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('kycToken', response['token']??"");
      }

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
  
  @override
  Future<bool> sendKycOtp(String? kycToken, String? aadharNumber, String? type) async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.sendKycOtp,
        queryParams: {'token' : kycToken , 'kyc_number' : aadharNumber, "type" : "AADHAR"},
        headers: headers,
      );

      // if(response != null){
      //   print("token >^&* ${response['data']['reset_token']}");
      // }
      if(response != null){
        print("refIddd >^&* ${response['ref_id']}");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('refId', response['ref_id']??"");
      }

      return true;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> verifyKycOtp(String? kycToken, String? otp, String? refId) async{
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.verifyKycOtp,
        queryParams: {
          'token' : kycToken,
          // 'mobile': mobile,
          'otp' : otp,
          'ref_id' : "111111"
        },
        headers: headers,
        encoded: true
      );
      
      

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

}


// {user_game_service_id: 27, quantity: 1, price: 1, booked_from_time: 07:00:00, booked_to_time: 08:00:00, booked_date: 2023-11-18}