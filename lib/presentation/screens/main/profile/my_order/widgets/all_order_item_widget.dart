import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/order/order.dart';
import 'package:loby/presentation/getx/controllers/order_controller.dart';
import 'package:loby/presentation/screens/main/profile/my_order/widgets/status_bottom_sheet.dart';
import 'package:loby/presentation/widgets/custom_bottom_sheet.dart';
import 'package:loby/presentation/widgets/custom_cached_network_image.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../../data/models/ItemModel.dart';
import '../../../../../../services/routing_service/routes_name.dart';
import '../../../../../widgets/ConfirmationRiseDisputeBottomDialog.dart';
import '../../../../../widgets/UpdateStatusDialog.dart';
import '../../../../../widgets/buttons/custom_button.dart';
import 'order_status_constants.dart';

class OrderItem extends StatelessWidget {
  final Order order;
  OrderItem({super.key, required this.order});

  final CustomPopupMenuController _controller = CustomPopupMenuController();
  final OrderController orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      color: backgroundBalticSeaColor,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
            child: Stack(
                children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: SizedBox(
                            height: 55.0,
                            child: CustomCachedNetworkImage(
                              imageUrl: Helpers.getListingImage(order.userGameService!),
                              placeHolder: Image.asset("assets/images/listing_placeholder.jpg", fit: BoxFit.cover,),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.66,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.48,
                              child: Text(order.userGameService!.title!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: textTheme.headline5?.copyWith(color: textWhiteColor)),
                            ),
                            SizedBox(height: 1.5.h),
                            Text(order.userGameService!.game?.name! ?? "",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: textTheme.headline6?.copyWith(color: textInputTitleColor)),
                            SizedBox(height: 1.0.h),
                            Text(order.userGameService!.category?.name! ?? "",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: textTheme.headline6?.copyWith(color: textInputTitleColor)),
                            SizedBox(height: 1.0.h),
                            Text("Listing By ${order.userGameService!.user?.displayName ?? ""}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: textTheme.headline6?.copyWith(color: textInputTitleColor)),
                            SizedBox(height: 1.h,),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Current Status",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: textTheme.headline4?.copyWith(
                                          fontSize: 11.0, color: textLightColor),
                                    ),
                                    SizedBox(height: 1.h,),
                                    Text(order.disputeId != null ? 'Dispute Raised': order.userGameService!.category!.name == "Duel" ? duelStatusesName[order.orderStatuses!.last.status!] :
                                    statusesName[order.orderStatuses!.last.status!],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: textTheme.headline4?.copyWith(fontSize: 11.0, color: order.disputeId != null ? carminePinkColor : order.orderStatuses!.last.status! == sellerRejected  ? carminePinkColor : aquaGreenColor),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 4.w),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: textTheme.headline4?.copyWith(
                                            fontSize: 11.0, color: textLightColor),
                                      ),
                                      SizedBox(height: 1.h,),
                                      Text(Helpers.formatDateTime(dateTime: order.createdAt!),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: textTheme.headline4?.copyWith(fontSize: 11.0, color: aquaGreenColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                  CustomButton(
                    color: butterflyBlueColor,
                    name: order.disputeId != null ? 'View Disputes' : "Update Status",
                    top: 2.h,
                    bottom: 2.h,
                    textColor: whiteColor,
                    onTap: () {
                      if (order.disputeId == null) {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          isDismissible: false,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: CustomBottomSheet(
                                  isDismissible: false,
                                  initialChildSize: 0.6,
                                  maxChildSize: 0.8,
                                  minChildSize: 0.6,
                                  horizontalPadding: 0.0,
                                  sheetRadius: 16,
                                  child: StatusBottomSheet(orderId: order.id!)),
                            );
                          },
                        );// await Helpers.hideLoader();
                      }else{
                        context.pushNamed(myDisputePage);
                      }
                    }
                  ),
                ],
              ),

              order.orderStatuses!.last.status! == orderCompleted ? const SizedBox() :
              order.orderStatuses!.last.status! == orderPlaced ? const SizedBox() :
              order.orderStatuses!.last.status! == sellerRejected ? const SizedBox() :
              order.disputeId != null ? const SizedBox() :
              Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: CustomPopupMenu(
                    arrowColor: lavaRedColor,
                    menuBuilder: () => ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        color: lavaRedColor,
                        child: IntrinsicWidth(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: ['Raise Dispute']
                                .map(
                                  (item) => GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      _controller.hideMenu();
                                      ConfirmationRiseDisputeBottomDialog(
                                        textTheme: textTheme,
                                        contentName: "Are you sure you want raise a dispute against this order ?",
                                        yesBtnClick: ()async{
                                          Helpers.loader();
                                          final isSuccess = await orderController.raiseDispute(orderId: order.id!, description: "nothing");
                                          Helpers.hideLoader();
                                          if(isSuccess){
                                            Navigator.of(context).pop();
                                            context.pushNamed(myDisputePage);
                                          }
                                        }
                                      ).showBottomDialog(context);
                                    },
                                    child: Container(
                                      height: 40,
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.only(left: 10),
                                              padding: const EdgeInsets.symmetric(vertical: 10),
                                              child: Text(
                                                item,
                                                style: textTheme.headline6?.copyWith(color: textWhiteColor),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                    pressType: PressType.singleClick,
                    verticalMargin: -10,
                    controller: _controller,
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      child: const Icon(Icons.more_vert,
                          size: 18.0, color: iconWhiteColor),
                    ),
                  ))
            ]),
          )
        ],
      ),
    );
  }
}
