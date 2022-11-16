import 'package:flutter/material.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/presentation/screens/main/profile/wallet/widgets/token_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/utils/helpers.dart';
import '../../../../../../domain/entities/profile/wallet_transaction.dart';

class TransactionTile extends StatelessWidget {
  final String title;
  final bool isDebited;
  final WalletTransaction transaction;
  const TransactionTile({Key? key, required this.title, required this.isDebited,  required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: (){
        if(transaction.order != null && transaction.order!.userGameService != null){
          _transactionSDetails(context);
        }
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
                    Text(transaction.details!, style: textTheme.headline4?.copyWith(color: textLightColor),),
                    SizedBox(height: 1.h,),
                    Text(Helpers.formatDateTime(dateTime: transaction.createdAt!), style: textTheme.headline6?.copyWith(color: textLightColor),),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(isDebited ? '-' : '+', style: textTheme.headline2?.copyWith(color: textWhiteColor), textAlign: TextAlign.end,),
                  SizedBox(width: 1.w,),
                  TokenWidget(text: Text(transaction.amount!.toStringAsFixed(2), style: textTheme.headline2?.copyWith(color: textWhiteColor), textAlign: TextAlign.end,), size: 20,),
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
        final lobyProtectionCharges = (transaction.amount! * transaction.order!.userGameService!.category!.commissionPercent!)/100;
        return Dialog(
          elevation: 0,
          backgroundColor: backgroundDarkJungleGreenColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0)),
          child: Container(
            alignment: Alignment.center,
            height: 50.h,
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
                _rowWidget(textTheme, text1: 'Category', text2: transaction.order!.userGameService!.category!.name!),
                SizedBox(height: 1.h),
                _rowWidget(textTheme, text1: 'Game', text2: transaction.order!.userGameService!.game!.name!),
                SizedBox(height: 1.h),
                _rowWidget(textTheme, text1: 'Reason', text2: transaction.reason!),
                SizedBox(height: 1.h),
                _rowWidget(textTheme, text1: 'Details', text2: transaction.details!),
                SizedBox(height: 4.h),
                _rowWidget(textTheme, text1: title.contains('Credited') ? 'Tokens Earned' : 'Tokens Spent', text2: transaction.amount!.toStringAsFixed(2), isToken: true, isDebited: title.contains('Debited')),
                SizedBox(height: 1.h),
                _rowWidget(textTheme, text1: 'Loby Protection Charges', text2: lobyProtectionCharges.toStringAsFixed(2) , isToken: true, isDebited: true),
                SizedBox(height: 1.h),
                _rowWidget(textTheme, text1: 'Government Tex', text2: '0.00', isToken: true, isDebited: true),
                SizedBox(height: 1.h),
                Divider(thickness: 1, color: whiteColor, indent: 50.w),
                SizedBox(height: 1.h),
                _rowWidget(textTheme, text1: 'Total $title', text2: (transaction.amount! - lobyProtectionCharges).toStringAsFixed(2), isToken: true, isDebited: title.contains('Debited')),
                SizedBox(height: 1.h),
              ],
            ),
          ),
        );
      },
    );
  }




  Widget _rowWidget(TextTheme textTheme, {required String text1, required String text2, bool isDebited = false, bool isToken = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: textTheme.headline5?.copyWith(color: textLightColor),
        ),
        SizedBox(width: 10.w,),
        isToken ? Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(isDebited ? '-' : '+', style: textTheme.headline2?.copyWith(color: isDebited ? textErrorColor : aquaGreenColor), textAlign: TextAlign.end,),
              SizedBox(width: 1.w,),
              TokenWidget(text: Text(text2, style: textTheme.headline5?.copyWith(color: isDebited ? textErrorColor : aquaGreenColor), textAlign: TextAlign.end,), size:14,),
            ],
          )
        ) :
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
