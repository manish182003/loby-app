import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/presentation/getx/controllers/kyc_controller.dart';
import 'package:loby/presentation/getx/controllers/order_controller.dart';
import 'package:loby/presentation/screens/main/profile/my_order/all_orders_screen.dart';
import 'package:loby/presentation/widgets/buttons/custom_button.dart';
import 'package:loby/presentation/widgets/custom_app_bar.dart';
import 'package:loby/presentation/widgets/text_fields/text_field_widget.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import 'package:loby/domain/entities/kyc/get_kyc_token.dart';

import 'package:loby/core/utils/helpers.dart';
import 'package:loby/presentation/getx/controllers/home_controller.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';

class UpiScreen extends StatefulWidget {
  // final GetKycToken geTKyctoken;
  const UpiScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UpiScreen> createState() => _UpiScreenState();
}

class _UpiScreenState extends State<UpiScreen>
    with SingleTickerProviderStateMixin {
  KycController kycController = Get.find<KycController>();
  late TabController _tabController;
  int _currentTabIndex = 0;
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
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        color: butterflyBlueColor,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  "Add Withdraw Details",
                  style: textTheme.headline1?.copyWith(color: textWhiteColor),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
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
              ],
            ),
          ],
        ),
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
