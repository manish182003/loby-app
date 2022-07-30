import 'package:flutter/material.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:sizer/sizer.dart';

class Button extends StatelessWidget {
  final VoidCallback onPress;
  final double width;
  final double? height;
  Color? txtColor;
  Color? btnBgColor;
  final String btnName;
  double? txtPadding;
  double? borderRadius;

  Button({Key? key, required this.onPress, required this.width, this.height, this.txtColor, this.btnBgColor, required this.btnName, this.txtPadding, this.borderRadius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onPress,
      child: SizedBox(
        width: width,
        child: Container(
          decoration: BoxDecoration(
            color: btnBgColor,
            borderRadius: BorderRadius.circular(borderRadius??4.h),
          ),
          child: Padding(
            padding: EdgeInsets.all(txtPadding?? 8.0),
            child: Text(btnName,
                textAlign: TextAlign.center,
                style: textTheme.button
                    ?.copyWith(color: txtColor ?? primaryTextColor)),
          ),
        ),
      ),
    );
  }
}