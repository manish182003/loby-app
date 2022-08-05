import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/helpers.dart';
import '../../../services/routing_service/routes_name.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/input_text_title_widget.dart';
import '../../widgets/input_text_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: body(),
    );
  }

  Widget body() {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      color: limedAshColor,
      /*decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/login_bg_img.png"),
          fit: BoxFit.cover,
        ),
      ),*/
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 44.0),
            decoration: const BoxDecoration(
                color: backgroundBalticSeaColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                )),
            child: Padding(
              padding: EdgeInsets.fromLTRB(31.5, 16.00, 31.5, 16.00),
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 1.h,
                        ),
                        Text('Create New Account',
                            style: textTheme.headline2
                                ?.copyWith(color: textWhiteColor)),
                        SizedBox(
                          width: double.infinity,
                          height: 4.h,
                        ),
                        const InputTextTitleWidget(
                            titleName: 'Full Name',
                            titleTextColor: textInputTitleColor),
                        SizedBox(
                          width: double.infinity,
                          height: 2.h,
                        ),
                        InputTextWidget(
                          hintName: 'Ex: Jhon Singh',
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 4.h,
                        ),
                        const InputTextTitleWidget(
                            titleName: 'Email Address',
                            titleTextColor: textInputTitleColor),
                        SizedBox(
                          width: double.infinity,
                          height: 2.h,
                        ),
                        InputTextWidget(
                          hintName: 'Ex: jhonsingh@gmail.com',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 4.h,
                        ),
                        const InputTextTitleWidget(
                            titleName: 'Password',
                            titleTextColor: textInputTitleColor),
                        SizedBox(
                          width: double.infinity,
                          height: 2.h,
                        ),
                        passwordTextFieldWidget(textTheme, 'Password', (value) {
                          return Helpers.validateField(value!);
                        }),
                        SizedBox(
                          width: double.infinity,
                          height: 4.h,
                        ),
                        const InputTextTitleWidget(
                            titleName: 'Re-Enter Password',
                            titleTextColor: textInputTitleColor),
                        SizedBox(
                          width: double.infinity,
                          height: 2.h,
                        ),
                        passwordTextFieldWidget(textTheme, 'Re-Enter Password',
                            (value) {
                          return Helpers.validateField(value!);
                        }),
                        SizedBox(
                          width: double.infinity,
                          height: 4.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: CustomButton(
                            color: aquaGreenColor,
                            textColor: textCharcoalBlueColor,
                            name: "Create Account",
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                context.pushNamed(createProfilePage);
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 2.h,
                        ),
                        Text('Sign up using Google or Apple',
                            style: textTheme.headline5
                                ?.copyWith(color: textInputTitleColor)),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(4.h, 2.h, 4.h, 0.h),
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  CustomButton(
                                      color: whiteColor,
                                      name: "Signup with Google",
                                      iconWidget:
                                          'assets/icons/google_icon.svg',
                                      onTap: () {
                                        _goToMainScreen(context, textTheme);
                                      }),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 2.h,
                                  ),
                                  CustomButton(
                                    color: whiteColor,
                                    name: "Signup with Apple",
                                    iconWidget:
                                        'assets/icons/apple_logo_icon.svg',
                                    onTap: () {
                                      _goToMainScreen(context, textTheme);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _goToMainScreen(BuildContext context, TextTheme textTheme) {
    context.pushNamed(mainPage);
  }

  Widget passwordTextFieldWidget(TextTheme textTheme, String password,
      FormFieldValidator<String> validator) {
    return Container(
      decoration: BoxDecoration(
        color: textFieldColor,
        borderRadius: BorderRadius.circular(1.5.h),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23.0, vertical: 2.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                obscureText: !visible,
                cursorColor: aquaGreenColor,
                style: textTheme.headline4?.copyWith(color: textWhiteColor),
                maxLines: 1,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  /*focusedBorder:OutlineInputBorder(
                    borderSide: const BorderSide(color: aquaGreenColor, width: 0.5),
                    borderRadius: BorderRadius.circular(1.5.h),
                  ),*/
                  border: InputBorder.none,
                  hintStyle:
                      textTheme.headline4?.copyWith(color: textInputTitleColor),
                  hintText: password,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  visible = !visible;
                });
              },
              child: Icon(
                visible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: iconTintColor,
                size: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
