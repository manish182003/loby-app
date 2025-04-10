import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyText extends StatelessWidget {
  final String name;
  final Color textColor;
  final double? height;
  final Color myBackgroundColor;

  const MyText(
      {super.key,
      required this.name,
      required this.textColor,
      required this.myBackgroundColor,
      this.height});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
        height: height,
        decoration: BoxDecoration(
          color: myBackgroundColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
          child: Text(
            name,
            style: textTheme.headlineSmall?.copyWith(color: textColor),
          ),
        ));
  }
}
