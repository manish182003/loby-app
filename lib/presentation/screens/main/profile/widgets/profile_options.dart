import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';

class ProfileOptionsWidget extends StatelessWidget {
  String name;
  var onTap;

  ProfileOptionsWidget({super.key, required this.name, this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.fromLTRB(8.w, 2.h, 1.h, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              name,
              style: textTheme.displayMedium
                  ?.copyWith(fontSize: 20, color: textWhiteColor),
            )
          ],
        ),
      ),
    );
  }
}
