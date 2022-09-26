

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/auth/city_response.dart';
import 'package:loby/domain/entities/response_entities/auth/country_response.dart';
import 'package:loby/domain/entities/response_entities/auth/profile_tag_response.dart';
import 'package:loby/domain/entities/response_entities/auth/state_response.dart';

abstract class AuthRepository{

  Future<Either<Failure, Map<String, dynamic>>> signup({String? name, String? email, String? password, String? confirmPassword});

  Future<Either<Failure, bool>> login({String? email, String? password, String? socialLoginId, int? socialLoginType, String? name});

  Future<Either<Failure, CountryResponse>> getCountries({required String? search, int? page});

  Future<Either<Failure, StateResponse>> getStates({required String? search, int? stateId, int? countryId, int? page});

  Future<Either<Failure, CityResponse>> getCities({required String? search, int? stateId, int? cityId, int? page});

  Future<Either<Failure, ProfileTagResponse>> getProfileTags({required String? search, int? page});

  Future<Either<Failure, bool>> updateProfile({File? cover, File? avatar, String? fullName, String? displayName, int? countryId, int? stateId, int? cityId, String? DOB, List<Map<String, dynamic>>? profileTags, String? bio});

  Future<Either<Failure, String>> checkUsername({String? username});


}