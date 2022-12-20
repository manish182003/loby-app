import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/screens/main/profile/wallet/widgets/transaction_tile.dart';
import 'package:loby/presentation/widgets/custom_loader.dart';
import 'package:sizer/sizer.dart';
import '../../../../widgets/body_padding_widget.dart';
import '../../../../widgets/custom_app_bar.dart';

class EarningTransactionHistory extends StatefulWidget {
  const EarningTransactionHistory({Key? key}) : super(key: key);

  @override
  State<EarningTransactionHistory> createState() => _EarningTransactionHistoryState();
}

class _EarningTransactionHistoryState extends State<EarningTransactionHistory> {


  ProfileController profileController = Get.find<ProfileController>();
  final controller = ScrollController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.earningTransactionsPageNumber.value = 1;
      profileController.areMoreEarningTransactionsAvailable.value = true;
      profileController.getEarningTransactions();
    });


    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        profileController.getEarningTransactions();
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
      appBar: appBar(context: context, appBarName: 'Earning Transactions'),
      body: Obx(() {
        if (profileController.isEarningTransactionsFetching.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (profileController.earningTransactions.isEmpty) {
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
                        itemCount: profileController.earningTransactions.length + 1,
                        itemBuilder: (context, index) {
                          if (index < profileController.earningTransactions.length) {
                            final transaction = profileController.earningTransactions[index];
                            return TransactionTile(
                              title: transaction.type == 'C' ? 'Tokens Credited' : 'Tokens Debited',
                              isDebited: transaction.type == 'C' ? false : true,
                              transaction: transaction,
                            );
                          } else {
                            return Obx(() {
                              if (profileController.areMoreEarningTransactionsAvailable.value) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 32.0),
                                  child: Center(child: CircularProgressIndicator()),
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
