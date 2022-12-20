import 'package:flutter/material.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/presentation/screens/main/profile/wallet/widgets/token_widget.dart';
import 'package:loby/presentation/screens/main/profile/wallet/widgets/wallet_reason_constants.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/utils/helpers.dart';
import '../../../../../../domain/entities/profile/wallet_transaction.dart';
import '../../../../../widgets/buttons/custom_button.dart';

class TransactionTile extends StatelessWidget {
  final String title;
  final bool isDebited;
  final WalletTransaction transaction;
  const TransactionTile({Key? key, required this.title, required this.isDebited,  required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isTransactionOpenable = transaction.order != null && transaction.order!.userGameService != null && !isDebited && !(['REFUND_OF_HOLDED_AMOUNT', 'FUND_ADDED'].contains(transaction.reason));
    return InkWell(
      onTap: (){
        if(isTransactionOpenable){
          _transactionsDetails(context);
        }
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(isDebited ? '-' : '+', style: textTheme.headline2?.copyWith(color: isDebited ? carminePinkColor : textWhiteColor), textAlign: TextAlign.end,),
                      SizedBox(width: 1.w,),
                      TokenWidget(text: Text(transaction.amount!.toStringAsFixed(2), style: textTheme.headline2?.copyWith(color: isDebited ? carminePinkColor : textWhiteColor), textAlign: TextAlign.end,), size: 20,),
                    ],
                  ),
                  SizedBox(height: isTransactionOpenable ?  2.h : 0.0,),
                  isTransactionOpenable ?  InkWell(
                    onTap: (){
                      _transactionsDetails(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: aquaGreenColor,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text('View', style: textTheme.button?.copyWith(color: textCharcoalBlueColor))),
                  ) : const SizedBox(),
                ],

              )
            ],
          ),
          SizedBox(height: 4.h,),
        ],

      ),
    );
  }



  void _transactionsDetails(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        double totalAmount = 0.0;
        double lobyProtectionCharges = 0.0;

        if(transaction.order?.dispute == null){
          totalAmount = (transaction.amount! * 100) / (100 - ((transaction.order!.userGameService!.category!.commissionPercent!) + (transaction.order!.userGameService!.category!.govtCommission!)));
          lobyProtectionCharges = (totalAmount * transaction.order!.userGameService!.category!.commissionPercent!)/100;
        }else{
          totalAmount = (transaction.amount! * 100) / (100 - ((transaction.order!.dispute!.commissionPercent!) + (transaction.order!.userGameService!.category!.govtCommission!)));
          lobyProtectionCharges = (totalAmount * transaction.order!.dispute!.commissionPercent!)/100;
        }

        double governmentCommission = (totalAmount * transaction.order!.userGameService!.category!.govtCommission) / 100;

        return Dialog(
          elevation: 0,
          backgroundColor: backgroundDarkJungleGreenColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0)),
          child: Container(
            // alignment: Alignment.center,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                _rowWidget(textTheme, text1: 'Reason', text2: walletReason[transaction.reason!]),
                SizedBox(height: 1.h),
                _rowWidget(textTheme, text1: 'Details', text2: transaction.details!),
                SizedBox(height: 4.h),
                _rowWidget(textTheme, text1: title.contains('Credited') ? 'Tokens Earned' : 'Tokens Spent', text2: totalAmount.toStringAsFixed(2), isToken: true, isDebited: title.contains('Debited')),
                SizedBox(height: 1.h),
                _rowWidget(textTheme, text1: 'Loby Protection Charges', text2: lobyProtectionCharges.toStringAsFixed(2) , isToken: true, isDebited: true),
                SizedBox(height: 1.h),
                _rowWidget(textTheme, text1: 'Government Tax', text2: governmentCommission.toStringAsFixed(2), isToken: true, isDebited: true),
                SizedBox(height: 1.h),
                Divider(thickness: 1, color: whiteColor, indent: 50.w),
                SizedBox(height: 1.h),
                _rowWidget(textTheme, text1: 'Total $title', text2: (totalAmount - lobyProtectionCharges - governmentCommission).toStringAsFixed(2), isToken: true, isDebited: title.contains('Debited')),
                SizedBox(height: 5.h),
                CustomButton(
                    name: "OK",
                    color: aquaGreenColor,
                    left: 15.w,
                    right: 15.w,
                    onTap: () async{
                      Navigator.pop(context);
                    }),
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
        SizedBox(width: 8.w,),
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
