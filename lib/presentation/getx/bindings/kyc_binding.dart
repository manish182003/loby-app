import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:loby/domain/usecases/kyc/send_kyc_otp.dart';
import 'package:loby/domain/usecases/kyc/verify_kyc_otp.dart';
import 'package:loby/presentation/getx/controllers/kyc_controller.dart';

import '../../../domain/usecases/kyc/get_kyc_token.dart';
import '../../../domain/usecases/slots/add_slots.dart';

class KycBinding extends Bindings {
  @override
  void dependencies() {
    final getKycToken = Get.find<GetKycToken>();
    final sendKycOtp = Get.find<SendKycOtp>();
    final verifyKycOtp = Get.find<VerifyKycOtp>();

    Get.lazyPut(() => KycController(
        getKycToken: getKycToken,
        kycOtp: sendKycOtp,
        verifyKycOtp: verifyKycOtp));
  }
}
