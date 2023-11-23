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
import 'package:flutter/services.dart';

class MyKycScreen extends StatefulWidget {
  final GetKycToken? geTKyctoken;
  const MyKycScreen({Key? key, this.geTKyctoken}) : super(key: key);

  @override
  State<MyKycScreen> createState() => _MyKycScreenState();
}

class _MyKycScreenState extends State<MyKycScreen>
    with SingleTickerProviderStateMixin {
  KycController kycController = Get.find<KycController>();
  late TabController _tabController;
  int _currentTabIndex = 0;
  String formattedText = '';

  // final aadharNumberFormatter = MaskTextInputFormatter(
  //   mask: '#### #### ####', // Define the format
  //   filter: {"#": RegExp(r'[0-9]')}, // Allow only numeric input
  // );

  @override
  void initState() {
    super.initState();

    getKycToken();
  }

  Future<void> getKycToken() async {
    kycController.getKycToken();
  }

  String formatNumber(int number) {
    String numberString = number.toString();
    List<String> chunks = [];

    for (int i = numberString.length; i > 0; i -= 4) {
      int start = (i - 4 > 0) ? i - 4 : 0;
      int end = i;
      chunks.add(numberString.substring(start, end));
    }

    return chunks.reversed.join(' ');
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
                    // inputFormatters: [formatNumber()],
                    keyboardType: TextInputType.number,
                    maxLength: 12,
                    controller: kycController.aadharNumbercontroller.value,
                    textAlign: TextAlign.center,
                    // onChanged: (text) {
                    //   // Format the input as the user types
                    //   String formattedText = formatNumber(int.parse(text));
                    //   // Update the controller to display the formatted text
                    //   // kycController
                    //   //                     .aadharNumbercontroller.value.text = TextEditingValue(
                    //   //   text: formattedText,

                    //   // );
                    //   kycController.aadharNumbercontroller.value =
                    //       TextEditingController(text: formattedText);
                    //   kycController.aadharNumbercontroller.refresh();
                    // },
                    style: textTheme.headline2?.copyWith(
                      color: textWhiteColor,
                    ),
                    decoration: InputDecoration(
                      fillColor: textTunaBlueColor,
                      counterText: "",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: textCharcoalBlueColor)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: textCharcoalBlueColor)),
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
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  kycController
                      .sendKycOtp(
                          kycToken: prefs.getString("kycToken"),
                          aadharNumber: kycController
                              .aadharNumbercontroller.value.text
                              .replaceAll(" ", ""))
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

// String formatNumber(int number) {
//   String numberString = number.toString();
//   List<String> chunks = [];

//   for (int i = numberString.length; i > 0; i -= 4) {
//     int start = (i - 4 > 0) ? i - 4 : 0;
//     int end = i;
//     chunks.add(numberString.substring(start, end));
//   }

//   return chunks.reversed.join(' ');
// }
