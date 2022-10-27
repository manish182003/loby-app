import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/presentation/getx/controllers/order_controller.dart';
import 'package:loby/presentation/widgets/body_padding_widget.dart';
import 'package:loby/presentation/widgets/custom_loader.dart';
import 'package:sizer/sizer.dart';

import 'dispute_widget.dart';

class DisputeScreenTab extends StatefulWidget {
  final String status;
  const DisputeScreenTab({Key? key,required this.status}) : super(key: key);

  @override
  State<DisputeScreenTab> createState() => _DisputeScreenTabState();
}

class _DisputeScreenTabState extends State<DisputeScreenTab> {

  OrderController orderController = Get.find<OrderController>();
  final controller = ScrollController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        orderController.getDisputes(status: widget.status);
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
    return BodyPaddingWidget(
      child: Obx(() {
        if (orderController.isDisputesFetching.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (orderController.disputes.isEmpty) {
          return const NoDataFoundWidget();
        } else {
          return SafeArea(
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                  children: [
                    SizedBox(height: 2.h,),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: orderController.disputes.length + 1,
                      itemBuilder: (context, index) {
                        if (index < orderController.disputes.length) {
                          final dispute = orderController.disputes[index];
                          return DisputeWidget(
                            disputeType: widget.status,
                            currentStatus: 'Resolved on July 20th 2022',
                            dispute: dispute,
                          );
                        } else {
                          return Obx(() {
                            if (orderController.areMoreDisputesAvailable.value) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 32.0),
                                child: Center(child: CircularProgressIndicator()),
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
          );
        }
      }),
    );
  }
}
