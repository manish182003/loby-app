import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:loby/core/utils/exceptions.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/auth/city_response.dart';
import 'package:loby/domain/entities/response_entities/auth/country_response.dart';
import 'package:loby/domain/entities/response_entities/auth/profile_tag_response.dart';
import 'package:loby/domain/entities/response_entities/auth/state_response.dart';
import 'package:loby/domain/repositories/auth_repository.dart';

import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl extends AuthRepository{

  final AuthRemoteDatasource _authRemoteDatasource;

  AuthRepositoryImpl(this._authRemoteDatasource);

  @override
  Future<Either<Failure, Map<String, dynamic>>> signup({String? name, String? email, String? password, String? confirmPassword}) async{
    try {
      return Right(await _authRemoteDatasource.signup(name, email, password, confirmPassword));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, CountryResponse>> getCountries({required String? search, int? page}) async{
    try {
      return Right(await _authRemoteDatasource.getCountries(search, page));
    } on ServerException catch (e) {
      // Loggers can be added here for analyzation.
      return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, StateResponse>> getStates({required String? search, int? stateId, int? countryId, int? page})async {
    try {
      return Right(await _authRemoteDatasource.getStates(search, stateId, countryId, page));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, CityResponse>> getCities({required String? search, int? stateId, int? cityId, int? page}) async{
    try {
      return Right(await _authRemoteDatasource.getCities(search, stateId, cityId, page));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileTagResponse>> getProfileTags({required String? search, int? page})async {
    try {
      return Right(await _authRemoteDatasource.getProfileTags(search, page));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateProfile({File? cover, File? avatar, String? fullName, String? displayName, int? countryId, int? stateId, int? cityId, String? DOB, List<Map<String, dynamic>>? profileTags, String? bio})async {
    try {
      return Right(await _authRemoteDatasource.updateProfile(cover, avatar, fullName, displayName, countryId, stateId, cityId, DOB, profileTags, bio));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> login({String? email, String? password, String? socialLoginId, int? socialLoginType, String? name})async {
    try {
      return Right(await _authRemoteDatasource.login(email, password, socialLoginId, socialLoginType, name));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> checkUsername({String? username}) async{
    try {
      return Right(await _authRemoteDatasource.checkUsername(username));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

}