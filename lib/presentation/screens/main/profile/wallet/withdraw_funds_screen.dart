import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/profile/bank_detail.dart';
import 'package:loby/presentation/getx/controllers/home_controller.dart';
import 'package:loby/presentation/getx/controllers/kyc_controller.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/screens/main/profile/wallet/widgets/token_widget.dart';
import 'package:loby/presentation/widgets/confirmation_dialog.dart';
import 'package:loby/presentation/widgets/text_fields/custom_drop_down.dart';
import 'package:loby/presentation/widgets/text_fields/text_field_widget.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../services/routing_service/routes_name.dart';
import '../../../../widgets/bottom_dialog.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/buttons/custom_button.dart';
import '../../../../widgets/custom_loader.dart';
import '../../../../widgets/drop_down.dart';
import '../../../../widgets/input_text_title_widget.dart';
import '../../../../widgets/input_text_widget.dart';

class WithdrawFundsScreen extends StatefulWidget {
  const WithdrawFundsScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawFundsScreen> createState() => _WithdrawFundsScreenState();
}

class _WithdrawFundsScreenState extends State<WithdrawFundsScreen> {
  ProfileController profileController = Get.find<ProfileController>();
  HomeController homeController = Get.find<HomeController>();

  TextEditingController bankName = TextEditingController();
  TextEditingController branchName = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController confirmAccountNumber = TextEditingController();
  TextEditingController ifscCode = TextEditingController();
  TextEditingController holderName = TextEditingController();
  TextEditingController upiId = TextEditingController();

  String selectedBankName = "";
  int selectedBankId = 0;

  TextEditingController amount = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.getBankDetails();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    amount.clear();
    profileController.rupeeToToken.value = "0";
    profileController.tokenToRupee.value = "0";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: appBar(context: context, appBarName: "Withdraw Token"),
      body: Obx(() {
        if (profileController.isBankDetailsFetching.value) {
          return const CustomLoader();
        } else if (profileController.bankDetails.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                      "Safely Access Your Funds: Initiate",
                      style: textTheme.headline2?.copyWith(
                        
                          color: whiteColor, fontWeight: FontWeight.w500)),
                          SizedBox(height: 1.h,),
                          Text(
                      "Withdrawal Process Today!",
                      style: textTheme.headline2?.copyWith(
                        
                          color: whiteColor, fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  height: 30.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: concordColor.withOpacity(0.2)
                  ),
                  child: Center(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 3.h,),
                        Text(
                            "Get Started with KYC Verification",
                            style: textTheme.headline3?.copyWith(
                                color: whiteColor,
                                fontWeight: FontWeight.w500)),
                                SizedBox(height: 1.h,),
                                Text(
                            "Secure Your Account Now!",
                            style: textTheme.headline3?.copyWith(
                                color: whiteColor,
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: 5.h,
                        ),
                        CustomButton(
                          color: purpleLightIndigoColor,
                          textColor: textWhiteColor,
                          left: 20.w,
                          right: 20.w,
                          height: 7.5.h,
                          name: "Get Started",
                          onTap: () {
                            context.pushNamed(myKycScreen);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomButton(
                  color: purpleLightIndigoColor,
                  textColor: textWhiteColor,
                  left: 20.w,
                  
                  right: 20.w,
                  height: 7.5.h,
                  name: "Add Withdraw Method",
                  onTap: () {
                    _addNewWithdrawMethodDialog(context, textTheme);
                  },
                ),
              ],
            ),
          );
          // return Center(
          //   child: CustomButton(
          //     color: purpleLightIndigoColor,
          //     textColor: textWhiteColor,
          //     left: 20.w,
          //     right: 20.w,
          //     height: 7.5.h,
          //     name: "Add Withdraw Method",
          //     onTap: () {
          //       _addNewWithdrawMethodDialog(context, textTheme);
          //     },
          //   ),
          // );
        } else {
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
                    child: Stack(
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
                                        style: textTheme.headline3?.copyWith(
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
                                                  .toStringAsFixed(2));
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(24.0),
                                      child: BuildDropdown(
                                        selectedValue: selectedBankName,
                                        dropdownHint: "Select Withdraw Method",
                                        isRequired: true,
                                        itemsList: profileController.bankDetails
                                            .map((item) =>
                                                DropdownMenuItem<BankDetail>(
                                                  value: item,
                                                  child: Text(
                                                      item.upiId == null
                                                          ? "${item.bankName} ${item.bankAccountNumber?.replaceAll("\\w(?=\\w{4})", "X")}"
                                                          : "UPI ID: ${item.upiId}",
                                                      style: textTheme.headline3
                                                          ?.copyWith(
                                                              color:
                                                                  whiteColor)),
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          // selectedBankName = value.name;
                                          selectedBankId = value.id;
                                          print(selectedBankId);
                                        },
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0.0,
                                          bottom: 24.0,
                                          left: 24.0,
                                          right: 24.0),
                                      child: TextFieldWidget(
                                        textEditingController: amount,
                                        hint: "Enter Token Quantity",
                                        type: 'withdraw',
                                        isRequired: true,
                                        isNumber: true,
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            profileController.tokenToRupee
                                                .value = (int.tryParse(value)! *
                                                    int.tryParse(homeController
                                                        .staticData[5]
                                                        .realValue!)!)
                                                .floor()
                                                .toString();
                                            profileController.rupeeToToken
                                                .value = (int.tryParse(value)! /
                                                    int.tryParse(homeController
                                                        .staticData[5].key!)!)
                                                .floor()
                                                .toString();
                                          } else {
                                            profileController
                                                .tokenToRupee.value = '0';
                                            profileController
                                                .rupeeToToken.value = '0';
                                          }
                                        },
                                      )),
                                  Row(
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
                                        style: textTheme.headline3
                                            ?.copyWith(color: whiteColor),
                                      ),
                                    ],
                                  ),
                                  CustomButton(
                                    top: 4.h,
                                    left: 20.w,
                                    right: 20.w,
                                    color: carminePinkColor,
                                    textColor: textWhiteColor,
                                    name:
                                        "Withdraw ₹ ${profileController.tokenToRupee}",
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        ConfirmationBottomDialog(
                                            textTheme: textTheme,
                                            confirmationWidget: SizedBox(
                                              child: Wrap(
                                                alignment: WrapAlignment.center,
                                                children: [
                                                  Text(
                                                    'Are you sure you want to withdraw ',
                                                    style: textTheme.headline3
                                                        ?.copyWith(
                                                            color:
                                                                textLightColor),
                                                  ),
                                                  TokenWidget(
                                                      size: 18,
                                                      text: Text(
                                                        profileController
                                                            .rupeeToToken.value,
                                                        style: textTheme
                                                            .headline3
                                                            ?.copyWith(
                                                                color:
                                                                    textLightColor),
                                                      )),
                                                  Text(
                                                      ' ( ₹${profileController.tokenToRupee.value} ) ',
                                                      style: textTheme.headline3
                                                          ?.copyWith(
                                                              color:
                                                                  aquaGreenColor)),
                                                  Text(
                                                    'from your Loby Wallet?',
                                                    style: textTheme.headline3
                                                        ?.copyWith(
                                                            color:
                                                                textLightColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            contentName:
                                                "Are you sure you want to withdraw From Your Loby Wallet?",
                                            yesBtnClick: () async {
                                              Navigator.pop(context);
                                              Helpers.loader();
                                              final isSuccess =
                                                  await profileController
                                                      .withdrawMoney(
                                                          bankDetailId:
                                                              selectedBankId,
                                                          amount: int.tryParse(
                                                              profileController
                                                                  .tokenToRupee
                                                                  .value));
                                              await profileController
                                                  .getProfile();
                                              Helpers.hideLoader();
                                              if (isSuccess) {
                                                amount.clear();
                                                profileController
                                                    .rupeeToToken.value = "0";
                                                profileController
                                                    .tokenToRupee.value = "0";
                                                BottomDialog(
                                                  textTheme: textTheme,
                                                  tileName: "Withdraw Success",
                                                  contentName:
                                                      "Amount has been successfully withdrawn. It will be credited to your account within 48 hours.",
                                                ).showBottomDialog(context);
                                              }
                                            }).showBottomDialog(context);
                                      }
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 16.0),
                                    child: Text(
                                        'Attention: Razorpay may charge a fee for receiving the earnings',
                                        textAlign: TextAlign.center,
                                        style: textTheme.headline6
                                            ?.copyWith(color: textWhiteColor)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        context.pushNamed(settlementRequestHistoryPage);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Text('View all Transactions',
                            textAlign: TextAlign.end,
                            style: textTheme.subtitle2
                                ?.copyWith(color: textWhiteColor)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 3.h,
                      bottom: 32.0,
                    ),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: CustomButton(
                          color: purpleLightIndigoColor,
                          textColor: textWhiteColor,
                          name: "Add New Withdraw Method",
                          onTap: () {
                            _addNewWithdrawMethodDialog(context, textTheme);
                          },
                        )),
                  ),
                ],
              ),
            ),
          );
        }
      }),
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
                    Navigator.of(context).pop();
                    _addBankDetailDialog(context, textTheme);
                  }),
                  SizedBox(height: 2.h),
                  _addBankDetailOption(textTheme, context, 'UPI ID', onTap: () {
                    Navigator.of(context).pop();
                    _addUPIDetailDialog(context, textTheme);
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
                      TextFieldWidget(
                        textEditingController: bankName,
                        title: "Bank Name",
                        titleColor: textWhiteColor,
                        isRequired: true,
                      ),
                      SizedBox(height: 2.h),
                      TextFieldWidget(
                        textEditingController: branchName,
                        title: "Branch Name",
                        titleColor: textWhiteColor,
                        isRequired: true,
                      ),
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
                      TextFieldWidget(
                        textEditingController: holderName,
                        title: "Account Holder Name",
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
                            if (_formKey2.currentState!.validate()) {
                              Helpers.loader();
                              final isSuccess =
                                  await profileController.addBankDetails(
                                bankName: bankName.text,
                                branchName: branchName.text,
                                accountNumber: accountNumber.text,
                                confirmAccountNumber: confirmAccountNumber.text,
                                ifscCode: ifscCode.text,
                                holderName: holderName.text,
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
                    TextFieldWidget(
                      textEditingController: holderName,
                      title: "Name",
                      titleColor: textWhiteColor,
                      isRequired: true,
                    ),
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
                              holderName: holderName.text,
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

  void clearAddBankDetails() {
    bankName.clear();
    branchName.clear();
    accountNumber.clear();
    confirmAccountNumber.clear();
    ifscCode.clear();
    holderName.clear();
    upiId.clear();
  }
}
