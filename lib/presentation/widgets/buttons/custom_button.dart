import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../core/theme/colors.dart';

class CustomButton extends StatelessWidget {
  final Color? color;
  final String? name;
  final Color? textColor;
  final Function()? onTap;
  final double? top, bottom, left, right;
  final String? iconWidget;

  const CustomButton({Key? key,
    this.color,
    required this.name,
    required this.onTap,
    this.textColor, this.iconWidget, this.top, this.bottom, this.left, this.right})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(
              top: top ?? 0, left: left ?? 0, bottom: bottom ?? 0, right: right ?? 0),
          decoration: BoxDecoration(
            color: color ?? whiteColor,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    child: iconWidget != null ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,),
                      child: SvgPicture.asset(
                        iconWidget!,
                        height: 19,
                        width: 19,
                      ),
                    ) : Container()),
                Text(name ?? 'Next',
                    textAlign: TextAlign.center,
                    style: textTheme.button?.copyWith(color: textColor ?? textCharcoalBlueColor)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
