import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/main.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:sizer/sizer.dart';

class UserBannedScreen extends StatelessWidget {
  const UserBannedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return showAlertDialog();
  }

  Widget showAlertDialog() {
    final authController = Get.find<AuthController>();
    ProfileController profileController = Get.find<ProfileController>();
    return AlertDialog(
      backgroundColor: textTunaBlueColor,
      titlePadding: EdgeInsets.symmetric(
        horizontal: 18.w,
      ).copyWith(top: 2.h),
      title: Text(
        'Account Banned',
        style: TextStyle(
          color: textWhiteColor,
          fontSize: 14.spa,
          fontWeight: FontWeight.w500,
        ),
      ),
      alignment: Alignment.center,
      content: Text(
        'Unfortunately, due to conflict with Loby Guidelines & Terms of Use this account has been banned for ${DateTime.now().differenceInDays(profileController.profile.banTill ?? DateTime.now().add(Duration(days: 3)))}-days. Please try logging in after remaining time.',
        style: TextStyle(
          color: textWhiteColor,
        ),
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          onPressed: () async {
            await authController.logout();
            contextKey.currentContext!.goNamed(loginPage);
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color>(textErrorColor),
            minimumSize:
                WidgetStatePropertyAll<Size>(Size(double.infinity, 60)),
          ),
          child: Text(
            'OK',
            style: TextStyle(
              color: textWhiteColor,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
