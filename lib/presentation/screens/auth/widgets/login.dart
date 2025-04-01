import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/screens/auth/widgets/create_profile_bottom_sheet.dart';
import 'package:loby/presentation/widgets/buttons/custom_button.dart';
import 'package:loby/presentation/widgets/custom_bottom_sheet.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/body_padding_widget.dart';
import '../../../widgets/text_fields/text_field_widget.dart';
import 'forgot_password.dart';
import 'otp_dialog.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthController authController = Get.find<AuthController>();
  ProfileController profileController = Get.find<ProfileController>();
  final _formKey = GlobalKey<FormState>();
  bool visible = false;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController otp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BodyPaddingWidget(
      child: Form(
        key: _formKey,
        child: Column(children: [
          Text('Login',
              style: textTheme.displayMedium?.copyWith(color: textWhiteColor)),
          SizedBox(
            height: 4.h,
          ),
          TextFieldWidget(
            textEditingController: email,
            type: "email",
            title: "Email Address",
            isRequired: true,
            scrollBottomPadding: 20,
          ),
          SizedBox(
            height: 3.h,
          ),
          TextFieldWidget(
            textEditingController: password,
            type: "password",
            title: "Password",
            isRequired: true,
          ),
          SizedBox(
            height: 1.h,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  _showForgotPasswordBottomSheet(context);
                },
                child: Text('Forgot Password ?',
                    style: textTheme.headlineSmall
                        ?.copyWith(color: aquaGreenColor))),
          ),
          SizedBox(
            height: 4.h,
          ),
          CustomButton(
            color: aquaGreenColor,
            name: "Login",
            left: 15.w,
            right: 15.w,
            onTap: () async {
              // if (_formKey.currentState!.validate()) {
              //   Helpers.loader();
              //   final isSuccess = await authController.login(email: email.text, password: password.text);
              //   if(isSuccess){
              //     await profileController.getProfile();
              //     if(profileController.profile.emailVerified == 'N' || profileController.profile.emailVerified == null){
              //       // final isSuccess = await authController.sendAndVerifyOTP(email: email.text);
              //       // Helpers.hideLoader();
              //       // if(isSuccess){
              //       //   _otpDialog(context);
              //       // }
              //       _showCreateProfileBottomSheet(context);
              //     }else if(profileController.profile.displayName == null){
              //       Helpers.hideLoader();
              //       Navigator.pop(context);
              //       _showCreateProfileBottomSheet(context);
              //     }else{
              //       await authController.loggedUserIn();
              //       Helpers.hideLoader();
              //       Navigator.pop(context);
              //       context.goNamed(mainPage);
              //     }
              //   }else{
              //     Helpers.hideLoader();
              //   }
              // }
            },
          ),
          SizedBox(
            height: 4.h,
          ),
        ]),
      ),
    );
  }

  void _otpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return OTPDialog(
            otp: otp,
            onVerify: () async {
              Helpers.loader();
              final isSuccess = await authController.sendAndVerifyOTP(
                  mobile: email.text, otp: otp.text);
              Helpers.hideLoader();
              if (isSuccess) {
                if (profileController.profile.displayName == null) {
                  _showCreateProfileBottomSheet(context);
                } else {
                  await authController.loggedUserIn();
                  Navigator.pop(context);
                  Navigator.pop(context);
                  context.goNamed(mainPage);
                }
              }
            });
      },
    );
  }

  void _showCreateProfileBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const CustomBottomSheet(
              isDismissible: false,
              initialChildSize: 0.97,
              maxChildSize: 0.97,
              minChildSize: 0.5,
              child: CreateProfileCard(
                from: 'signIn',
              )),
        );
      },
    );
  }

  void _showForgotPasswordBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const CustomBottomSheet(
              isDismissible: false,
              initialChildSize: 0.5,
              maxChildSize: 0.9,
              minChildSize: 0.5,
              child: ForgotPassword()),
        );
      },
    );
  }
}
