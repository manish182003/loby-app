import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/screens/auth/widgets/reset_password.dart';
import 'package:loby/presentation/widgets/buttons/custom_button.dart';
import 'package:loby/presentation/widgets/custom_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/body_padding_widget.dart';
import '../../../widgets/text_fields/text_field_widget.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  AuthController authController = Get.find<AuthController>();
  ProfileController profileController = Get.find<ProfileController>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BodyPaddingWidget(
      child: Form(
        key: _formKey,
        child: Column(children: [
          SizedBox(
            height: 2.h,
          ),
          Text('Forgot Password',
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
            height: 5.h,
          ),
          CustomButton(
            color: aquaGreenColor,
            name: "Send OTP",
            left: 15.w,
            right: 15.w,
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                Helpers.loader();
                final isSuccess = await authController.forgotAndResetPassword(
                    email: email.text);
                if (isSuccess) {
                  Helpers.hideLoader();
                  Navigator.pop(context);
                  _showResetPasswordBottomSheet(context, email.text);
                } else {
                  Helpers.hideLoader();
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

  void _showResetPasswordBottomSheet(BuildContext context, String email) {
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
          child: CustomBottomSheet(
              isDismissible: false,
              initialChildSize: 0.7,
              maxChildSize: 0.9,
              minChildSize: 0.7,
              child: ResetPassword(email: email)),
        );
      },
    );
  }
}
