import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../core/theme/colors.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final String name;
  Color? textColor;
  dynamic onTap;
  String? iconWidget;

  CustomButton({Key? key,
    required this.color,
    required this.name,
    required this.onTap,
    this.textColor, this.iconWidget})
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
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2.h),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(child: iconWidget != null? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,),
                  child: SvgPicture.asset(
                    iconWidget!,
                    height: 19,
                    width: 19,
                  ),
                ) : Container()),
                Text(name,
                    textAlign: TextAlign.center,
                    style: textTheme.button
                        ?.copyWith(color: textColor ?? textCharcoalBlueColor)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
