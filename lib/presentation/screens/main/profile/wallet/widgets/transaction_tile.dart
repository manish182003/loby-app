import 'package:flutter/material.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/presentation/screens/main/profile/wallet/widgets/token_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../domain/entities/profile/wallet_transaction.dart';

class TransactionTile extends StatelessWidget {
  final String title;
  final String desc;
  final String date;
  final String amount;
  final bool isDebited;
  final WalletTransaction transaction;
  const TransactionTile({Key? key, required this.title, required this.date, required this.amount, required this.isDebited, required this.desc, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: (){
        _transactionSDetails(context);
      },
      child: Column(
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

      ),
    );
  }




  void _transactionSDetails(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: backgroundDarkJungleGreenColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0)),
          child: Container(
            alignment: Alignment.center,
            height: 30.h,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    }, child: const Icon(Icons.close, color: whiteColor)),
                SizedBox(height: 4.h),
                _rowWidget(textTheme, text1: title, text2: amount),
                SizedBox(height: 2.h),
                _rowWidget(textTheme, text1: 'Reason', text2: transaction.reason!),
                SizedBox(height: 2.h),
                _rowWidget(textTheme, text1: 'Details', text2: transaction.details!),
                SizedBox(height: 2.h),
                _rowWidget(textTheme, text1: 'Date', text2: date),
              ],
            ),
          ),
        );
      },
    );
  }







  Widget _rowWidget(TextTheme textTheme, {required String text1, required String text2}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: textTheme.headline5?.copyWith(color: textLightColor),
        ),
        SizedBox(width: 10.w,),
        Flexible(
          child: Text(
            text2,
            maxLines: 3,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: textTheme.headline5?.copyWith(color: whiteColor),
          ),
        ),
      ],
    );
  }
}
