import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:loby/core/utils/constants.dart';
import 'package:loby/core/utils/exceptions.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/data/datasources/auth_remote_datasource.dart';
import 'package:loby/data/models/response_models/auth/city_response_model.dart';
import 'package:loby/data/models/response_models/auth/profile_tag_response_model.dart';
import 'package:loby/data/models/response_models/auth/state_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/response_models/auth/country_response_model.dart';

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource{

  final Dio _dio;
  AuthRemoteDatasourceImpl(this._dio);

  @override
  Future<Map<String, dynamic>> signup(String? name, String? email, String? password, String? confirmPassword) async{
    try {
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.signup,
        queryParams: {'name': name, 'email' : email, 'password' : password, 'confirm_password' : confirmPassword},
      );

      debugPrint("login $response");

      if(response != null){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('apiToken', response['data']['reset_token']);
      }

      return response!['data'];
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<CountryResponseModel> getCountries(String? name, int? page) async{
    try {
      String token = await Helpers.getApiToken();
      final Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };

      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getCountries,
        queryParams: {'name': name, 'page' : '${page ?? ""}'},
        headers: headers,
      );

      return CountryResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<StateResponseModel> getStates(String? search, int? stateId, int? countryId, int? page)async {
    try {
      String token = await Helpers.getApiToken();
      final Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };

      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getStates,
        queryParams: {'name': search, 'state_id': '${stateId ?? ''}', 'country_id' : '${countryId ?? ''}', 'page' : '${page ?? ''}'},
        headers: headers,
      );

      return StateResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<CityResponseModel> getCities(String? search, int? stateId, int? cityId, int? page)async {
    try {
      String token = await Helpers.getApiToken();
      final Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };

      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getCities,
        queryParams: {'name': search,'state_id': '${stateId ?? ''}', 'city_id' : '${cityId ?? ''}', 'page' : '${page ?? ''}'},
        headers: headers,
      );

      return CityResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<ProfileTagResponseModel> getProfileTags(String? search, int? page) async{
    try {
      String token = await Helpers.getApiToken();
      final Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };

      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getProfileTags,
        queryParams: {'name': search, 'page' : '${page ?? ''}'},
        headers: headers,
      );

      return ProfileTagResponseModel.fromJSON(response ?? {'data' : []});
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<bool> updateProfile(File? cover, File? avatar, String? fullName, String? displayName, int? countryId, int? stateId, int? cityId, String? DOB, List<Map<String, dynamic>>? profileTags, String? bio)async {
    try {

      String token = await Helpers.getApiToken();
      final Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };

      print(avatar);
      print(fullName);
      print(displayName);
      print(countryId);
      print(stateId);
      print(cityId);
      print(DOB);
      print(profileTags);
      print(bio);



      FormData formData = FormData()
        ..fields.add(
          MapEntry('name', fullName!),
        )
        ..fields.add(
          MapEntry('display_name', displayName!),
        )
        ..fields.add(
          MapEntry('country_id', '$countryId'),
        )
        ..fields.add(
          MapEntry('state_id', '$stateId'),
        )
        ..fields.add(
          MapEntry('city_id', '$cityId'),
        )
        ..fields.add(
          MapEntry('dob', DOB!),
        )
        ..fields.add(
          MapEntry('bio', bio!),
        )
        ..fields.add(
          MapEntry('profile_tags', profileTags == null ? '' : profileTags.map((e) => e['id']).toList().join(','))
        );


      if(avatar != null && avatar.path.isNotEmpty) {
        formData.files.add(MapEntry('image',
            MultipartFile.fromFileSync(avatar.path,
              // contentType: MediaType('image', 'jpg'),
            )));
      }

      // if(cover != null && cover.path.isNotEmpty) {
      //   formData.files.add(MapEntry('cover_image',
      //       MultipartFile.fromFileSync(cover.path,
      //         // contentType: MediaType('image', 'jpg'),
      //       )));
      // }

      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.updateProfile,
        data: formData,
        headers: headers
      );

      if(response != null){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        prefs.setString('userId', "${response['data']['id']}");
      }

      return true;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<bool> login(String? email, String? password, String? socialLoginId, int? socialLoginType, String? name)async {
    try {
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        socialLoginId == null ? ApiEndpoints.login : ApiEndpoints.socialLogin,
        queryParams: socialLoginId == null ? {'email' : email, 'password' : password,} : {'social_login_id' : socialLoginId, 'social_login_type' : '${socialLoginType ?? ''}', 'name' : name, 'email' : email},
      );
      debugPrint("login $response");

      if(response != null){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('apiToken', response['data']['reset_token']);
        prefs.setBool('isLoggedIn', true);
        prefs.setString('userId', "${response['data']['id']}");
      }

      return true;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> checkUsername(String? username) async{
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.checkUsername,
        queryParams: {'display_name': "$username"},
        headers: headers,
      );

      return response!['message'];
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> addFCMToken(String? fcmToken) async{
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.addFCMToken,
        queryParams: {'fcm_token': fcmToken},
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }






}