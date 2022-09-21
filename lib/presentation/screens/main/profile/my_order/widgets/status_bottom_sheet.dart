import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/order/order.dart';
import 'package:loby/domain/entities/order/order_status.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/widgets/buttons/custom_button.dart';
import 'package:loby/presentation/widgets/follow_btn.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/theme/colors.dart';
import 'order_status_constants.dart';
import 'order_status_tile.dart';

class StatusBottomSheet extends StatelessWidget {
  final Order order;
  const StatusBottomSheet({Key? key, required this.order}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    ProfileController profileController = Get.find<ProfileController>();
    final isDuel = order.userGameService!.category!.name == 'Duel';
    final isSeller = profileController.profile.id == order.userGameService?.userId;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Text('Update Status',
                    textAlign: TextAlign.center,
                    style: textTheme.headline2?.copyWith(color: textWhiteColor)),
              ),
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
                      ListView.builder(
                        itemCount: isDuel ? duelStatuses.length : isSeller ? sellerStatuses.length : buyerStatuses.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 16),
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index) {
                          final isStatic = index > order.orderStatuses!.length - 1;
                          if(isDuel){
                            print("duel");
                            return OrderStatusTile(
                              orderId: order.id!,
                              challengerId: order.userGameService!.userId!,
                              myId: order.userId!,
                              isDone: isStatic ? false : statuses.contains(order.orderStatuses![index].status),
                              title: isStatic ? duelStatuses[index] : order.orderStatuses![index].status!,
                              date: isStatic ?  '' : order.orderStatuses![index].createdAt!.toString(),
                              isLast: isStatic ?  false : order.orderStatuses![index].status! == order.orderStatuses!.last.status!,
                              lastStatus: order.orderStatuses!.last.status!,
                              isSeller : isSeller,
                              isDuel : true,
                            );
                          }else if(isSeller){
                            print("seller");
                            return OrderStatusTile(
                              orderId: order.id!,
                              challengerId: order.userGameService!.userId!,
                              myId: order.userId!,
                              isDone: isStatic ? false : statuses.contains(order.orderStatuses![index].status),
                              title: isStatic ? sellerStatuses[index] : order.orderStatuses![index].status!,
                              date: isStatic ?  '' : order.orderStatuses![index].createdAt!.toString(),
                              isLast: isStatic ?  false : order.orderStatuses![index].status! == order.orderStatuses!.last.status!,
                              lastStatus: order.orderStatuses!.last.status!,
                              isSeller : true,
                            );
                          }else{
                            print("buyer");
                            return OrderStatusTile(
                              orderId: order.id!,
                              challengerId: order.userGameService!.userId!,
                              myId: order.userId!,
                              isDone: isStatic ? false : statuses.contains(order.orderStatuses![index].status),
                              title: isStatic ? buyerStatuses[index] : order.orderStatuses![index].status!,
                              date: isStatic ?  '' : order.orderStatuses![index].createdAt!.toString(),
                              isLast: isStatic ?  false : order.orderStatuses![index].status! == order.orderStatuses!.last.status!,
                              lastStatus: order.orderStatuses!.last.status!,
                            );
                          }
                        },
                      ),
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
}
