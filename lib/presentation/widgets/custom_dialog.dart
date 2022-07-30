import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../core/theme/colors.dart';
import 'follow_btn.dart';

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 0.0),
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      // height: MediaQuery.of(context).size.height - 60,
      margin: const EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: <Widget>[
          Stack(
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
                    color: backgroundDarkJungleGreenColor,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.08.h,
                          child: Text('Update Status',
                              textAlign: TextAlign.center,
                              style: textTheme.headline2
                                  ?.copyWith(color: textWhiteColor)),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01.h,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: SvgPicture.asset(
                                'assets/icons/increase_icon.svg',
                                height: 18,
                                width: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Card(
                  color: backgroundBalticSeaColor,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 0.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1,
                      decoration: BoxDecoration(
                        color: backgroundBalticSeaColor,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/verified_user_bedge.svg',
                                    height: 15,
                                    width: 15,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text("Order Placed",
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.headline6
                                          ?.copyWith(color: textWhiteColor)),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Text("May 26, 2022 18:23:43",
                                        overflow: TextOverflow.ellipsis,
                                        style: textTheme.headline6?.copyWith(
                                            color: textLightColor)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Button(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height: 36,
                                      onPress: () {
                                        debugPrint('update');
                                      },
                                      txtPadding: 8.0,
                                      btnBgColor: orangeColor,
                                      txtColor: textWhiteColor,
                                      borderRadius: 2.h,
                                      btnName: 'Reject Order',
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Button(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height: 36,
                                      onPress: () {
                                        debugPrint('update');
                                      },
                                      txtPadding: 8.0,
                                      btnBgColor: purpleLightIndigoColor,
                                      txtColor: textWhiteColor,
                                      borderRadius: 2.h,
                                      btnName: 'Accept Order',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              SizedBox(
                                  child: RichText(
                                      textAlign: TextAlign.start,
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text:
                                              'Sellers are requsted to discuss & freeze all delivery details with buyer on ',
                                          style: textTheme.subtitle1
                                              ?.copyWith(color: textLightColor),
                                        ),
                                        TextSpan(
                                            text: 'Loby Chat ',
                                            style: textTheme.subtitle1
                                                ?.copyWith(
                                                    color: aquaGreenColor)),
                                        TextSpan(
                                            text:
                                                'before accpecting or declining the Order. Any conversation outside Loby Chat will not be insured/covered by Loby Protection',
                                            style: textTheme.subtitle1
                                                ?.copyWith(
                                                    color: textLightColor)),
                                      ]))),
                              const SizedBox(height: 16.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/verified_user_bedge.svg',
                                    height: 15,
                                    width: 15,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text("Seller Accepted",
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.headline6
                                          ?.copyWith(color: textWhiteColor)),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Text("May 26, 2022 18:23:43",
                                        overflow: TextOverflow.ellipsis,
                                        style: textTheme.headline6?.copyWith(
                                            color: textLightColor)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/verified_user_bedge.svg',
                                    height: 15,
                                    width: 15,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text("Order in Progress",
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.headline6
                                          ?.copyWith(color: textWhiteColor)),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Text("May 26, 2022 18:23:43",
                                        overflow: TextOverflow.ellipsis,
                                        style: textTheme.headline6?.copyWith(
                                            color: textLightColor)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              Button(
                                width: MediaQuery.of(context).size.width * 1,
                                onPress: () {
                                  debugPrint('update');
                                },
                                txtPadding: 8.0,
                                btnBgColor: purpleLightIndigoColor,
                                txtColor: textWhiteColor,
                                borderRadius: 1.2.h,
                                btnName: 'Upload Proofs & Confirm Delivery',
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/verified_user_bedge.svg',
                                    height: 15,
                                    width: 15,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text("Seller Delivery Confirmed ",
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.headline6
                                          ?.copyWith(color: textWhiteColor)),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/verified_user_bedge.svg',
                                    height: 15,
                                    width: 15,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width -
                                                30.w),
                                    child: Text(
                                        "Buyer Declined Delivery. Kindly resolve & ask buyer to re-confirm.",
                                        style: textTheme.headline6
                                            ?.copyWith(color: textWhiteColor)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/verified_user_bedge.svg',
                                    height: 15,
                                    width: 15,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text("Buyer Delivery Confirmed",
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.headline6
                                          ?.copyWith(color: textWhiteColor)),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/verified_user_bedge.svg',
                                    height: 15,
                                    width: 15,
                                    color: iconWhiteColor,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text("Transaction Complete",
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.headline6
                                          ?.copyWith(color: textWhiteColor)),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/verified_user_bedge.svg',
                                    height: 15,
                                    width: 15,
                                    color: iconWhiteColor,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text("Loby Protection Period - ",
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.headline6
                                          ?.copyWith(color: textWhiteColor)),
                                  Expanded(
                                    child: Text("6 Days Remaining",
                                        overflow: TextOverflow.ellipsis,
                                        style: textTheme.headline6?.copyWith(
                                            color: textLightColor)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/verified_user_bedge.svg',
                                    height: 15,
                                    width: 15,
                                    color: iconWhiteColor,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text("Order Completed",
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.headline6
                                          ?.copyWith(color: textWhiteColor)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
