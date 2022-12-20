import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/order/order.dart';
import 'package:loby/domain/entities/order/order_status.dart';
import 'package:loby/presentation/getx/controllers/order_controller.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/widgets/buttons/custom_button.dart';
import 'package:loby/presentation/widgets/follow_btn.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../getx/controllers/home_controller.dart';
import 'order_status_constants.dart';
import 'order_status_tile.dart';

class StatusBottomSheet extends StatelessWidget {
  final int orderId;
  const StatusBottomSheet({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    ProfileController profileController = Get.find<ProfileController>();
    OrderController orderController = Get.find<OrderController>();
    HomeController homeController = Get.find<HomeController>();

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Update Status', style: textTheme.headline2?.copyWith(color: textWhiteColor)),
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SvgPicture.asset(
                      'assets/icons/close_icon.svg',
                      height: 14,
                      width: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: shipGreyColor,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        final order = orderController.orders.where((e) => e.id == orderId).toList().first;
                        final isDuel = order.userGameService!.category!.name == 'Duel';
                        final isSeller = profileController.profile.id == order.userGameService?.userId;

                        return ListView.builder(
                          itemCount: isDuel ? duelStatuses.length : isSeller ? sellerStatuses.length : buyerStatuses.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 16),
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, index) {
                            final isStatic = index > order.orderStatuses!.length - 1;
                            if (isDuel) {
                              debugPrint("duel");
                              debugPrint("static $isStatic");
                              // if(index == 3 && !isStatic && order.orderStatuses![index].status! == buyerDeliveryConfirmed){
                              //   if(duelStatuses[4] != duelStatusesName[sellerDeliveryConfirmed]){
                              //     duelStatuses[4] = duelStatusesName[sellerDeliveryConfirmed];
                              //   }
                              // }
                              return OrderStatusTile(
                                order: order,
                                orderId: order.id!,
                                sellerId: order.userGameService!.userId!,
                                buyerId: order.userId!,
                                isDone: isStatic ? false : statuses.contains(order.orderStatuses![index].status),
                                title: isStatic ? duelStatuses[index] : duelStatusesName[order.orderStatuses![index].status!],
                                date: isStatic ? '' : daysRemaining(order, index),
                                isLast: isStatic ? false : order.orderStatuses![index].status! == order.orderStatuses!.last.status!,
                                lastStatus: order.orderStatuses!.last.status!,
                                isSeller: isSeller,
                                isDuel: true,
                                isDisputeRaised : order.disputeId != null,
                              );
                            } else if (isSeller) {
                              debugPrint("seller");
                              return OrderStatusTile(
                                order: order,
                                orderId: order.id!,
                                sellerId: order.userGameService!.userId!,
                                buyerId: order.userId!,
                                isDone: isStatic ? false : statuses.contains(order.orderStatuses![index].status),
                                title: isStatic ? sellerStatuses[index] : statusesName[order.orderStatuses![index].status!],
                                date: isStatic ? '' : daysRemaining(order, index),
                                isLast: isStatic ? false : order.orderStatuses![index].status! == order.orderStatuses!.last.status!,
                                lastStatus: order.orderStatuses!.last.status!,
                                isSeller: true,
                                isDisputeRaised : order.disputeId != null,
                              );
                            } else {
                              debugPrint("buyer");
                              return OrderStatusTile(
                                order: order,
                                orderId: order.id!,
                                sellerId: order.userGameService!.userId!,
                                buyerId: order.userId!,
                                isDone: isStatic ? false : statuses.contains(order.orderStatuses![index].status),
                                title: isStatic ? buyerStatuses[index] : statusesName[order.orderStatuses![index].status!],
                                date: isStatic ? '' : daysRemaining(order, index),
                                isLast: isStatic ? false : order.orderStatuses![index].status! == order.orderStatuses!.last.status!,
                                lastStatus: order.orderStatuses!.last.status!,
                                isDisputeRaised : order.disputeId != null,
                              );
                            }
                          },
                        );
                      }),
                      SizedBox(height: 2.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String daysRemaining(Order order, int index){
    if(order.orderStatuses!.last.status! == lobyProtectionPeriod){
      if(order.orderStatuses![index].status! == lobyProtectionPeriod){
        HomeController homeController = Get.find<HomeController>();
        final days = int.tryParse(homeController.staticData[1].realValue!);
        return '${Helpers.daysBetween(order.orderStatuses![index].createdAt!, DateTime.now().add(Duration(days: days!)))} Days Remaining of $days';
      }else{
        return '${Helpers.formatDateTime(dateTime: order.orderStatuses![index].createdAt!)}';
      }
    }else{
      return '${Helpers.formatDateTime(dateTime: order.orderStatuses![index].createdAt!)}';
    }
  }
}
