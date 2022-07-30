import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../services/routing_service/routes_name.dart';
import '../../../../widgets/custom_button.dart';

class MyWalletScreen extends StatefulWidget {
  const MyWalletScreen({Key? key}) : super(key: key);

  @override
  State<MyWalletScreen> createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
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
                        'Wallet',
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
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          color: aquaGreenColor,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 1.h),
                          child: Text('Balance',
                              textAlign: TextAlign.center,
                              style: textTheme.headline3
                                  ?.copyWith(color: textTunaBlueColor)),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: Card(
                      color: backgroundBalticSeaColor,
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 0.22,
                          decoration: BoxDecoration(
                            color: backgroundBalticSeaColor,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 16.0, top: 8.0),
                                child: Text('₹ 25,000',
                                    textAlign: TextAlign.center,
                                    style: textTheme.headlineLarge
                                        ?.copyWith(color: aquaGreenColor)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      child: CustomButton(
                                        color: purpleLightIndigoColor,
                                        textColor: textWhiteColor,
                                        name: "Add Funds",
                                        onTap: () {
                                          context.pushNamed(addFundScreenPage);
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      child: CustomButton(
                                        color: orangeColor,
                                        textColor: textWhiteColor,
                                        name: "Withdraw",
                                        onTap: () {
                                          context.pushNamed(
                                              withdrawFundScreenPage);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ],
              )),
          GestureDetector(
            onTap: () {
              /*Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const TransactionHistoryScreen()));*/
              context.pushNamed(transactionHistoryPage);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text('View all Transactions',
                  textAlign: TextAlign.end,
                  style: textTheme.subtitle2?.copyWith(color: textWhiteColor)),
            ),
          ),
          const SizedBox(height: 8.0),
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
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          color: aquaGreenColor,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 1.h),
                          child: Text('Loby Coins',
                              textAlign: TextAlign.center,
                              style: textTheme.headline3
                                  ?.copyWith(color: textTunaBlueColor)),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: Card(
                      color: backgroundBalticSeaColor,
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 0.22,
                          decoration: BoxDecoration(
                            color: backgroundBalticSeaColor,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 16.0, top: 8.0),
                                child: Text('500',
                                    textAlign: TextAlign.center,
                                    style: textTheme.headlineLarge
                                        ?.copyWith(color: aquaGreenColor)),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: CustomButton(
                                  color: purpleLightIndigoColor,
                                  textColor: textWhiteColor,
                                  name: "Redeem",
                                  onTap: () {
                                    debugPrint('click chat');
                                  },
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Text('View all Transactions',
                textAlign: TextAlign.end,
                style: textTheme.subtitle2?.copyWith(color: textWhiteColor)),
          ),
        ],
      ),
    );
  }
}
