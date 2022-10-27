// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:loby/data/models/response_models/auth/city_response_model.dart';
import 'package:loby/data/models/response_models/auth/country_response_model.dart';
import 'package:loby/data/models/response_models/auth/profile_tag_response_model.dart';
import 'package:loby/data/models/response_models/auth/state_response_model.dart';

abstract class AuthRemoteDatasource{

  Future<Map<String, dynamic>> signup(String? name, String? email, String? password, String? confirmPassword);

  Future<bool> login(String? email, String? password, String? socialLoginId, int? socialLoginType, String? name);

  Future<CountryResponseModel> getCountries(String? name, int? page);

  Future<StateResponseModel> getStates(String? search, int? stateId, int? countryId, int? page);

  Future<CityResponseModel> getCities(String? search, int? stateId, int? cityId, int? page);

  Future<ProfileTagResponseModel> getProfileTags(String? search, int? page);

  Future<bool> updateProfile(File? cover, File? avatar, String? fullName, String? displayName, int? countryId, int? stateId, int? cityId, String? DOB, List<Map<String, dynamic>>? profileTags, String? bio);

  Future<String> checkUsername(String? username);

  Future<Map<String, dynamic>> addFCMToken(String? fcmToken);

  Future<Map<String, dynamic>> sendAndVerifyOTP(String? email, String? otp);


}