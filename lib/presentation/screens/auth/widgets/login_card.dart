import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/presentation/screens/auth/sign_up_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../services/routing_service/routes_name.dart';
import 'sign_up_bottom_sheet.dart';
import '../../../widgets/custom_button.dart';

class LoginCard extends StatefulWidget {
  const LoginCard({Key? key}) : super(key: key);

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(32.0, 32.0, 32.0,32.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              CustomButton(color: whiteColor, name: "Continue with Google", iconWidget: 'assets/icons/google_icon.svg', onTap: () {
                _goToMainScreen(context, textTheme);
              }
              ),
              SizedBox(
                width: double.infinity,
                height: 16.0,
              ),
              CustomButton(color: whiteColor, name: "Continue with Apple", iconWidget: 'assets/icons/apple_logo_icon.svg', onTap: () {
                _goToMainScreen(context, textTheme);
              }
              ),
              SizedBox(
                width: double.infinity,
                height: 16.0,
              ),
              Text("New User ?", style: textTheme.headline5?.copyWith(color: aquaGreenColor)),
              SizedBox(
                width: double.infinity,
                height: 16.0,
              ),
              CustomButton(color: aquaGreenColor, name: "Create New Account", onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const SignUpScreen()));
              }
              ),
              SizedBox(
                width: double.infinity,
                height: 32.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goToMainScreen(BuildContext context, TextTheme textTheme) {
    context.pushNamed(mainPage);
    /*Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const MainScreen()));*/
  }

  void _showDialog(BuildContext context, TextTheme textTheme) {
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
                      child: SignUpCardList(controller: scrollController),
                    )),
              ],
            );
          },
        );
      },
    );
  }
}
