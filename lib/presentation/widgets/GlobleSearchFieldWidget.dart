import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../core/theme/colors.dart';

class GlobalSearchFieldWidget extends StatelessWidget {
  final String? textHint;
  final Function()? onTap;
  const GlobalSearchFieldWidget({Key? key, this.textHint, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 55,
          minWidth: 45,
        ),
        decoration: BoxDecoration(
          color: textFieldColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 4.w,
            ),
            SizedBox(
              child: SvgPicture.asset(
                'assets/icons/search_icon.svg',
                color: iconWhiteColor,
                width: 18,
                height: 18,
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            SizedBox(
              child: Text(
                'Search',
                style:
                    textTheme.headlineMedium?.copyWith(color: textWhiteColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
