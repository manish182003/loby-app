import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/screens/auth/widgets/create_profile_bottom_sheet.dart';
import 'package:loby/presentation/widgets/buttons/custom_button.dart';
import 'package:loby/presentation/widgets/custom_bottom_sheet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/body_padding_widget.dart';
import '../../../widgets/text_fields/text_field_widget.dart';

class ResetPassword extends StatefulWidget {
  final String email;
  const ResetPassword({Key? key, required this.email}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  AuthController authController = Get.find<AuthController>();
  ProfileController profileController = Get.find<ProfileController>();
  final _formKey = GlobalKey<FormState>();

  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  TextEditingController otp = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BodyPaddingWidget(
      child: Form(
        key: _formKey,
        child: Column(children: [
          Text('Reset Password',
              style: textTheme.displayMedium?.copyWith(color: textWhiteColor)),
          SizedBox(
            height: 4.h,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Enter OTP',
                  style: textTheme.headlineMedium
                      ?.copyWith(color: textWhiteColor))),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: PinCodeTextField(
                appContext: context,
                autoDisposeControllers: false,
                pastedTextStyle: TextStyle(
                  color: Colors.green.shade600,
                  fontWeight: FontWeight.bold,
                ),
                length: 6,
                obscureText: false,
                obscuringCharacter: '*',
                animationType: AnimationType.scale,
                validator: (v) {
                  if (v!.length < 6) {
                    return "";
                  } else {
                    return null;
                  }
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 55,
                  fieldWidth: 45,
                  activeColor: aquaGreenColor,
                  inactiveColor: textFieldColor,
                  selectedColor: aquaGreenColor,
                ),
                cursorColor: whiteColor,
                animationDuration: const Duration(milliseconds: 100),
                textStyle: textTheme.displaySmall?.copyWith(color: whiteColor),
                // enableActiveFill: true,
                errorAnimationController: errorController,
                controller: otp,
                keyboardType: TextInputType.number,
                boxShadows: const [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black12,
                    blurRadius: 10,
                  )
                ],
                onCompleted: (v) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
                onChanged: (String value) {},
              )),
          TextFieldWidget(
            textEditingController: password,
            type: "password",
            title: "Password",
            isRequired: true,
            scrollBottomPadding: 20,
          ),
          SizedBox(
            height: 3.h,
          ),
          TextFieldWidget(
            textEditingController: confirmPassword,
            type: "password",
            title: "Confirm Password",
            isRequired: true,
          ),
          SizedBox(
            height: 5.h,
          ),
          CustomButton(
            color: aquaGreenColor,
            name: "Change Password",
            left: 15.w,
            right: 15.w,
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                Helpers.loader();
                final isSuccess = await authController.forgotAndResetPassword(
                    email: widget.email,
                    otp: otp.text,
                    password: password.text,
                    confirmPassword: confirmPassword.text);
                if (isSuccess) {
                  Helpers.hideLoader();
                  Navigator.pop(context);
                  Helpers.toast(
                      "Password Successfully Changed Please Login to Continue");
                } else {
                  Helpers.hideLoader();
                  errorController.add(ErrorAnimationType.shake);
                }
              }
            },
          ),
          SizedBox(
            height: 4.h,
          ),
        ]),
      ),
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
              initialChildSize: 0.5,
              maxChildSize: 0.9,
              minChildSize: 0.5,
              child: CreateProfileCard(
                from: 'signIn',
              )),
        );
      },
    );
  }
}
