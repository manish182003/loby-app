import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loby/core/usecases/get_kyc_token_params.dart';
import 'package:loby/core/usecases/send_kyc_otp_params.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/usecases/verify_kyc_otp.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/usecases/kyc/get_kyc_token.dart';
import 'package:loby/domain/usecases/kyc/send_kyc_otp.dart';
import 'package:loby/domain/usecases/kyc/verify_kyc_otp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KycController extends GetxController {
  final GetKycToken _getKycToken;
  final SendKycOtp _kycOtp;
  final VerifyKycOtp _verifyKycOtp;

  KycController(
      {required GetKycToken getKycToken,
      required SendKycOtp kycOtp,
      required VerifyKycOtp verifyKycOtp})
      : _getKycToken = getKycToken,
        _kycOtp = kycOtp,
        _verifyKycOtp = verifyKycOtp;

  final errorMessage = ''.obs;
  final kycto = '';

 TextEditingController aadharNumbercontroller = TextEditingController();


  Future<bool> getKycToken({String? kycToken}) async {
    final failureOrSuccess = await _getKycToken(
      Params(
        kycTokenParams: KycTokenParams(kycToken: kycToken
            // slotId: slotId,
            ),
      ),
    );

    failureOrSuccess.fold(
      (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
        // isSlotsFetching(false);
      },
      (success) {
        // kyctoken;
        // Helpers.toast('gettoken');
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }

  Future<bool> sendKycOtp({
    String? kycToken,
    String? aadharNumber,
    String? type,
  }) async {
    // final fcmToken = await Helpers.getString('fcmToken
    final failureOrSuccess = await _kycOtp(
      Params(
        sendKycOtpParams: SendKycOtpParams(
            aadharNumber: aadharNumbercontroller.text.replaceAll(' ', ''),
            kycToken: kycToken,
            type: type),
      ),
    );

    failureOrSuccess.fold(
      (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
      (success) {
                  // SharedPreferences prefs = await SharedPreferences.getInstance();
                  // prefs.setString("kycToken", '');

        // saveProfileDetails();
        Helpers.toast('OTP Send');
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }

  Future<bool> verifyKycOtp(
      {String? kycToken, String? otp, String? refId, String? aadharNum}) async {
    final failureOrSuccess = await _verifyKycOtp(
      Params(
        verifyKycOtpParams: VerifyKycOtpParams(
            // mobile: mobile,
            kycToken: kycToken,
            otp: otp,
            refId: refId,
            aadharNum: aadharNumbercontroller.text.replaceAll(' ', ''),
            ),
      ),
    );

    failureOrSuccess.fold(
      (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
      (success) async{
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        //           prefs.setString("kycToken", '');
        // Helpers.toast('Profile Changed');
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }
}
