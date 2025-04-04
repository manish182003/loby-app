import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/theme/colors.dart';
import 'buttons/custom_button.dart';

class BottomDialog {
  final TextTheme? textTheme;
  final String? tileName;
  final Color? titleColor;
  final String? contentName;
  final String? contentLinkName;
  final String? contentNameLast;
  final Function()? onOk;

  BottomDialog(
      {this.onOk,
      this.textTheme,
      this.tileName,
      this.titleColor,
      this.contentName,
      this.contentLinkName,
      this.contentNameLast});

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
        margin: const EdgeInsets.all(24.0),
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
              _buildCongratulationsText(),
              const SizedBox(height: 16),
              _buildContentText(),
              const SizedBox(height: 44),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: CustomButton(
                  onTap: onOk ??
                      () async {
                        if (await canLaunchUrl(Uri.parse(contentName!))) {
                          launchUrl(Uri.parse(contentName!));
                        } else {
                          contextKey.currentContext!.pop();
                        }
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
    return tileName != null
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              tileName ?? 'Loby',
              style: textTheme?.displayMedium?.copyWith(
                  color: titleColor ?? aquaGreenColor,
                  fontWeight: FontWeight.w400),
            ),
          )
        : Container();
  }

  Widget _buildContentText() {
    return SizedBox(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: contentName ?? '',
              style: textTheme?.displaySmall?.copyWith(color: textLightColor),
            ),
            TextSpan(
                text: contentLinkName ?? '',
                style:
                    textTheme?.displaySmall?.copyWith(color: aquaGreenColor)),
            TextSpan(
              text: contentNameLast ?? '',
              style: textTheme?.displaySmall?.copyWith(color: textLightColor),
            ),
          ],
        ),
      ),
    );
  }
}
