import 'package:flutter/material.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:sizer/sizer.dart';

class TransactionTile extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final bool isDebited;
  const TransactionTile({Key? key, required this.title, required this.date, required this.amount, required this.isDebited}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: textTheme.headline2?.copyWith(color: textWhiteColor),),
                  SizedBox(height: 1.h,),
                  Text(date, style: textTheme.headline3?.copyWith(color: textLightColor),),
                ],
              ),
            ),
            Expanded(
                flex: 3,
                child: Text('${isDebited ? '-' : '+'} ₹ $amount', style: textTheme.headline2?.copyWith(color: textWhiteColor), textAlign: TextAlign.end,))],
        ),
        SizedBox(height: 4.h,),
      ],

    );
  }
}
