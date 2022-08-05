import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/presentation/widgets/input_text_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../services/routing_service/routes_name.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/input_text_title_widget.dart';
import '../../main/main_screen.dart';
import 'create_profile_bottom_sheet.dart';

class SignUpCardList extends StatefulWidget {
  final ScrollController controller;

  const SignUpCardList({Key? key, required this.controller});

  @override
  State<SignUpCardList> createState() => _SignUpCardListState();
}

class _SignUpCardListState extends State<SignUpCardList> {
  final _formKey = GlobalKey<FormState>();
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListView.builder(
        controller: widget.controller,
        // assign controller here
        itemCount: 1,
        itemBuilder: (_, index) => Padding(
              padding: EdgeInsets.all(4.h),
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
                      validator: (value) {
                        return Helpers.validateField(value!);
                      },
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
                      validator: (value) {
                        return Helpers.validateEmail(value!);
                      },
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
                            Navigator.pop(context);
                            _showCreateProfileBottomSheet(context, textTheme);
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
                        padding: EdgeInsets.fromLTRB(4.h, 2.h, 4.h, 8.h),
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              CustomButton(
                                  color: whiteColor,
                                  name: "Signup with Google",
                                  iconWidget: 'assets/icons/google_icon.svg',
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
                                  }),
                              SizedBox(
                                width: double.infinity,
                                height: 2.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
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
                validator: validator,
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

  _showCreateProfileBottomSheet(BuildContext context, TextTheme textTheme) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.9,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          builder: (context, scrollController) {
            return Column(
              children: <Widget>[
                Expanded(
                    child: Container(
                  decoration: const BoxDecoration(
                    color: backgroundBalticSeaColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: CreateProfileCard(scrollController),
                )),
              ],
            );
          },
        );
      },
    );
  }
}
