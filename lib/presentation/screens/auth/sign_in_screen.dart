import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/background_image.dart';
import 'widgets/login_card.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: body(),
    );
  }

  Widget body() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/login_bg_img.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 61,
              child: Image.asset(
                "assets/icons/app_icon.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: LoginCard(),
          ),
        ],
      ),
    );
  }
}
