import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/drop_down.dart';
import '../../../../widgets/input_text_widget.dart';

class WithdrawFundsScreen extends StatefulWidget {
  const WithdrawFundsScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawFundsScreen> createState() => _WithdrawFundsScreenState();
}

class _WithdrawFundsScreenState extends State<WithdrawFundsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: body(),
      ),
    );
  }

  Widget body() {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 7.h,
                  height: 7.h,
                  child: MaterialButton(
                    shape: const CircleBorder(),
                    color: backgroundBalticSeaColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset(
                      'assets/icons/back_icon.svg',
                      color: whiteColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 8.0),
                      child: Text(
                        'Withdraw Funds',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.headline2
                            ?.copyWith(color: textWhiteColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Card(
                  color: backgroundBalticSeaColor,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                        color: aquaGreenColor,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 1.h),
                        child: Column(
                          children: [
                            Text('Current Balance',
                                textAlign: TextAlign.center,
                                style: textTheme.headline3
                                    ?.copyWith(color: textTunaBlueColor)),

                            Text('₹ 25,000',
                                textAlign: TextAlign.center,
                                style: textTheme.headlineLarge
                                    ?.copyWith(color: textTunaBlueColor)),
                          ],
                        ),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.h),
                  child: Card(
                    color: backgroundBalticSeaColor,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1,
                      decoration: BoxDecoration(
                        color: backgroundBalticSeaColor,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                              padding:
                              EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                              child: MyDropDownWidget()
                          ),
                          const Padding(
                              padding:
                              EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                              child: InputTextWidget(hintName: 'Enter Amount (INR)',)
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0,),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width:
                                  MediaQuery.of(context).size.width * 0.35,
                                  child: CustomButton(
                                    color: carminePinkColor,
                                    textColor: textWhiteColor,
                                    name: "Withdraw",
                                    onTap: () {
                                      debugPrint('click chat');
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal:16.0),
                            child: Text('Minimum Account Balance to maintain in your Wallet is Rs. 200',
                                textAlign: TextAlign.center,
                                style: textTheme.headline5
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
        ],
      ),
    );
  }
}
