import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';

class GameItemCard extends StatelessWidget {
  int index;
  GameItemCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 0,
      color: saffronMangoOrangeColor,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/icons/app_icon.png",
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),//CircleAvatar//SizedBox
            Expanded(
              child: Text(
                'Bettelground Mobile India',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: textTheme.subtitle1
                    ?.copyWith(fontSize: 14, color: textWhiteColor), //Textstyle
              ),
            ), //Text
            SizedBox(
              height: 0.5.h,
            ),
          ],
        ),
      ),
    );
  }
}
