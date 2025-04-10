import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:sizer/sizer.dart';

class TokenWidget extends StatelessWidget {
  final String? tokens;
  final double? size;
  final Color? textColor;
  final Widget? text;
  const TokenWidget(
      {super.key, this.tokens, this.textColor, this.size, this.text});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          "assets/icons/token.svg",
          height: size ?? 30,
          width: size ?? 30,
        ),
        SizedBox(
          width: 1.w,
        ),
        SizedBox(
          // width: 70.w,
          child: text ??
              Text(tokens ?? '0',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: size == 20
                      ? textTheme.displaySmall?.copyWith(
                          color: textColor ?? textTunaBlueColor,
                          fontFamily: 'Inter')
                      : textTheme.headlineLarge?.copyWith(
                          color: textColor ?? textTunaBlueColor,
                          fontFamily: 'Inter')),
        ),
      ],
    );
  }
}
