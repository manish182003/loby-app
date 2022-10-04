import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/profile/bank_detail.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/widgets/text_fields/custom_drop_down.dart';
import 'package:loby/presentation/widgets/text_fields/text_field_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../widgets/bottom_dialog_widget.dart';
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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.getBankDetails();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    return Scaffold(
      appBar: appBar(context: context, appBarName: "Withdraw Funds"),
      body: Obx(() {
        if (profileController.isBankDetailsFetching.value) {
          return const CustomLoader();
        } else {
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Stack(
                      children: [
                        Card(
                          color: shipGreyColor,
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 1,
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
                                        if(profileController.isProfileFetching.value){
                                          return const CustomLoader();
                                        }else{
                                          return Text(
                                              '₹ ${profileController.profile
                                                  .walletMoney}',
                                              textAlign: TextAlign.center,
                                              style: textTheme.headlineLarge
                                                  ?.copyWith(
                                                  color: textTunaBlueColor,
                                                  fontFamily: 'Inter'));
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 1,
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
                                        itemsList: profileController
                                            .bankDetails
                                            .map((item) =>
                                            DropdownMenuItem<BankDetail>(
                                              value: item,
                                              child: Text(
                                                  item.upiId == null
                                                      ? "${item
                                                      .bankName} ${item
                                                      .bankAccountNumber
                                                      ?.replaceAll(
                                                      "\\w(?=\\w{4})", "X")}"
                                                      : "UPI ID: ${item
                                                      .upiId}",
                                                  style: textTheme.headline3
                                                      ?.copyWith(
                                                      color: whiteColor)
                                              ),
                                            )).toList(),
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
                                        hint: "Enter Amount(INR)",
                                        type: 'withdraw',
                                        isRequired: true,
                                        isNumber: true,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 16.0,
                                      right: 16.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.35,
                                          child: CustomButton(
                                            color: carminePinkColor,
                                            textColor: textWhiteColor,
                                            name: "Withdraw",
                                            onTap: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                Helpers.loader();
                                                final isSuccess = await profileController
                                                    .withdrawMoney(
                                                    bankDetailId: selectedBankId,
                                                    amount: int.tryParse(
                                                        amount.text));
                                                await profileController
                                                    .getProfile();
                                                Helpers.hideLoader();
                                                if (isSuccess) {
                                                  BottomDialog(
                                                    textTheme: textTheme,
                                                    tileName: "Withdraw Success",
                                                    contentName: "Amount has been successfully withdrawn. It will be credited to your account within 48 hours.",)
                                                      .showBottomDialog(
                                                      context);
                                                }
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 16.0),
                                    child: Text(
                                        'Minimum Account Balance to maintain in your Wallet is Rs. 200',
                                        textAlign: TextAlign.center,
                                        style: textTheme.headline5?.copyWith(
                                            color: textWhiteColor)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      bottom: 32.0,
                    ),
                    child: SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.7,
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
                      style: textTheme.headline4?.copyWith(
                          color: textWhiteColor)),
                  SizedBox(height: 4.h),
                  _addBankDetailOption(
                      textTheme, context, 'Bank Account', onTap: () {
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
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0)),
          child: SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height,
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
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.35,
                        child: CustomButton(
                          color: purpleLightIndigoColor,
                          textColor: textWhiteColor,
                          name: "Add",
                          onTap: () async {
                            if (_formKey2.currentState!.validate()) {
                              Helpers.loader();
                              final isSuccess = await profileController
                                  .addBankDetails(
                                bankName: bankName.text,
                                branchName: branchName.text,
                                accountNumber: accountNumber.text,
                                confirmAccountNumber: confirmAccountNumber.text,
                                ifscCode: ifscCode.text,
                                holderName: holderName.text,
                                type: "bank_account",
                              );
                              Helpers.hideLoader();
                              if (isSuccess) {
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
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0)),
          child: SizedBox(
            height: 25.h,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFieldWidget(
                    textEditingController: upiId,
                    title: "Add UPI ID",
                    titleColor: textWhiteColor,
                    isRequired: true,
                  ),
                  SizedBox(height: 2.h),
                  SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.35,
                    child: CustomButton(
                      color: purpleLightIndigoColor,
                      textColor: textWhiteColor,
                      name: "Add",
                      onTap: () async {
                        Helpers.loader();
                        final isSuccess = await profileController
                            .addBankDetails(
                          upiId: upiId.text,
                          type: "vpa",
                        );
                        Helpers.hideLoader();
                        if (isSuccess) {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _addBankDetailOption(TextTheme textTheme, BuildContext context,
      String title, {Function()? onTap}) {
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
}
