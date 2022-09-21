import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/listing/configuration_response.dart';
import 'package:loby/domain/entities/response_entities/listing/service_listing_response.dart';
import 'package:loby/domain/entities/response_entities/profile/bank_detail_response.dart';
import 'package:loby/domain/entities/response_entities/profile/duel_response.dart';
import 'package:loby/domain/entities/response_entities/profile/rating_response.dart';
import 'package:loby/domain/entities/response_entities/profile/user_response.dart';

abstract class ProfileRepository{

  Future<Either<Failure, UserResponse>> getProfile({int? userId});

  Future<Either<Failure, RatingResponse>> getRatings({int? userId, int? page});

  Future<Either<Failure, DuelResponse>> getDuel({int? userId});

  Future<Either<Failure, Map<String, dynamic>>> addFunds({int? amount});

  Future<Either<Failure, Map<String, dynamic>>> verifyPayment({String? signature, String? paymentId, String? paymentStatus, String? orderId});

  Future<Either<Failure, Map<String, dynamic>>> followUnfollow({int? userId});

  Future<Either<Failure, Map<String, dynamic>>> updateSocialLinks({String? insta, String? youtube, String? twitch, String? discord});

  Future<Either<Failure, Map<String, dynamic>>> profileVerification({String? displayName, String? name, String? message, String? youtube, String? twitch, String? instagram, File? idCard, File? selfie});

  Future<Either<Failure, Map<String, dynamic>>> addBankDetails({String? bankName, String? branchName, String? accountNumber, String? confirmAccountNumber, String? ifscCode, String? holderName, String? upiId, String? type});

  Future<Either<Failure, BankDetailResponse>> getBankDetails();

  Future<Either<Failure, Map<String, dynamic>>> withdrawMoney({int? bankDetailId, int? amount});


}



