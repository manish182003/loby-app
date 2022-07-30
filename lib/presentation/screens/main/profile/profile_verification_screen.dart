import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/colors.dart';
import '../../../widgets/bottom_dialog_widget.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/input_text_title_widget.dart';
import '../../../widgets/input_text_widget.dart';

class ProfileVerificationScreen extends StatefulWidget {
  const ProfileVerificationScreen({Key? key}) : super(key: key);

  @override
  State<ProfileVerificationScreen> createState() =>
      _ProfileVerificationScreenState();
}

class _ProfileVerificationScreenState extends State<ProfileVerificationScreen> {
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
                      FocusScope.of(context).unfocus();
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
                        'Profile Verification',
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
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                      textAlign: TextAlign.start,
                      "Get your profile verified if you are an gaming influncer, esports athlete or a content creator",
                      style: textTheme.headline5?.copyWith(color: orangeColor)),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 4.h,
                ),
                const InputTextTitleWidget(
                    titleName: 'IGN / Display Name',
                    titleTextColor: textWhiteColor),
                SizedBox(
                  width: double.infinity,
                  height: 2.h,
                ),
                const InputTextWidget(hintName: ''),
                SizedBox(
                  width: double.infinity,
                  height: 4.h,
                ),
                const InputTextTitleWidget(
                    titleName: 'Message', titleTextColor: textWhiteColor),
                SizedBox(
                  width: double.infinity,
                  height: 2.h,
                ),
                const InputTextWidget(hintName: ''),
                SizedBox(
                  width: double.infinity,
                  height: 4.h,
                ),
                const InputTextTitleWidget(
                    titleName: 'Youtube Link',
                    titleTextColor: textWhiteColor),
                SizedBox(
                  width: double.infinity,
                  height: 2.h,
                ),
                const InputTextWidget(hintName: ''),
                SizedBox(
                  width: double.infinity,
                  height: 4.h,
                ),
                const InputTextTitleWidget(
                    titleName: 'Twitch Link',
                    titleTextColor: textWhiteColor),
                SizedBox(
                  width: double.infinity,
                  height: 2.h,
                ),
                const InputTextWidget(hintName: ''),
                SizedBox(
                  width: double.infinity,
                  height: 4.h,
                ),
                const InputTextTitleWidget(
                    titleName: 'Instagram Link',
                    titleTextColor: textWhiteColor),
                SizedBox(
                  width: double.infinity,
                  height: 2.h,
                ),
                const InputTextWidget(hintName: ''),
                SizedBox(
                  width: double.infinity,
                  height: 4.h,
                ),
                const InputTextTitleWidget(
                    titleName: 'Upload Documents',
                    titleTextColor: textWhiteColor),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                      textAlign: TextAlign.start,
                      "Please upload a photo with your passport / ID & your selfie",
                      style:
                          textTheme.headline6?.copyWith(color: textLightColor)),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.2,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        // This controls the shadow
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 5,
                              color: Colors.black.withAlpha(50))
                        ],
                        borderRadius: BorderRadius.circular(12),
                        color:
                            textFieldColor, // This would be color of the Badge
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/id_card_icon.svg',
                              width: 5.h,
                              height: 5.h,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Text('Copy of your passport or ID card',
                                textAlign: TextAlign.center,
                                style: textTheme.subtitle1
                                    ?.copyWith(color: textLightColor)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.2,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        // This controls the shadow
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 5,
                              color: Colors.black.withAlpha(50))
                        ],
                        borderRadius: BorderRadius.circular(12),
                        color:
                            textFieldColor, // This would be color of the Badge
                      ),
                      // This is your Badge
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/camera_icon.svg',
                              width: 5.h,
                              height: 5.h,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Text('Selfie',
                                textAlign: TextAlign.center,
                                style: textTheme.subtitle1
                                    ?.copyWith(color: textLightColor)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 8.h,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: CustomButton(
                      color: aquaGreenColor,
                      name: "Submit",
                      textColor: primaryTextColor,
                      onTap: () {
                        BottomDialog(
                                textTheme: textTheme,
                                tileName: "Congratulations",
                                titleColor: aquaGreenColor,
                                contentName:
                                    "Your service has been successfully listed. You can edit your listings from My Listings.",
                                contentLinkName: ' My Listings')
                            .showBottomDialog(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
