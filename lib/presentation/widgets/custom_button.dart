import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/theme/colors.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final String name;
  Color? textColor;
  dynamic onTap;

  CustomButton({Key? key,
    required this.color,
    required this.name,
    required this.onTap,
    this.textColor})
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
            child: Text(name,
                textAlign: TextAlign.center,
                style: textTheme.button
                    ?.copyWith(color: textColor ?? textCharcoalBlueColor)),
          ),
        ),
      ),
    );
  }
}
