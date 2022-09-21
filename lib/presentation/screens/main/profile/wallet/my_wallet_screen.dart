import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/widgets/body_padding_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../services/routing_service/routes_name.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/buttons/custom_button.dart';

class MyWalletScreen extends StatefulWidget {
  const MyWalletScreen({Key? key}) : super(key: key);

  @override
  State<MyWalletScreen> createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {

  ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: appBar(context: context, appBarName: "Wallet"),
        body: SingleChildScrollView(
          child: BodyPaddingWidget(
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
                          height: 90.0,
                          decoration: BoxDecoration(
                            color: aquaGreenColor,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Text('Balance',
                                textAlign: TextAlign.center,
                                style: textTheme.headline3
                                    ?.copyWith(color: textTunaBlueColor, fontWeight: FontWeight.w500)),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 44.0),
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
                              padding: const EdgeInsets.only(
                                  bottom: 16.0, top: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                                    child: Text("₹ ${profileController.profile.walletMoney}",
                                        textAlign: TextAlign.center,
                                        style: textTheme.headlineLarge
                                            ?.copyWith(
                                            color: aquaGreenColor)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0.0, horizontal: 16.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.35,
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
                                          width: MediaQuery.of(context).size.width * 0.35,
                                          child: CustomButton(
                                            color: carminePinkColor,
                                            textColor: textWhiteColor,
                                            name: "Withdraw",
                                            onTap: () {
                                              context.pushNamed(withdrawFundScreenPage);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h,),
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
                        style: textTheme.subtitle2
                            ?.copyWith(color: textWhiteColor)),
                  ),
                ),
                SizedBox(height: 5.h,),
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
                          height: 90,
                          decoration: BoxDecoration(
                            color: aquaGreenColor,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 12.0),
                            child: Text('Loby Coins',
                                textAlign: TextAlign.center,
                                style: textTheme.headline3
                                    ?.copyWith(color: textTunaBlueColor)),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 44.0),
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
                              padding: const EdgeInsets.only(
                                  bottom: 16.0, top: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: Text('${profileController.profile.lobbyCoins}',
                                        textAlign: TextAlign.center,
                                        style: textTheme.headlineLarge
                                            ?.copyWith(
                                            color: aquaGreenColor)),
                                  ),
                                  SizedBox(
                                    width:
                                    MediaQuery.of(context).size.width *
                                        0.3,
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
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h,),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text('View all Transactions',
                      textAlign: TextAlign.end,
                      style: textTheme.subtitle2?.copyWith(color: textWhiteColor)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
