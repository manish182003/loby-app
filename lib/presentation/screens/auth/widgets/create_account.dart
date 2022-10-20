import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/widgets/buttons/custom_button.dart';
import 'package:loby/presentation/widgets/custom_bottom_sheet.dart';
import 'package:loby/presentation/widgets/input_text_title_widget.dart';
import 'package:loby/presentation/widgets/input_text_widget.dart';
import 'package:loby/presentation/widgets/text_fields/text_field_widget.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/body_padding_widget.dart';
import 'create_profile_bottom_sheet.dart';
import 'otp_dialog.dart';


class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);
  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  AuthController authController = Get.find<AuthController>();
  ProfileController profileController = Get.find<ProfileController>();
  final _formKey = GlobalKey<FormState>();


  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  TextEditingController otp = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BodyPaddingWidget(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 1.h,),
            Text('Create New Account', style: textTheme.headline2?.copyWith(color: textWhiteColor)),
            SizedBox(height: 4.h,),
            TextFieldWidget(
              textEditingController: name,
              title: "Full Name",
              hint: "Ex: John Doe",
              isRequired: true,
            ),
            SizedBox(height: 3.h,),
            TextFieldWidget(
              textEditingController: email,
              type: "email",
              title: "Email Address",
              hint: "Ex: JohnDoe@gmail.com",
              isRequired: true,
            ),
            SizedBox(height: 3.h,),
            TextFieldWidget(
              textEditingController: password,
              type: "password",
              title: "Password",
              hint: "Password",
              isRequired: true,
            ),
            SizedBox(height: 3.h,),
            TextFieldWidget(
              textEditingController: confirmPassword,
              type: "password",
              title: "Re-Enter Password",
              hint: "Password",
              isRequired: true,
            ),
            SizedBox(height: 3.h,),
            CustomButton(
              color: aquaGreenColor,
              textColor: textCharcoalBlueColor,
              name: "Create Account",
              left: 15.w,
              right: 15.w,
              onTap: () async{
                if (_formKey.currentState!.validate()) {
                  await Helpers.loader();
                  final result = await authController.signup(name: name.text, email: email.text, password: password.text, confirmPassword: confirmPassword.text);
                  if (!mounted) return;
                  if(result){
                    final isSuccess = await authController.sendAndVerifyOTP(email: email.text);
                    Helpers.hideLoader();
                    if(isSuccess){
                      _otpDialog(context);
                    }
                  }
                }
              },
            ),
            SizedBox(height: 2.h,),
            Text('Sign up using Google or Apple',
                style: textTheme.headline5
                    ?.copyWith(color: textInputTitleColor)),
            CustomButton(
                name: "Continue with Google",
                iconWidget: 'assets/icons/google_icon.svg',
                left: 10.w,
                right: 10.w,
                bottom: 2.h,
                top: 4.h,
                onTap: ()async{
                  final isSuccess = await authController.googleSignInMethod(context);
                  if(isSuccess){
                    Navigator.pop(context);
                    _showCreateProfileBottomSheet(context);
                  }
                }),
            CustomButton(
                name: "Continue with Apple",
                iconWidget: 'assets/icons/apple_logo_icon.svg',
                left: 10.w,
                right: 10.w,
                bottom: 3.h,
                onTap: () {

                }),
          ],
        ),
      ),
    );
  }

  void _otpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return OTPDialog(
            otp: otp,
            onVerify: () async{
              Helpers.loader();
              final isSuccess = await authController.sendAndVerifyOTP(email: email.text, otp: otp.text);
              Helpers.hideLoader();
              if (!mounted) return;
              if(isSuccess) {
                _showCreateProfileBottomSheet(context);
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
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const CustomBottomSheet(
            isDismissible: false,
              initialChildSize: 0.97,
              maxChildSize: 0.97,
              minChildSize: 0.5,
              child: CreateProfileCard(from: 'signIn',)),
        );
      },
    );
  }


}
