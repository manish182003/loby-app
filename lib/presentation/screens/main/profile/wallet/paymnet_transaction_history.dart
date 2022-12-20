import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/screens/main/notification/widgets/notification_item_widget.dart';
import 'package:loby/presentation/screens/main/profile/wallet/widgets/row_widget.dart';
import 'package:loby/presentation/screens/main/profile/wallet/widgets/transaction_tile.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../widgets/body_padding_widget.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_loader.dart';

class PaymentTransactionHistory extends StatefulWidget {
  const PaymentTransactionHistory({Key? key}) : super(key: key);

  @override
  State<PaymentTransactionHistory> createState() => _PaymentTransactionHistoryState();
}

class _PaymentTransactionHistoryState extends State<PaymentTransactionHistory> {

  ProfileController profileController = Get.find<ProfileController>();
  final controller = ScrollController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.paymentTransactionsPageNumber.value = 1;
      profileController.areMorePaymentTransactionsAvailable.value = true;
      profileController.getPaymentTransactions();
    });

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        profileController.getPaymentTransactions();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, appBarName: 'Payment Transaction'),
      body: Obx(() {
        if (profileController.isPaymentTransactionsFetching.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (profileController.paymentTransactions.isEmpty) {
          return const NoDataFoundWidget();
        } else {
          return SafeArea(
            child: SingleChildScrollView(
              controller: controller,
              child: BodyPaddingWidget(
                child: Column(
                    children: [
                      SizedBox(height: 2.h,),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 20),
                        itemCount: profileController.paymentTransactions.length + 1,
                        itemBuilder: (context, index) {
                          if (index < profileController.paymentTransactions.length) {
                            final transaction = profileController.paymentTransactions[index];
                            return transactionTile(
                              orderID: transaction.orderId!,
                              amount: transaction.totalAmount!,
                              date: Helpers.formatDateTime(dateTime: transaction.createdAt!),
                              status: transaction.paymentStatus!,
                            );
                          } else {
                            return Obx(() {
                              if (profileController.areMorePaymentTransactionsAvailable.value) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 32.0),
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              } else {
                                return const SizedBox();
                              }
                            });
                          }
                        }, separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 1.h,);
                      },
                      ),
                    ]
                ),
              ),
            ),
          );
        }
      }),

    );
  }


  Widget transactionTile({required String orderID,required  double amount,required  String date,required  String status}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1.2),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          RowWidget(text1: orderID, text2: 'Rs. ${amount.toStringAsFixed(2)}', isLast: true,),
          RowWidget(text1: date, text2: status, isLast: true, textColor: textLightColor,),
        ],
      ),
    );
  }
}