import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/services/routing_service/routes_name.dart';

import '../../core/theme/colors.dart';
import 'custom_button.dart';


class BottomDialog {
  final TextTheme? textTheme;
  String? tileName;
  Color? titleColor;
  String? contentName;
  String? contentLinkName;
  String? contentNameLast;

  BottomDialog({this.textTheme, this.tileName, this.titleColor, this.contentName, this.contentLinkName, this.contentNameLast});

  void showBottomDialog(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 300),
      context: context,
      pageBuilder: (context, _, __) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: _buildDialogContent(context),
        );
      },
      transitionBuilder: (_, animation1, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(animation1),
          child: child,
        );
      },
    );
  }
  Widget _buildDialogContent(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        margin: const EdgeInsets.all(12.0),
        width: double.maxFinite,
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: backgroundDarkJungleGreenColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        child: Material(
          color: backgroundDarkJungleGreenColor,
          child: Column(
            children: [
              const SizedBox(height: 16),
              _buildCongratulationsText(),
              const SizedBox(height: 16),
              _buildContentText(),
              const SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: CustomButton(
                  onTap: () {
                    Router.neglect(context, () {
                      context.goNamed(mainPage);
                    });
                  },
                  color: aquaGreenColor,
                  name: 'OK',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCongratulationsText() {
    return Text(
      tileName?? 'Loby',
      style: textTheme?.headline2?.copyWith(color: titleColor, fontWeight: FontWeight.w400),
    );
  }

  Widget _buildContentText() {
    return SizedBox(
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          children: [
            TextSpan(
              text: contentName??'',
              style: textTheme?.headline5?.copyWith(color: textLightColor),
            ),
            TextSpan(
                text: contentLinkName?? '',
                style: textTheme?.headline5?.copyWith(color: aquaGreenColor)),
            TextSpan(
              text: contentNameLast??'',
              style: textTheme?.headline5?.copyWith(color: textLightColor),
            ),
          ],
        ),
      ),
    );
  }
}
