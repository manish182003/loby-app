import 'package:flutter/material.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/presentation/screens/main/profile/wallet/widgets/token_widget.dart';
import 'package:sizer/sizer.dart';

class TransactionTile extends StatelessWidget {
  final String title;
  final String desc;
  final String date;
  final String amount;
  final bool isDebited;
  const TransactionTile({Key? key, required this.title, required this.date, required this.amount, required this.isDebited, required this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: textTheme.headline3?.copyWith(color: textWhiteColor),),
                  SizedBox(height: 1.h,),
                  Text(desc, style: textTheme.headline4?.copyWith(color: textLightColor),),
                  SizedBox(height: 1.h,),
                  Text(date, style: textTheme.headline6?.copyWith(color: textLightColor),),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(isDebited ? '-' : '+', style: textTheme.headline2?.copyWith(color: textWhiteColor), textAlign: TextAlign.end,),
                SizedBox(width: 1.w,),
                TokenWidget(text: Text(amount, style: textTheme.headline2?.copyWith(color: textWhiteColor), textAlign: TextAlign.end,), size: 20,),
              ],
            )],
        ),
        SizedBox(height: 4.h,),
      ],

    );
  }
}
