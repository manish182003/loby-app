import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:loby/core/usecases/profile_params.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/profile/duel_details.dart';
import 'package:loby/domain/entities/profile/rating.dart';
import 'package:loby/domain/entities/profile/user.dart';
import 'package:loby/domain/usecases/profile/add_bank_details.dart';
import 'package:loby/domain/usecases/profile/add_funds.dart';
import 'package:loby/domain/usecases/profile/follow_unfollow.dart';
import 'package:loby/domain/usecases/profile/get_duel.dart';
import 'package:loby/domain/usecases/profile/get_profile.dart';
import 'package:loby/domain/usecases/profile/get_ratings.dart';
import 'package:loby/domain/usecases/profile/profile_verification.dart';
import 'package:loby/domain/usecases/profile/update_social_links.dart';
import 'package:loby/domain/usecases/profile/withdraw_money.dart';

import '../../../domain/entities/profile/bank_detail.dart';
import '../../../domain/usecases/profile/get_bank_details.dart';
import '../../../domain/usecases/profile/verify_payment.dart';


class ProfileController extends GetxController{

  final GetProfile _getProfile;
  final GetRatings _getRatings;
  final GetDuel _getDuel;
  final AddFunds _addFunds;
  final VerifyPayment _verifyPayment;
  final FollowUnfollow _followUnfollow;
  final UpdateSocialLinks _updateSocialLinks;
  final ProfileVerification _profileVerification;
  final AddBankDetails _addBankDetails;
  final GetBankDetails _getBankDetails;
  final WithdrawMoney _withdrawMoney;
  ProfileController({
    required GetProfile getProfile,
    required GetRatings getRatings,
    required GetDuel getDuel,
    required AddFunds addFunds,
    required VerifyPayment verifyPayment,
    required FollowUnfollow followUnfollow,
    required UpdateSocialLinks updateSocialLinks,
    required ProfileVerification profileVerification,
    required AddBankDetails addBankDetails,
    required GetBankDetails getBankDetails,
    required WithdrawMoney withdrawMoney,
  }) : _getProfile = getProfile,
  _getRatings = getRatings,
  _getDuel = getDuel,
  _addFunds = addFunds,
  _verifyPayment = verifyPayment,
  _followUnfollow = followUnfollow,
  _updateSocialLinks = updateSocialLinks,
  _profileVerification = profileVerification,
        _addBankDetails = addBankDetails,
  _getBankDetails = getBankDetails,
        _withdrawMoney = withdrawMoney;



  final errorMessage = ''.obs;

  User profile = const User();
  final isProfileFetching = false.obs;

  final ratings = <Rating>[].obs;
  final isRatingsFetching = false.obs;
  final ratingPageNumber = 1.obs;

  DuelDetails duelDetails = const DuelDetails();
  final isDuelFetching = false.obs;

  final addFundsResponse = {}.obs;
  final isSocialLinksFetching = false.obs;

  final bankDetails = <BankDetail>[].obs;
  final isBankDetailsFetching = false.obs;

  final lastOrderStatus ="".obs;






  Future<bool> getProfile({int? userId, String? from}) async {
    from == "social" ? isSocialLinksFetching.value = true : isProfileFetching.value = true;

    final failureOrSuccess = await _getProfile(
      Params(profileParams: ProfileParams(
         userId: userId
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
        isProfileFetching.value = false;
        isSocialLinksFetching.value = false;
      },
          (success) {
        profile = success.user;
        isProfileFetching.value = false;
        isSocialLinksFetching.value = false;
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }


  Future<bool> getRatings({int? userId}) async {
    isRatingsFetching.value = true;

    final failureOrSuccess = await _getRatings(
      Params(profileParams: ProfileParams(
          userId: userId,
        page: ratingPageNumber.value,
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
        isRatingsFetching.value = false;
      },
          (success) {
        ratings.value = success.ratings;
        isRatingsFetching.value = false;
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }



  Future<bool> getDuel({int? userId}) async {
    isDuelFetching.value = true;

    final failureOrSuccess = await _getDuel(
      Params(profileParams: ProfileParams(
        userId: userId,
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
        isDuelFetching.value = false;
      },
          (success) {
        duelDetails = success.duelDetails;
        isDuelFetching.value = false;
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }


  Future<bool> addFunds({int? amount}) async {

    final failureOrSuccess = await _addFunds(
      Params(profileParams: ProfileParams(
        amount: amount,
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {
        addFundsResponse.value = success;
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }

  Future<bool> verifyPayment({String? signature, String? paymentId, String? paymentStatus, String? orderId}) async {

    final failureOrSuccess = await _verifyPayment(
      Params(profileParams: ProfileParams(
        signature: signature,
        paymentId: paymentId,
        paymentStatus: paymentStatus,
        orderId: orderId,
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) async{
            await getProfile();
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }

  Future<bool> followUnfollow({int? userId}) async {

    final failureOrSuccess = await _followUnfollow(
      Params(profileParams: ProfileParams(
       userId: userId
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {

      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }

  Future<bool> updateSocialLinks({String? insta, String? youtube, String? twitch, String? discord}) async {

    final failureOrSuccess = await _updateSocialLinks(
      Params(profileParams: ProfileParams(
        insta: insta,
        youtube: youtube,
        twitch: twitch,
        discord: discord,
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {
            Helpers.toast("Social Links Updated Successfully");

      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }


  Future<bool> profileVerification({String? displayName, String? name, String? message, String? youtube, String? twitch, String? instagram, File? idCard, File? selfie}) async {

    final failureOrSuccess = await _profileVerification(
      Params(profileParams: ProfileParams(
        displayName: displayName,
        name: name,
        message: message,
        insta: instagram,
        youtube: youtube,
        twitch: twitch,
        idCard: idCard,
        selfie: selfie,
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {
        Helpers.toast("Social Links Updated Successfully");

      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }

  Future<bool> addBankDetails({String? bankName, String? branchName, String? accountNumber, String? confirmAccountNumber, String? ifscCode, String? holderName, String? upiId, String? type}) async {

    final failureOrSuccess = await _addBankDetails(
      Params(profileParams: ProfileParams(
        bankName: bankName,
        branchName: branchName,
        accountNumber: accountNumber,
        confirmAccountNumber: confirmAccountNumber,
        ifscCode: ifscCode,
        holderName: holderName,
        upiID: upiId,
        type: type,
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {


      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }


  Future<bool> getBankDetails() async {
    isBankDetailsFetching(true);
    final failureOrSuccess = await _getBankDetails(
      const Params(profileParams: ProfileParams(

      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
        isBankDetailsFetching(false);
      },
          (success) {
            bankDetails.value = success.bankDetails;
            isBankDetailsFetching(false);
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }

  Future<bool> withdrawMoney({required int? bankDetailId, required int? amount}) async {
    final failureOrSuccess = await _withdrawMoney(
      Params(profileParams: ProfileParams(
        bankDetailId: bankDetailId,
        amount: amount,
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {

      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }



}