import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';
import 'package:loby/presentation/screens/auth/widgets/create_account.dart';
import 'package:loby/presentation/screens/auth/widgets/create_profile_bottom_sheet.dart';
import 'package:loby/presentation/screens/auth/widgets/login.dart';
import 'package:loby/presentation/widgets/body_padding_widget.dart';
import 'package:loby/presentation/widgets/buttons/custom_button.dart';
import 'package:loby/presentation/widgets/custom_bottom_sheet.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../core/theme/colors.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  AuthController authController = Get.find<AuthController>();


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/login_bg_img.png"),
              fit: BoxFit.fill
          ),
        ),
        child: BodyPaddingWidget(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/icons/app_icon.png", fit: BoxFit.cover, height: 7.5.h,),
              CustomButton(
                  name: "Continue with Google",
                  iconWidget: 'assets/icons/google_icon.svg',
                  left: 14.w,
                  right: 14.w,
                  bottom: 2.h,
                  top: 6.h,
                  onTap: ()async{
                    final isSuccess = await authController.googleSignInMethod(context);
                    if(isSuccess){
                      _showCreateProfileBottomSheet(context);
                    }
                  }
              ),
              CustomButton(
                  name: "Continue with Apple",
                  iconWidget: 'assets/icons/apple_logo_icon.svg',
                  left: 14.w,
                  right: 14.w,
                  bottom: 2.h,
                  onTap: () {
                    // context.pushNamed(mainPage);
                  }),
              CustomButton(
                  name: "Login",
                  color: butterflyBlueColor,
                  left: 14.w,
                  right: 14.w,
                  bottom: 5.h,
                  onTap: () async{
                    _loginDialog(context);
                  }),
              Text("New User ?", style: textTheme.headline3?.copyWith(color: aquaGreenColor, fontWeight: FontWeight.w500)),
              CustomButton(
                  name: "Create Account",
                  color: aquaGreenColor,
                  left: 14.w,
                  right: 14.w,
                  bottom: 5.h,
                  top: 2.h,
                  onTap: () async{

                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('apiToken');
                    if (!mounted) return;
                    if(token != null){
                      _showCreateProfileBottomSheet(context);
                    }else{
                      _createAccountDialog(context);
                    }

                  }),

            ],
          ),
        ),
      ),
    );
  }


  void _createAccountDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      builder: (BuildContext context) {
        return const CustomBottomSheet(
          initialChildSize: 0.97,
          maxChildSize: 0.97,
          minChildSize: 0.5,
            isDismissible: false,
          child: CreateAccount());
      },
    );
  }


  void _loginDialog(BuildContext context) {
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
              initialChildSize: 0.5,
              maxChildSize: 0.9,
              minChildSize: 0.5,
              child: Login()),
        );
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
              child: CreateProfileCard()),
        );
      },
    );
  }
}
