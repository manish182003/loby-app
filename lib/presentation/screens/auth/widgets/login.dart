import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';
import 'package:loby/presentation/widgets/buttons/custom_button.dart';
import 'package:loby/presentation/widgets/input_text_title_widget.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:sizer/sizer.dart';
import '../../../widgets/body_padding_widget.dart';
import '../../../widgets/input_text_widget.dart';
import '../../../widgets/text_fields/text_field_widget.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  AuthController authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  bool visible = false;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BodyPaddingWidget(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text('Login', style: textTheme.headline2?.copyWith(color: textWhiteColor)),
            SizedBox(height: 4.h,),
            TextFieldWidget(
              textEditingController: email,
              type: "email",
              title: "Email Address",
              isRequired: true,
              scrollBottomPadding: 20,
            ),
            SizedBox(height: 3.h,),
            TextFieldWidget(
              textEditingController: password,
              type: "password",
              title: "Password",
              isRequired: true,
            ),
            SizedBox(height: 5.h,),
            CustomButton(
              color: aquaGreenColor,
              name: "Login",
              left: 15.w,
              right: 15.w,
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  Helpers.loader();
                  final isSuccess = await authController.login(email: email.text, password: password.text);
                  Helpers.hideLoader();
                  if(isSuccess){
                    context.goNamed(mainPage);
                  }
                  }
               },
            ),
            SizedBox(height: 4.h,),
      ]),
      ),
    );
  }
}