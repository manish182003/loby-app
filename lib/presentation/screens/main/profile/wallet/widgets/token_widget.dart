import 'package:flutter/material.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:sizer/sizer.dart';

class TokenWidget extends StatelessWidget {
  final String? tokens;
  final double? size;
  final Color? textColor;
  final Widget? text;
  const TokenWidget({Key? key, this.tokens, this.textColor, this.size, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("assets/images/token.png", height: size ?? 30, width: size ?? 30,),
        SizedBox(width: 1.w,),
        text ?? Text(tokens!,
            textAlign: TextAlign.center,
            style: size == 20 ? textTheme.headline3?.copyWith(
    color: textColor ?? textTunaBlueColor,
    fontFamily: 'Inter') : textTheme.headlineLarge
                ?.copyWith(
                color: textColor ?? textTunaBlueColor,
                fontFamily: 'Inter')),
      ],
    );
  }
}
