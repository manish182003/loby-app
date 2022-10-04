import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/theme/colors.dart';


class RowWidget extends StatelessWidget {
  final String? text1;
  final String? text2;
  final bool isLast;
  final Color? textColor;

  const RowWidget({Key? key, this.text1, this.text2, this.isLast = false, this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text1!,
              style: textTheme.headline3?.copyWith(color: textColor ?? textWhiteColor),
            ),
            Flexible(
              child: Text(
                text2.toString(),
                style: textTheme.headline3?.copyWith(fontWeight: FontWeight.w500, color: textColor ?? textWhiteColor),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        isLast ? SizedBox(height: 1.h,) : Column(
          children: [
            SizedBox(height: 0.6.h),
            const Divider(color: dividerColor, thickness: 1.4),
            SizedBox(height: 0.6.h),
          ],
        ),

      ],
    );
  }
}
