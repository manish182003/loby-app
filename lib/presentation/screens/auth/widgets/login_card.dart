import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/theme/colors.dart';
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
      child: Card(
        elevation: 0,
        margin: EdgeInsets.all(10.w),
        color: backgroundBalticSeaColor,
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: textLightColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(4.h, 4.h, 4.h,4.h),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                CustomButton(color: aquaGreenColor, name: "Sign in with Apple", onTap: () {
                  _goToMainScreen(context, textTheme);
                }
                ),
                SizedBox(
                  width: double.infinity,
                  height: 2.h,
                ),
                CustomButton(color: aquaGreenColor, name: "Sign in with Google", onTap: () {
                  _goToMainScreen(context, textTheme);
                }
                ),
                SizedBox(
                  width: double.infinity,
                  height: 2.h,
                ),
                Text("New User ?", style: textTheme.headline5?.copyWith(color: aquaGreenColor)),
                SizedBox(
                  width: double.infinity,
                  height: 2.h,
                ),
                CustomButton(color: whiteColor, name: "Create New Account", onTap: () {
                  _showDialog(context, textTheme);
                }
                ),
              ],
            ),
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
