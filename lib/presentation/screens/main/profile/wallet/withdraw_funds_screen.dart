import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../widgets/bottom_dialog_widget.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/drop_down.dart';
import '../../../../widgets/input_text_title_widget.dart';
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
        crossAxisAlignment: CrossAxisAlignment.center,
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
                                style: textTheme.headline3
                                    ?.copyWith(color: textTunaBlueColor)),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 16.0),
                              child: Text('₹ 25,000',
                                  textAlign: TextAlign.center,
                                  style: textTheme.headlineLarge
                                      ?.copyWith(color: textTunaBlueColor)),
                            ),
                          ],
                        ),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 110.0),
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 24.0, horizontal: 24.0),
                              child: MyDropDownWidget()),
                          const Padding(
                              padding: EdgeInsets.only(
                                  top: 0.0,
                                  bottom: 24.0,
                                  left: 24.0,
                                  right: 24.0),
                              child: InputTextWidget(
                                hintName: 'Enter Amount (INR)',
                                keyboardType: TextInputType.number,
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                            ),
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
                                      BottomDialog(
                                              textTheme: textTheme,
                                              contentName:
                                                  "Are you sure you want to withdraw ",
                                              contentLinkName: 'Rs. 23,000',
                                              contentNameLast:
                                                  ' from you Loby Wallet ?')
                                          .showBottomDialog(context);
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
          Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
            ),
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: CustomButton(
                  color: purpleLightIndigoColor,
                  textColor: textWhiteColor,
                  name: "Add New Withdraw Method",
                  onTap: () {
                    debugPrint('gddfdfdfd');
                    AddWithWithdrawMethodDialog(context, textTheme);
                  },
                )),
          ),
        ],
      ),
    );
  }

  void AddWithWithdrawMethodDialog(BuildContext context, TextTheme textTheme) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: backgroundDarkJungleGreenColor,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Container(
            height: 190,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Add Withdraw Method',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.headline4
                          ?.copyWith(color: textWhiteColor)),
                  const SizedBox(height: 16),
                  buildAddBankDetailItem(textTheme, context, 'Bank Account'),
                  const SizedBox(height: 16),
                  buildAddUPIItem(textTheme, context, 'UPI ID',),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void AddBankDetailDialog(BuildContext context, TextTheme textTheme) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: backgroundDarkJungleGreenColor,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.62,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const InputTextTitleWidget(
                        titleName: 'Account Number',
                        titleTextColor: textWhiteColor),
                    SizedBox(
                      width: double.infinity,
                      height: 16,
                    ),
                    const InputTextWidget(hintName: ''),
                    SizedBox(
                      width: double.infinity,
                      height: 16,
                    ),
                    const InputTextTitleWidget(
                        titleName: 'Re-enter Account Number',
                        titleTextColor: textWhiteColor),
                    SizedBox(
                      width: double.infinity,
                      height: 16,
                    ),
                    const InputTextWidget(hintName: ''),
                    SizedBox(
                      width: double.infinity,
                      height: 16,
                    ),
                    const InputTextTitleWidget(
                        titleName: 'IFSC Code',
                        titleTextColor: textWhiteColor),
                    SizedBox(
                      width: double.infinity,
                      height: 16,
                    ),
                    const InputTextWidget(hintName: ''),
                    SizedBox(
                      width: double.infinity,
                      height: 16,
                    ),
                    const InputTextTitleWidget(
                        titleName: 'Acounter Holder Name',
                        titleTextColor: textWhiteColor),
                    SizedBox(
                      width: double.infinity,
                      height: 16,
                    ),
                    const InputTextWidget(hintName: ''),
                    SizedBox(
                      width: double.infinity,
                      height: 16,
                    ),
                    SizedBox(
                      width:
                      MediaQuery.of(context).size.width * 0.35,
                      child: CustomButton(
                        color: purpleLightIndigoColor,
                        textColor: textWhiteColor,
                        name: "Add",
                        onTap: () {
                          Navigator.of(context).pop();
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

  void AddUPIDetailDialog(BuildContext context, TextTheme textTheme) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: backgroundDarkJungleGreenColor,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Container(
            height: 190,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const InputTextTitleWidget(
                      titleName: 'Add UPI ID',
                      titleTextColor: textWhiteColor),
                  SizedBox(
                    width: double.infinity,
                    height: 16,
                  ),
                  const InputTextWidget(hintName: ''),
                  SizedBox(
                    width: double.infinity,
                    height: 16,
                  ),
                  SizedBox(
                    width:
                    MediaQuery.of(context).size.width * 0.35,
                    child: CustomButton(
                      color: purpleLightIndigoColor,
                      textColor: textWhiteColor,
                      name: "Add",
                      onTap: () {
                        Navigator.of(context).pop();
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

  Widget buildAddBankDetailItem(TextTheme textTheme, BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        AddBankDetailDialog(context, textTheme);
      },
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 45,
          minWidth: double.infinity,
        ),
        decoration: BoxDecoration(
          color: backgroundBalticSeaColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
          child: Text(title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: textTheme.headline6
                  ?.copyWith(color: textWhiteColor)),
        ),
      ),
    );
  }

  Widget buildAddUPIItem(TextTheme textTheme, BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        AddUPIDetailDialog(context, textTheme);
      },
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 45,
          minWidth: double.infinity,
        ),
        decoration: BoxDecoration(
          color: backgroundBalticSeaColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
          child: Text(title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: textTheme.headline6
                  ?.copyWith(color: textWhiteColor)),
        ),
      ),
    );
  }

  /*void AddWithWithdrawMethodDialog(BuildContext context, TextTheme textTheme) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: backgroundDarkJungleGreenColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Container(
            height: 220,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildItem(textTheme, context, 'HDFC Bank  XXXX1011'),
                  const SizedBox(height: 16),
                  buildItem(
                      textTheme,
                      context,
                      'ICICI Bank  XXXX2340',),
                  const SizedBox(height: 16),
                  buildItem(
                    textTheme,
                    context,
                    'UPI ID: 2010afzalkhan-1@okhdfcbank',),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildItem(TextTheme textTheme, BuildContext context, String title,) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 45,
        minWidth: double.infinity,
      ),
      decoration: BoxDecoration(
        color: backgroundBalticSeaColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
        child: Text(title,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: textTheme.headline6
                ?.copyWith(color: textWhiteColor)),
      ),
    );
  }*/
}
