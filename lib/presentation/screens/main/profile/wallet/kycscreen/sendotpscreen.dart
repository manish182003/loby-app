import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/presentation/getx/controllers/home_controller.dart';
import 'package:loby/presentation/getx/controllers/kyc_controller.dart';
import 'package:loby/presentation/getx/controllers/order_controller.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/screens/main/profile/my_order/all_orders_screen.dart';
import 'package:loby/presentation/widgets/buttons/custom_button.dart';
import 'package:loby/presentation/widgets/custom_app_bar.dart';
import 'package:loby/presentation/widgets/text_fields/text_field_widget.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:loby/domain/entities/kyc/get_kyc_token.dart';

class sendOtpScreen extends StatefulWidget {
  final GetKycToken? geTKyctoken;
  const sendOtpScreen({
    this.geTKyctoken,
    Key? key,
  }) : super(key: key);

  @override
  State<sendOtpScreen> createState() => _sendOtpScreenState();
}

class _sendOtpScreenState extends State<sendOtpScreen>
    with SingleTickerProviderStateMixin {
  KycController kycController = Get.find<KycController>();
  TextEditingController otp = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  ProfileController profileController = Get.find<ProfileController>();
  HomeController homeController = Get.find<HomeController>();

  TextEditingController bankName = TextEditingController();
  TextEditingController branchName = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController confirmAccountNumber = TextEditingController();
  TextEditingController ifscCode = TextEditingController();
  TextEditingController holderName = TextEditingController();
  TextEditingController upiId = TextEditingController();

  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // getKycToken();

    // _tabController =
    //     TabController(length: 3, vsync: this, initialIndex: _currentTabIndex);
    // _tabController.addListener(() {
    //   if (_tabController.animation?.value == _tabController.index) {
    //     setState(() {
    //       _currentTabIndex = _tabController.index;
    //     });

    //     getKycToken();
    //     debugPrint('current tab $_currentTabIndex');
    //   }
    // });
  }

  // Future<void> getKycToken() async {
  //   kycController.getKycToken();
  // }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: backgroundDarkJungleGreenColor,
      appBar: appBar(context: context, appBarName: "KYC Verification", isBackIcon: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 1.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: butterflyBlueColor,
                      ),
                    ),
                    Container(
                      height: 1.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: butterflyBlueColor,
                      ),
                    ),
                    Container(
                      height: 1.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: lightGreyColor,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  "OTP Verification",
                  style: textTheme.headline1?.copyWith(color: textWhiteColor),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Please enter the verification code sent to your \n mobile number",
                  style: textTheme.headline4?.copyWith(
                      color: textWhiteColor, fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 2.h,
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: PinCodeTextField(
                    appContext: context,
                    autoDisposeControllers: false,
                    pastedTextStyle: TextStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 6,
                    obscureText: false,
                    obscuringCharacter: '*',
                    animationType: AnimationType.scale,
                    validator: (v) {
                      if (v!.length < 6) {
                        return "";
                      } else {
                        return null;
                      }
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 65,
                      fieldWidth: 55,
                      activeColor: aquaGreenColor,
                      inactiveColor: shipGreyColor,
                      selectedColor: aquaGreenColor,
                    ),
                    cursorColor: whiteColor,
                    animationDuration: const Duration(milliseconds: 100),
                    textStyle: textTheme.headline3?.copyWith(color: whiteColor),
                    // enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: otp,
                    keyboardType: TextInputType.number,
                    boxShadows: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        blurRadius: 10,
                      )
                    ],
                    onCompleted: (v) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                    onChanged: (String value) {},
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Didn't Received ?",
                          style: textTheme.headline4?.copyWith(
                              color: textWhiteColor,
                              fontWeight: FontWeight.w300)),
                      InkWell(
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          kycController.sendKycOtp(
                              kycToken: prefs.getString("kycToken"),
                              aadharNumber: kycController
                                  .aadharNumbercontroller.value.text.
                                  replaceAll(' ', ''));
                          //     .then((value) {
                          //   if (value) {
                          //     context.pushNamed(sendOtppage);
                          //   }
                          // });
                        },
                        child: Container(
                            height: 35,
                            width: 90,
                            decoration: BoxDecoration(
                                color: purpleLightIndigoColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text("Resend",
                                  style: textTheme.headline4?.copyWith(
                                      color: textWhiteColor,
                                      fontWeight: FontWeight.w300)),
                            )),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                CustomButton(
                    name: "Next",
                    textColor: textWhiteColor,
                    color: purpleLightIndigoColor,
                    left: 4.w,
                    right: 4.w,
                    bottom: 5.h,
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      kycController
                          .verifyKycOtp(
                            // aadharNumber: kycController
                            //       .aadharNumbercontroller.value.text
                            //       .replaceAll(' ', ''),
                              refId: prefs.getString("refId"),
                              kycToken: prefs.getString("kycToken"),
                              otp: otp.value.text.trim(),
                              aadharNum: kycController.aadharNumbercontroller.text.replaceAll(' ', ''),
                              )
                          .then((value) {
                            if (value) {
                      _successDialog(context);
                    }
                          });
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _successDialog(BuildContext context) async {
    final textTheme = Theme.of(context).textTheme;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundDarkJungleGreenColor,

          // title: Text('Delete Slot'),

          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text("KYC Verification Done", style: textTheme.headline2?.copyWith(color: textWhiteColor, fontSize: 17.sp, fontWeight: FontWeight.w500)),
                SizedBox(height: 2.h,),
                Image(image: AssetImage("assets/images/success_logo.png")),
                SizedBox(height: 2.h,),
                Text("Now continue your transaction securely",
                    style: textTheme.headline5?.copyWith(color: textWhiteColor, fontSize: 9.sp))
              ],
            ),
          ),
          
          actions: <Widget>[
            CustomButton(
                                  height: 8.h,
                                  fontSize: 15.sp,
                                  name: "Continue",
                                  color: aquaGreenColor,

                                  // left: 0.w,
                                  // right: 0.w,
                                  bottom: 3.h,
                                  top: 2.h,
                                  onTap: () async {
                                    _addNewWithdrawMethodDialog(context, textTheme);
                                  }),
            // TextButton(
            //   child: Text(
            //     'Done',
            //     style: TextStyle(color: aquaGreenColor),
            //   ),
            //   onPressed: () {
            //     _addNewWithdrawMethodDialog(context, textTheme);
            //   },
            // ),
          ],
        );
      },
    );
  }

  void _addNewWithdrawMethodDialog(BuildContext context, TextTheme textTheme) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: backgroundDarkJungleGreenColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: SizedBox(
            height: 24.h,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Add Withdraw Method',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style:
                          textTheme.headline4?.copyWith(color: textWhiteColor)),
                  SizedBox(height: 4.h),
                  _addBankDetailOption(textTheme, context, 'Bank Account',
                      onTap: () {
                    // Navigator.of(context).pop();
                    context.pushNamed(addAccountpage);
                  }),
                  SizedBox(height: 2.h),
                  _addBankDetailOption(textTheme, context, 'UPI ID', onTap: () {
                    context.pushNamed(upiDetailpage);
                    // Navigator.of(context).pop();
                    // _addUPIDetailDialog(context, textTheme);
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _addBankDetailDialog(BuildContext context, TextTheme textTheme) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: backgroundDarkJungleGreenColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // TextFieldWidget(
                      //   textEditingController: bankName,
                      //   title: "Bank Name",
                      //   titleColor: textWhiteColor,
                      //   isRequired: true,
                      // ),
                      // SizedBox(height: 2.h),
                      // TextFieldWidget(
                      //   textEditingController: branchName,
                      //   title: "Branch Name",
                      //   titleColor: textWhiteColor,
                      //   isRequired: true,
                      // ),
                      SizedBox(height: 2.h),
                      TextFieldWidget(
                        textEditingController: accountNumber,
                        title: "Account Number",
                        titleColor: textWhiteColor,
                        isRequired: true,
                        isNumber: true,
                      ),
                      SizedBox(height: 2.h),
                      TextFieldWidget(
                        textEditingController: confirmAccountNumber,
                        title: "Re-Enter Account Number",
                        titleColor: textWhiteColor,
                        isRequired: true,
                        isNumber: true,
                      ),
                      SizedBox(height: 2.h),
                      TextFieldWidget(
                        textEditingController: ifscCode,
                        title: "IFSC Code",
                        titleColor: textWhiteColor,
                        isRequired: true,
                      ),
                      SizedBox(height: 2.h),
                      // TextFieldWidget(
                      //   textEditingController: holderName,
                      //   title: "Account Holder Name",
                      //   titleColor: textWhiteColor,
                      //   isRequired: true,
                      // ),
                      SizedBox(height: 2.h),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: CustomButton(
                          color: purpleLightIndigoColor,
                          textColor: textWhiteColor,
                          name: "Add",
                          onTap: () async {
                            if (_formKey2.currentState!.validate()) {
                              Helpers.loader();
                              final isSuccess =
                                  await profileController.addBankDetails(
                                // bankName: bankName.text,
                                // branchName: branchName.text,
                                accountNumber: accountNumber.text,
                                confirmAccountNumber: confirmAccountNumber.text,
                                ifscCode: ifscCode.text,
                                // holderName: holderName.text,
                                type: "bank_account",
                              );
                              if (isSuccess) {
                                await profileController.getBankDetails();
                                clearAddBankDetails();
                                Helpers.toast("Successfully Added");
                                Helpers.hideLoader();
                                Navigator.of(context).pop();
                              } else {
                                Helpers.hideLoader();
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void clearAddBankDetails() {
    bankName.clear();
    branchName.clear();
    accountNumber.clear();
    confirmAccountNumber.clear();
    ifscCode.clear();
    holderName.clear();
    upiId.clear();
  }

  Widget _addBankDetailOption(
      TextTheme textTheme, BuildContext context, String title,
      {Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: shipGreyColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Text(title,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: textTheme.headline6?.copyWith(color: textWhiteColor)),
      ),
    );
  }

  void _addUPIDetailDialog(BuildContext context, TextTheme textTheme) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: backgroundDarkJungleGreenColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: SizedBox(
            height: 45.h,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // TextFieldWidget(
                    //   textEditingController: holderName,
                    //   title: "Name",
                    //   titleColor: textWhiteColor,
                    //   isRequired: true,
                    // ),
                    SizedBox(height: 2.h),
                    TextFieldWidget(
                      textEditingController: upiId,
                      title: "UPI ID",
                      titleColor: textWhiteColor,
                      isRequired: true,
                    ),
                    SizedBox(height: 2.h),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: CustomButton(
                        color: purpleLightIndigoColor,
                        textColor: textWhiteColor,
                        name: "Add",
                        onTap: () async {
                          if (_formKey3.currentState!.validate()) {
                            Helpers.loader();
                            final isSuccess =
                                await profileController.addBankDetails(
                              // holderName: holderName.text,
                              upiId: upiId.text,
                              type: "vpa",
                            );
                            await profileController.getBankDetails();
                            clearAddBankDetails();
                            Helpers.hideLoader();
                            if (isSuccess) {
                              Helpers.toast("Successfully Added");
                              Navigator.of(context).pop();
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
