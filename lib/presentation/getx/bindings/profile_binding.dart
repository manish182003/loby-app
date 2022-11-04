
import 'package:get/get.dart';
import 'package:loby/domain/usecases/profile/add_funds.dart';
import 'package:loby/domain/usecases/profile/get_bank_details.dart';
import 'package:loby/domain/usecases/profile/get_duel.dart';
import 'package:loby/domain/usecases/profile/get_followers.dart';
import 'package:loby/domain/usecases/profile/get_payment_transactions.dart';
import 'package:loby/domain/usecases/profile/get_profile.dart';
import 'package:loby/domain/usecases/profile/get_ratings.dart';
import 'package:loby/domain/usecases/profile/get_settlement_requests.dart';
import 'package:loby/domain/usecases/profile/get_wallet_transactions.dart';
import 'package:loby/domain/usecases/profile/profile_verification.dart';
import 'package:loby/domain/usecases/profile/update_social_links.dart';
import 'package:loby/domain/usecases/profile/verify_payment.dart';
import 'package:loby/domain/usecases/profile/withdraw_money.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';

import '../../../domain/usecases/profile/add_bank_details.dart';
import '../../../domain/usecases/profile/follow_unfollow.dart';
import '../../../domain/usecases/profile/submit_feedback.dart';

class ProfileBinding extends Bindings {

  @override
  void dependencies() {

    final getProfile = Get.find<GetProfile>();
    final getRatings = Get.find<GetRatings>();
    final getDuel = Get.find<GetDuel>();
    final addFunds = Get.find<AddFunds>();
    final verifyPayment = Get.find<VerifyPayment>();
    final followUnfollow = Get.find<FollowUnfollow>();
    final updateSocialLinks = Get.find<UpdateSocialLinks>();
    final profileVerification = Get.find<ProfileVerification>();
    final addBankDetails = Get.find<AddBankDetails>();
    final getBankDetails = Get.find<GetBankDetails>();
    final withdrawMoney = Get.find<WithdrawMoney>();
    final getPaymentTransaction = Get.find<GetPaymentTransactions>();
    final getWalletTransaction = Get.find<GetWalletTransactions>();
    final getFollowers = Get.find<GetFollowers>();
    final submitFeedback = Get.find<SubmitFeedback>();
    final getSettlementRequests = Get.find<GetSettlementRequests>();


    Get.lazyPut(() => ProfileController(
      getProfile: getProfile,
      getRatings: getRatings,
      getDuel: getDuel,
      addFunds: addFunds,
      verifyPayment: verifyPayment,
      followUnfollow: followUnfollow,
      updateSocialLinks: updateSocialLinks,
      profileVerification: profileVerification,
        addBankDetails: addBankDetails,
      getBankDetails: getBankDetails,
      withdrawMoney: withdrawMoney,
      getPaymentTransactions: getPaymentTransaction,
      getWalletTransactions: getWalletTransaction,
      getFollowers: getFollowers,
      submitFeedback: submitFeedback,
        getSettlementRequests: getSettlementRequests,
    ));
  }

}