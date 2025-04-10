import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/presentation/widgets/text_fields/text_field_widget.dart';
import 'package:loby/services/routing_service/routes_name.dart';

import '../../../../../../core/theme/colors.dart';

class ConfirmationRiseDisputeBottomDialog {
  final TextTheme? textTheme;
  String? tileName;
  Color? titleColor;
  String? contentName;
  String? contentLinkName;
  String? hintText;
  TextEditingController? reportController;
  String? contentNameLast;
  Function()? yesBtnClick;
  Function()? cancelBtnClick;

  ConfirmationRiseDisputeBottomDialog({
    this.textTheme,
    this.tileName,
    this.titleColor,
    this.contentName,
    this.contentLinkName,
    this.contentNameLast,
    this.yesBtnClick,
    this.cancelBtnClick,
    this.reportController,
    this.hintText,
  });

  void showBottomDialog(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 300),
      context: context,
      pageBuilder: (context, _, __) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: _buildDialogContent(context),
          ),
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
              const SizedBox(height: 16),
              _buildContentText(),
              const SizedBox(height: 16),
              TextFieldWidget(
                textEditingController: reportController!,
                hint: hintText,
              ),
              const SizedBox(height: 44),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: 45,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          side: WidgetStateProperty.all(
                            const BorderSide(
                              style: BorderStyle.solid,
                              color: orangeColor,
                              width: 1.0,
                            ),
                          ),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          )),
                          backgroundColor: WidgetStateProperty.all<Color>(
                              backgroundDarkJungleGreenColor),
                        ),
                        onPressed: cancelBtnClick ??
                            () {
                              Navigator.of(context).pop();
                            },
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                          child: Text("Cancel",
                              style: textTheme?.labelLarge
                                  ?.copyWith(color: orangeColor)),
                        )),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: 45,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          )),
                          backgroundColor:
                              WidgetStateProperty.all<Color>(aquaGreenColor),
                        ),
                        onPressed: yesBtnClick ??
                            () {
                              debugPrint("change");
                              Navigator.of(context).pop();
                              context.pushNamed(createNewDisputePage);
                            },
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                          child: Text("Yes", style: textTheme?.labelLarge),
                        )),
                  ),
                ],
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
              style: textTheme?.displayMedium
                  ?.copyWith(color: titleColor, fontWeight: FontWeight.w400),
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
