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
import '../../../../../../core/utils/constants.dart';
import '../../../../../../services/routing_service/routes_name.dart';
import '../../../../../getx/controllers/listing_controller.dart';
import '../../../../../widgets/ConfirmationRiseDisputeBottomDialog.dart';
import '../../../../../widgets/buttons/custom_button.dart';
import 'order_status_constants.dart';

class OrderItem extends StatelessWidget {
  final Order order;
  final String tabitem;
  OrderItem({super.key, required this.order, required this.tabitem});

  final CustomPopupMenuController _controller = CustomPopupMenuController();
  final OrderController orderController = Get.find<OrderController>();
  final ListingController listingController = Get.find<ListingController>();
  // String fromtimeIn24HourFormat = "${order.bookfromtime}";
  // DateTime fromtime24Hour = DateFormat('HH:mm').parse(fromtimeIn24HourFormat);
  // String fromtimeIn12HourFormat = DateFormat('h:mm a').format(fromtime24Hour);

  // String totimeIn24HourFormat = "${order.booktotime}";
  // DateTime totime24Hour = DateFormat('HH:mm').parse(totimeIn24HourFormat);
  // String totimeIn12HourFormat = DateFormat('h:mm a').format(totime24Hour);

  @override
  Widget build(BuildContext context) {
    print("myyyorderssssssssssss   ${orderController.orders}");
    print("orderstatussss $order");
    print("order.slotId ${order.slotId}");
    print("createee ${order.createdAt}");
    print("quant >>>> ${order.quantity}");
    print("frommmm ${order.bookfromtime}");
    print("tooooooooo ${order.booktotime}");
    print("dateeee ${order.bookDate}");
    print("useriddddd ${order.userGameService?.userId}");
    // String fromtimeIn24HourFormat = "${order.bookfromtime}";
    // DateTime fromtime24Hour = DateFormat('HH:mm').parse(fromtimeIn24HourFormat);
    // String fromtimeIn12HourFormat = DateFormat('h:mm a').format(fromtime24Hour);

    // String totimeIn24HourFormat = "${order.booktotime}";
    // DateTime totime24Hour = DateFormat('HH:mm').parse(totimeIn24HourFormat);
    // String totimeIn12HourFormat = DateFormat('h:mm a').format(totime24Hour);
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
            child: Stack(children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          listingController.totalPrice.value =
                              (listingController.quantityCount.value *
                                      order.userGameService!.price!)
                                  .toString();
                          context.pushNamed(gameDetailPage, extra: {
                            'serviceListingId': "${order.userGameService!.id}",
                            'from': ListingPageRedirection.order
                          });
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: SizedBox(
                              height: 85.0,
                              child: CustomCachedNetworkImage(
                                imageUrl: Helpers.getListingImage(
                                    order.userGameService!),
                                placeHolder: Image.asset(
                                  "assets/images/listing_placeholder.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
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
                                  style: textTheme.headlineSmall
                                      ?.copyWith(color: textWhiteColor)),
                            ),
                            SizedBox(height: 1.5.h),
                            Text(order.userGameService!.game?.name! ?? "",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: textTheme.titleLarge
                                    ?.copyWith(color: textInputTitleColor)),
                            SizedBox(height: 1.0.h),
                            Text(order.userGameService!.category?.name! ?? "",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: textTheme.titleLarge
                                    ?.copyWith(color: textInputTitleColor)),
                            SizedBox(height: 1.0.h),
                            // Text(
                            //     "Listing By ${order.userGameService!.user?.displayName ?? ""}",
                            //     overflow: TextOverflow.ellipsis,
                            //     maxLines: 1,
                            //     style: textTheme.headline6
                            //         ?.copyWith(color: textInputTitleColor)),
                            // SizedBox(
                            //   height: 1.h,
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Current Status :",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: textTheme.headlineMedium?.copyWith(
                                      fontSize: 11.0, color: textLightColor),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(
                                  order.disputeId != null
                                      ? 'Dispute Raised'
                                      : order.userGameService!.category!.name ==
                                              "Duel"
                                          ? duelStatusesName[
                                              order.orderStatuses!.last.status!]
                                          : statusesName[order
                                              .orderStatuses!.last.status!],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: textTheme.headlineMedium?.copyWith(
                                      fontSize: 11.0,
                                      color: order.disputeId != null
                                          ? carminePinkColor
                                          : order.orderStatuses!.last.status! ==
                                                  sellerRejected
                                              ? carminePinkColor
                                              : aquaGreenColor),
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
                      name: order.disputeId != null
                          ? 'View Disputes'
                          : "Update Status",
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
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: CustomBottomSheet(
                                    isDismissible: false,
                                    initialChildSize: 0.6,
                                    maxChildSize: 0.8,
                                    minChildSize: 0.6,
                                    horizontalPadding: 0.0,
                                    sheetRadius: 16,
                                    child:
                                        StatusBottomSheet(orderId: order.id!)),
                              );
                            },
                          ); // await Helpers.hideLoader();
                        } else {
                          orderController.disputes.clear();
                          context.pushNamed(createNewDisputePage,
                              extra: {'disputeId': "${order.disputeId}"});
                        }
                      }),
                  // order.slotId == null
                  //     ?
                  //  orderController.orders.first.orderStatuses!.first.status == "BOUGHT" ?
                  tabitem == 'Bought' &&
                          order.orderStatuses!.last.status! == "ORDER_PLACED"
                      ? GestureDetector(
                          onTap: () {
                            orderController.selectedOrder.value = order;
                            orderController.selectedOrder.refresh();
                            context.pushNamed(buyerTimeSlotScreen, extra: {
                              "id": "${order.userGameService?.userId}"
                            }, pathParameters: {
                              "id": "${order.userGameService?.userId}"
                            }
                                // extra: {"isEditing": "false"}
                                );
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(color: butterflyBlueColor),
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      order.bookDate == null
                                          ? "Book Available Slots"
                                          : "${order.bookfromtime} - ${order.booktotime}",
                                      style: textTheme.displaySmall?.copyWith(
                                          color: whiteColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    const Icon(Icons.mode_edit_outlined,
                                        color: whiteColor)
                                  ]),
                            ),
                          ),
                        )

                      // CustomButton(
                      //     color: backgroundBalticSeaColor,
                      //     borderColor: butterflyBlueColor,
                      //     name: order.bookDate == null ? "Book Available Slots" : "${order.bookDate}",
                      //     top: 2.h,

                      //     bottom: 2.h,
                      //     textColor: whiteColor,

                      //     onTap: () {
                      //       orderController.selectedOrder.value = order;
                      //       orderController.selectedOrder.refresh();
                      //       context.pushNamed(buyerTimeSlotScreen,
                      //           params: {"id": "${order.userGameService?.userId}"}
                      //           // extra: {"isEditing": "false"}
                      //           );
                      //     })
                      : tabitem == 'Bought'
                          ? GestureDetector(
                              onTap: () {
                                Helpers.toast(
                                    "cannot edit slot after seller accepted order");
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: butterflyBlueColor
                                            .withOpacity(0.5)),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          order.bookDate == null
                                              ? "Book Available Slots"
                                              : "${order.bookfromtime} - ${order.booktotime}",
                                          style: textTheme.displaySmall
                                              ?.copyWith(
                                                  color: whiteColor
                                                      .withOpacity(0.5),
                                                  fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        Icon(
                                          Icons.mode_edit_outlined,
                                          color: whiteColor.withOpacity(0.5),
                                        )
                                      ]),
                                ),
                              ),
                            )
                          // CustomButton(
                          // color: backgroundBalticSeaColor,
                          // borderColor: butterflyBlueColor.withOpacity(0.5),
                          // name: order.bookDate == null ? "Book Available Slots" : "${order.bookDate}",
                          // top: 2.h,

                          // bottom: 2.h,
                          // textColor: whiteColor.withOpacity(0.5),

                          // onTap: () {
                          //   Helpers.toast("cannot edit slot after seller accepted order");
                          // })
                          : const SizedBox()
                ],
              ),
              order.orderStatuses!.last.status! == orderCompleted
                  ? const SizedBox()
                  : order.orderStatuses!.last.status! == orderPlaced
                      ? const SizedBox()
                      : order.orderStatuses!.last.status! == sellerRejected
                          ? const SizedBox()
                          : order.disputeId != null
                              ? const SizedBox()
                              : Positioned(
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: ['Raise Dispute']
                                                .map(
                                                  (item) => GestureDetector(
                                                    behavior: HitTestBehavior
                                                        .translucent,
                                                    onTap: () {
                                                      _controller.hideMenu();
                                                      ConfirmationRiseDisputeBottomDialog(
                                                          textTheme: textTheme,
                                                          contentName:
                                                              "Are you sure you want raise a dispute against this order ?",
                                                          yesBtnClick:
                                                              () async {
                                                            Helpers.loader();
                                                            final isSuccess =
                                                                await orderController.raiseDispute(
                                                                    orderId:
                                                                        order
                                                                            .id!,
                                                                    description:
                                                                        "nothing");
                                                            Helpers
                                                                .hideLoader();
                                                            if (isSuccess) {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              context.pushNamed(
                                                                  myDisputePage);
                                                            }
                                                          }).showBottomDialog(context);
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 20),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 10),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          10),
                                                              child: Text(
                                                                item,
                                                                style: textTheme
                                                                    .titleLarge
                                                                    ?.copyWith(
                                                                        color:
                                                                            textWhiteColor),
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
