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
import 'package:sizer/sizer.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../../data/models/ItemModel.dart';
import '../../../../../../services/routing_service/routes_name.dart';
import '../../../../../widgets/ConfirmationRiseDisputeBottomDialog.dart';
import '../../../../../widgets/UpdateStatusDialog.dart';
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
                        child: CachedNetworkImage(
                          imageUrl: order.userGameService!.game?.image ?? "",
                          fit: BoxFit.cover,
                          height: 110,
                          width: 110,
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.white,)),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
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
                        SizedBox(
                          child: Text(order.userGameService!.game?.name! ?? "",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: textTheme.headline6?.copyWith(color: textInputTitleColor)),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: orangeColor,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                                child: Text(order.userGameService!.category!.name!, style: textTheme.headline6?.copyWith(color: textWhiteColor)),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            GestureDetector(
                              onTap: () {

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
                                          child: StatusBottomSheet(orderId: order.id!)),
                                    );
                                  },
                                );

                                // UpdateStatusDialog(
                                //         textTheme: textTheme,
                                //         tileName: "Congratulations",
                                //         titleColor: aquaGreenColor,
                                //         contentName: "Your service has been successfully listed. You can edit your listings from My Listings.",
                                //         contentLinkName: ' My Listings').showBottomDialog(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: butterflyBlueColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8.0),
                                  child: Text('Update Status',
                                      style: textTheme.headline6?.copyWith(color: textWhiteColor)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          children: [
                            Text(
                              "Current Status : ",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: textTheme.headline4?.copyWith(
                                  fontSize: 11.0, color: textLightColor),
                            ),
                            const SizedBox(width: 2.0),
                            Text(
                              statusesName[order.orderStatuses!.last.status!],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: textTheme.headline4?.copyWith(
                                  fontSize: 11.0, color: aquaGreenColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              order.orderStatuses!.last.status! == 'ORDER_COMPLETED' ? const SizedBox() : Positioned(
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
                                                style: textTheme.headline6
                                                    ?.copyWith(
                                                        color: textWhiteColor),
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
