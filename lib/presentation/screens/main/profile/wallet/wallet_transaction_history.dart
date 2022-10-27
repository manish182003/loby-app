import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/screens/main/notification/widgets/notification_item_widget.dart';
import 'package:loby/presentation/screens/main/profile/wallet/widgets/transaction_tile.dart';
import 'package:loby/presentation/widgets/custom_loader.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../widgets/body_padding_widget.dart';
import '../../../../widgets/custom_app_bar.dart';

class WalletTransactionHistory extends StatefulWidget {
  const WalletTransactionHistory({Key? key}) : super(key: key);

  @override
  State<WalletTransactionHistory> createState() => _WalletTransactionHistoryState();
}

class _WalletTransactionHistoryState extends State<WalletTransactionHistory> {

  ProfileController profileController = Get.find<ProfileController>();
  final controller = ScrollController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.walletTransactionsPageNumber.value = 1;
      profileController.areMoreWalletTransactionsAvailable.value = true;
      profileController.getWalletTransactions();
    });

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        profileController.getWalletTransactions();
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
      appBar: appBar(context: context, appBarName: 'Wallet Transactions'),
      body: Obx(() {
      if (profileController.isWalletTransactionsFetching.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (profileController.walletTransactions.isEmpty) {
        return const NoDataFoundWidget();
      } else {
        return SafeArea(
          child: SingleChildScrollView(
            controller: controller,
            child: BodyPaddingWidget(
              child: Column(
                children: [
                  SizedBox(height: 2.h,),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: profileController.walletTransactions.length + 1,
                    itemBuilder: (context, index) {
                      if (index < profileController.walletTransactions.length) {
                        final transaction = profileController.walletTransactions[index];
                        return TransactionTile(
                          title: transaction.type == 'C' ? 'Tokens Credited' : 'Tokens Debited',
                          desc: transaction.details!,
                          date: Helpers.formatDateTime(dateTime: transaction.createdAt!),
                          amount: transaction.amount.toString(),
                          isDebited: transaction.type == 'C' ? false : true,
                        );
                      } else {
                        return Obx(() {
                          if (profileController.areMoreWalletTransactionsAvailable.value) {
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
}
