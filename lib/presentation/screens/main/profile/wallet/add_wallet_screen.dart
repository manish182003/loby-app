import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/presentation/getx/controllers/home_controller.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/screens/main/profile/wallet/widgets/token_widget.dart';
import 'package:loby/presentation/widgets/body_padding_widget.dart';
import 'package:loby/presentation/widgets/custom_loader.dart';
import 'package:loby/presentation/widgets/text_fields/text_field_widget.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../widgets/buttons/custom_button.dart';
import '../../../../widgets/custom_app_bar.dart';
// import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

class AddFundsScreen extends StatefulWidget {
  const AddFundsScreen({super.key});

  @override
  State<AddFundsScreen> createState() => _AddFundsScreenState();
}

class _AddFundsScreenState extends State<AddFundsScreen> {
  ProfileController profileController = Get.find<ProfileController>();
  HomeController homeController = Get.find<HomeController>();
  TextEditingController amount = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // final Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _razorpay.clear();
    amount.clear();
    profileController.rupeeToToken.value = "0";
    profileController.tokenToRupee.value = "0";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        appBar:
            appBar(context: context, appBarName: "Add Token", isBackIcon: true),
        body: BodyPaddingWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Stack(
                children: [
                  Card(
                    color: shipGreyColor,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: 140.0,
                        decoration: BoxDecoration(
                          color: aquaGreenColor,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8.0),
                          child: Column(
                            children: [
                              Text('Current Balance',
                                  textAlign: TextAlign.center,
                                  style: textTheme.displaySmall?.copyWith(
                                      color: textTunaBlueColor,
                                      fontWeight: FontWeight.w500)),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 16.0),
                                child: Obx(() {
                                  if (profileController
                                      .isProfileFetching.value) {
                                    return const CustomLoader();
                                  } else {
                                    return TokenWidget(
                                      tokens: profileController
                                          .profile.walletMoney!
                                          .toStringAsFixed(2),
                                    );
                                  }
                                }),
                              ),
                            ],
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 110.0),
                    child: Card(
                      color: shipGreyColor,
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 1,
                        decoration: BoxDecoration(
                          color: shipGreyColor,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 24.0),
                                    child: TextFieldWidget(
                                      textEditingController: amount,
                                      hint: "Enter Token Quantity",
                                      type: "add",
                                      isNumber: true,
                                      isRequired: true,
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          profileController.tokenToRupee.value =
                                              (int.tryParse(value)! *
                                                      int.tryParse(
                                                          homeController
                                                              .staticData[4]
                                                              .realValue!)!)
                                                  .floor()
                                                  .toString();
                                          logger.i(
                                              'rupee->${profileController.tokenToRupee.value}');
                                          profileController.rupeeToToken.value =
                                              (int.tryParse(value)! /
                                                      int.tryParse(
                                                          homeController
                                                              .staticData[5]
                                                              .key!)!)
                                                  .floor()
                                                  .toString();
                                        } else {
                                          profileController.tokenToRupee.value =
                                              '0';
                                          profileController.rupeeToToken.value =
                                              '0';
                                        }
                                      },
                                    )),
                                Obx(() {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TokenWidget(
                                        tokens: profileController
                                            .rupeeToToken.value,
                                        textColor: whiteColor,
                                        size: 20,
                                      ),
                                      Text(
                                        "₹ ${profileController.tokenToRupee}",
                                        style: textTheme.displaySmall
                                            ?.copyWith(color: whiteColor),
                                      ),
                                    ],
                                  );
                                }),
                                Obx(() {
                                  return CustomButton(
                                    top: 4.h,
                                    left: 15.w,
                                    right: 15.w,
                                    color: purpleLightIndigoColor,
                                    textColor: textWhiteColor,
                                    name:
                                        "Pay  ₹ ${profileController.tokenToRupee}",
                                    onTap: _openCheckout,
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  // void _handlePaymentSuccess(PaymentSuccessResponse response) async {
  //   await profileController.verifyPayment(
  //       signature: response.signature,
  //       paymentId: response.paymentId,
  //       paymentStatus: 'success',
  //       orderId: response.orderId,
  //   );
  //   await Helpers.hideLoader();
  //   Helpers.toast("Payment Successful");
  // }

  // void _handlePaymentError(PaymentFailureResponse response) async{
  //   await profileController.verifyPayment(
  //     paymentStatus: 'failed',
  //     orderId: profileController.addFundsResponse['order_id'],
  //   );
  //   Helpers.hideLoader();
  //   // Helpers.toast("Payment Failed ");
  //   print('Payment Error : ${response.code.toString()} ${response.message.toString()}');
  //   Helpers.toast("Payment Failed");
  //   // Helpers.toast("ERROR: ${response.code} - ${response.message!}");
  // }

  // void _handleExternalWallet(ExternalWalletResponse response) async{
  //   await profileController.verifyPayment(
  //     paymentStatus: 'failed',
  //     orderId: profileController.addFundsResponse['order_id'],
  //   );
  //   Helpers.hideLoader();
  //   Helpers.toast("Payment Failed");
  // }

  Future<void> _openCheckout() async {
    if (_formKey.currentState!.validate()) {
      await Helpers.loader();
      final isSuccess = await profileController.addFunds(
          amount: int.tryParse(profileController.tokenToRupee.value));
      if (isSuccess) {
        amount.clear();
        profileController.rupeeToToken.value = "0";
        profileController.tokenToRupee.value = "0";
        var options = {
          'key': 'rzp_test_0OFPJol8Rd6TZB',
          'amount': int.tryParse(
            profileController.addFundsResponse['total_amount'],
          ),
          'name': 'Loby',
          'order_id': profileController.addFundsResponse['order_id'],
          'description': 'Add Fund to Wallet',
          'timeout': 60,
          'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
        };
        try {
          // _razorpay.open(options);
        } catch (e) {
          debugPrint("Error : $e");
        }
      }
    }
  }
}
