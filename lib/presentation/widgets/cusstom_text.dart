import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyText extends StatelessWidget {
  String name;
  Color textColor;
  Color myBackgroundColor;

  MyText(
      {Key? key,
      required this.name,
      required this.textColor,
      required this.myBackgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
        decoration: BoxDecoration(
          color: myBackgroundColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal:4.w),
          child: Text(
            name,
            style: textTheme.headline5
                ?.copyWith(color: textColor),
          ),
        ));
  }
}
