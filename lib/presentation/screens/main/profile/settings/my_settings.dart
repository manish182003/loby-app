import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/main.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/screens/main/profile/widgets/profile_options.dart';
import 'package:loby/presentation/widgets/custom_app_bar.dart';
import 'package:sizer/sizer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final profileController = Get.find<ProfileController>();
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar:
          appBar(context: context, appBarName: "Settings", isBackIcon: true),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          ProfileOptionsWidget(
            name: "Delete Account",
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return showAlertDialog();
                },
              );
            },
          ),
        ],
      ),
    ));
  }

  Widget showAlertDialog() {
    return AlertDialog(
      backgroundColor: textTunaBlueColor,
      titlePadding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ).copyWith(top: 2.h),
      title: Text(
        'Delete Account',
        style: TextStyle(
          color: textWhiteColor,
          fontSize: 14.spa,
          fontWeight: FontWeight.w500,
        ),
      ),
      alignment: Alignment.center,
      content: Text(
        'Sorry to see you leave us. Please note that if you change your mind within 7-days, you can re-activate this account. This account will pe permanently deleted after 7-days.',
        style: TextStyle(
          color: textWhiteColor,
        ),
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        ElevatedButton(
          onPressed: () {
            authController.deleteAccount(userId: profileController.profile.id!);
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color>(textErrorColor),
          ),
          child: Text(
            'Delete',
            style: TextStyle(
              color: textWhiteColor,
              fontSize: 18,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            contextKey.currentContext?.pop();
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color>(aquaGreenColor),
          ),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: textWhiteColor,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
