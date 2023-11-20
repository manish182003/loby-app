import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/presentation/getx/controllers/kyc_controller.dart';
import 'package:loby/presentation/getx/controllers/order_controller.dart';
import 'package:loby/presentation/screens/main/profile/my_order/all_orders_screen.dart';
import 'package:loby/presentation/widgets/buttons/custom_button.dart';
import 'package:loby/presentation/widgets/custom_app_bar.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:loby/domain/entities/kyc/get_kyc_token.dart';

class MyKycScreen extends StatefulWidget {
  final GetKycToken? geTKyctoken;
  const MyKycScreen({
    Key? key,
    this.geTKyctoken
  }) : super(key: key);

  @override
  State<MyKycScreen> createState() => _MyKycScreenState();
}

class _MyKycScreenState extends State<MyKycScreen>
    with SingleTickerProviderStateMixin {
  KycController kycController = Get.find<KycController>();
  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getKycToken();

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

  Future<void> getKycToken() async {
    kycController.getKycToken();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: backgroundDarkJungleGreenColor,
      appBar: appBar(context: context, appBarName: "KYC Verification"),
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
                        color: lightGreyColor,
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
                  "Identity Proof",
                  style: textTheme.headline1?.copyWith(color: textWhiteColor),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Enter Your Registered Aadhar Number",
                  style: textTheme.headline4?.copyWith(
                      color: textWhiteColor, fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    maxLength: 12,
                    controller: kycController.aadharNumbercontroller.value,
                    textAlign: TextAlign.center,
                    style: textTheme.headline2?.copyWith(color: textWhiteColor),
                    decoration: InputDecoration(
                      counterText: "",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: textCharcoalBlueColor)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: textCharcoalBlueColor)),
                      // suffixIcon: IconButton(
                      //   icon: Icon(Icons.access_time),
                      //   onPressed: () => _selectFromTimePick(context),
                      // ),
                    ),
                  ),
                ),
              ],
            ),
            CustomButton(
                name: "Next",
                textColor: textWhiteColor,
                color: purpleLightIndigoColor,
                left: 4.w,
                right: 4.w,
                bottom: 5.h,
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  kycController
                      .sendKycOtp(
                          kycToken: prefs.getString("kycToken"),
                          aadharNumber: kycController
                              .aadharNumbercontroller.value.text
                              .trim())
                      .then((value) {
                    if (value) {
                      context.pushNamed(sendOtppage);
                    }
                  });
                }),
          ],
        ),
      ),
    );
  }
}
