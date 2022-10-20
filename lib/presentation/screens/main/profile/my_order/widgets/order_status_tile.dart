import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loby/data/models/order/order_model.dart';
import 'package:loby/domain/entities/order/order.dart';
import 'package:loby/presentation/getx/controllers/core_controller.dart';
import 'package:loby/presentation/getx/controllers/order_controller.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/screens/main/profile/my_order/widgets/select_duel_winner_dialog.dart';
import 'package:loby/presentation/widgets/rating_dialog.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../../core/utils/helpers.dart';
import '../../../../../widgets/buttons/custom_button.dart';

class OrderStatusTile extends StatelessWidget {
  final int orderId;
  final int sellerId;
  final int buyerId;
  final bool isDone;
  final String title;
  final String date;
  final bool isSeller;
  final bool isDuel;
  final bool isLast;
  final bool isDisputeRaised;
  final String lastStatus;

  const OrderStatusTile(
      {Key? key, required this.orderId, required this.isDone, required this.title, required this.date, this.isSeller = false, this.isDuel = false, required this.isLast, this.isDisputeRaised = false, required this.lastStatus, required this.sellerId, required this.buyerId,})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    double rating = 0.0;
    TextEditingController review = TextEditingController();

    return Column(
        children: [
          _statusTile(textTheme, isDone: isDone, title: title, date: date),
          SizedBox(height: 2.h),

          /// if Dispute is Raised ///
          isLast ? isDisputeRaised ?
          Column(
            children: [
              _statusTile(textTheme, isDone: true,
                  title: isDuel ? "Seller & Challenger selection doesn’t match. Dispute Raised. Transaction on hold" : "Dispute Raised. Transaction on hold",
                  date: date),
              SizedBox(height: 2.h),
            ],
          ) :


          isSeller ? isDuel ?

          /// if Duel (Seller) ///
          lastStatus == 'ORDER_PLACED' ? _duelOrderPlaced(context) :
          lastStatus == 'ORDER_IN_PROGRESS' ? _selectDuelWinner(context) :
          lastStatus == 'BUYER_DELIVERY_CONFIRMED' ? _selectDuelWinner(context) :
          const SizedBox() :

          /// else normal seller ///
          _seller(context, textTheme) :

          /// if Duel (Buyer) ///
          isDuel ?
          lastStatus == 'ORDER_IN_PROGRESS' ? _selectDuelWinner(context) :
          lastStatus == 'SELLER_DELIVERY_CONFIRMED' ? _selectDuelWinner(context) :
          const SizedBox() :

          /// else normal Buyer ///
          _buyer(context, rating, review) :
          const SizedBox()
        ]
    );
  }

  Widget _statusTile(TextTheme textTheme,
      {required bool isDone, required String title, required String date}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/verified_user_bedge.svg',
                height: 18,
                width: 18,
                color: isDone ? null : iconWhiteColor,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(title,
                    // maxLines: 3,
                    // overflow: TextOverflow.ellipsis,
                    style: textTheme.headline5?.copyWith(color: textWhiteColor)),
              ),
            ],
          ),
        ),
        Text(date,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: textTheme.headline5?.copyWith(
                color: textLightColor)),
      ],
    );
  }

  Widget _duelOrderPlaced(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomButton(
                color: orangeColor,
                name: "Reject Duel",
                textColor: textWhiteColor,
                left: 0.w,
                right: 0.w,
                radius: 50,
                onTap: () async {
                  changeOrderStatus(context, status: 'SELLER_REJECTED');
                },
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: CustomButton(
                color: purpleLightIndigoColor,
                name: "Accept Duel",
                textColor: textWhiteColor,
                radius: 50,
                onTap: () async {
                  changeOrderStatus(context, status: 'SELLER_ACCEPTED');
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
      ],
    );
  }

  Widget _selectDuelWinner(BuildContext context) {
    return Column(
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Expanded(
        //       child: CustomButton(
        //         color: orangeColor,
        //         name: "Challenger",
        //         textColor: textWhiteColor,
        //         left: 0.w,
        //         right: 0.w,
        //         radius: 50,
        //         onTap: () async {
        //           if(isSeller){
        //             selectDuelWinner(context, winnerId: buyerId, status: 'BUYER_DELIVERY_CONFIRMED');
        //           }else{
        //             selectDuelWinner(context, winnerId: sellerId, status: 'SELLER_DELIVERY_CONFIRMED');
        //           }
        //         },
        //       ),
        //     ),
        //     SizedBox(width: 4.w),
        //     Expanded(
        //       child: CustomButton(
        //         color: purpleLightIndigoColor,
        //         name: "You",
        //         textColor: textWhiteColor,
        //         radius: 50,
        //         onTap: () async {
        //           if(isSeller){
        //             selectDuelWinner(context, winnerId: sellerId, status: 'SELLER_DELIVERY_CONFIRMED');
        //           }else{
        //             selectDuelWinner(context, winnerId: buyerId, status: 'BUYER_DELIVERY_CONFIRMED');
        //           }
        //         },
        //       ),
        //     ),
        //   ],
        // ),
        // SizedBox(height: 2.h),
        CustomButton(
          color: purpleLightIndigoColor,
          name: "Select Winner",
          textColor: textWhiteColor,
          radius: 50,
          onTap: () async {
            _selectDuelWinnerDialog(context);
            // _openFileExplorer(context);
          },
        ),
        SizedBox(height: 2.h),
      ],
    );
  }

  Widget _seller(BuildContext context, TextTheme textTheme) {
    return Column(
      children: [
        lastStatus == 'ORDER_PLACED' ? Padding(
          padding: EdgeInsets.only(bottom: 2.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomButton(
                  color: orangeColor,
                  name: "Reject Order",
                  textColor: textWhiteColor,
                  left: 0.w,
                  right: 0.w,
                  radius: 50,
                  onTap: () async {
                    changeOrderStatus(context, status: 'SELLER_REJECTED');
                  },
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: CustomButton(
                  color: purpleLightIndigoColor,
                  name: "Accept Order",
                  textColor: textWhiteColor,
                  radius: 50,
                  onTap: () async {
                    changeOrderStatus(context, status: 'SELLER_ACCEPTED');
                  },
                ),
              ),
            ],
          ),
        ) : lastStatus == "ORDER_IN_PROGRESS" ? Padding(
          padding: EdgeInsets.only(bottom: 2.h),
          child: CustomButton(
            color: purpleLightIndigoColor,
            name: "Upload Proofs & Confirm Delivery",
            textColor: textWhiteColor,
            radius: 50,
            onTap: () async {
              _openFileExplorer(context, status: 'SELLER_DELIVERY_CONFIRMED');
            },
          ),
        ) : const SizedBox(),

        lastStatus == "ORDER_PLACED" ? Padding(
          padding: EdgeInsets.only(bottom: 2.h),
          child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(children: [
                TextSpan(
                  text: 'Sellers are requsted to discuss & freeze all delivery details with buyer on ',
                  style: textTheme.subtitle1?.copyWith(color: textLightColor),
                ),
                TextSpan(
                    text: 'Loby Chat ',
                    style: textTheme.subtitle1?.copyWith(
                        color: aquaGreenColor)),
                TextSpan(
                    text: 'before accpecting or declining the Order. Any conversation outside Loby Chat will not be insured/covered by Loby Protection',
                    style: textTheme.subtitle1?.copyWith(
                        color: textLightColor)),
              ])),
        ) : const SizedBox(),
      ],
    );
  }

  Widget _buyer(BuildContext context, double rating,
      TextEditingController review) {
    return lastStatus == "SELLER_DELIVERY_CONFIRMED" ? Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomButton(
                color: orangeColor,
                name: "Reject Delivery",
                textColor: textWhiteColor,
                left: 0.w,
                right: 0.w,
                radius: 50,
                onTap: () async {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return RatingDialog(
                          title: "Review & Rating",
                          descriptions: "Congratulations on successfully getting your service delivered. Kindly rate thus seller & its service to help us serve you better",
                          text: "OK",
                          review: review,
                          onChanged: (star) {
                            rating = star;
                          },
                          onSubmit: () async {
                            confirmDelivery(
                                context, status: 'BUYER_DELIVERY_REJECTED',
                                rating: rating,
                                review: review.text);
                          },
                        );
                      });
                },
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: CustomButton(
                color: purpleLightIndigoColor,
                name: "Confirm Delivery",
                textColor: textWhiteColor,
                radius: 50,
                onTap: () async {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return RatingDialog(
                          title: "Review & Rating",
                          descriptions: "Congratulations on successfully getting your service delivered. Kindly rate thus seller & its service to help us serve you better",
                          text: "OK",
                          review: review,
                          onChanged: (star) {
                            rating = star;
                          },
                          onSubmit: () async {
                            confirmDelivery(
                                context, status: 'BUYER_DELIVERY_CONFIRMED',
                                rating: rating,
                                review: review.text);
                          },
                        );
                      });
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
      ],
    ) : const SizedBox();
  }


  void selectDuelWinner(BuildContext context, {required int winnerId, required String status}) async {
    OrderController orderController = Get.find<OrderController>();
    await Helpers.loader();
    final isSuccess = await orderController.selectDuelWinner(winnerId: winnerId, orderId: orderId);
    if (isSuccess) {
      await orderController.changeOrderStatus(orderId: orderId, status: status);
      await orderController.uploadDeliveryProof(
        orderId: orderId,
        fileTypes: orderController.selectedDuelProofs.map((element) => element.fileType).toList(),
        files: orderController.selectedDuelProofs.map((element) => element.file).toList(),
      );
      await getOrders();
      orderController.selectedUser.value = "";
      orderController.duelWinner.value = "";
      orderController.selectedDuelProofs.clear();
      await Helpers.hideLoader();
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      await Helpers.hideLoader();
    }
  }

  void confirmDelivery(BuildContext context,
      {required String status, required double rating, String? review}) async {
    OrderController orderController = Get.find<OrderController>();
    CoreController coreController = Get.find<CoreController>();
    await Helpers.loader();
    final isSuccess = await orderController.submitRating(
        orderId: orderId, stars: rating, review: review);
    if (isSuccess) {
      await orderController.changeOrderStatus(orderId: orderId, status: status);
      await getOrders();
      print("confrm delivery ${orderController.orders
          .where((p0) => p0.id == orderId)
          .toList()
          .first
          .userGameService
          ?.userGameServiceImages ?? 'null'}");
      coreController.socket.emit("loby", {
        'type': 'order',
        'receiverId': sellerId,
        'order': (orderController.orders
            .where((e) => e.id == orderId)
            .toList()
            .first as OrderModel).toJson(),
      });
      await Helpers.hideLoader();
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      await Helpers.hideLoader();
    }
  }

  void changeOrderStatus(BuildContext context, {required String status}) async {
    OrderController orderController = Get.find<OrderController>();
    CoreController coreController = Get.find<CoreController>();
    await Helpers.loader();
    final isSuccess = await orderController.changeOrderStatus(
        orderId: orderId, status: status);
    if (isSuccess) {
      await getOrders();
      coreController.socket.emit("loby", {
        'type': 'order',
        'receiverId': buyerId,
        'order': (orderController.orders
            .where((e) => e.id == orderId)
            .toList()
            .first as OrderModel).toJson(),
      });
      await Helpers.hideLoader();
      Navigator.pop(context);
    } else {
      await Helpers.hideLoader();
    }
  }

  void _openFileExplorer(BuildContext context, {String? status}) async {
    OrderController orderController = Get.find<OrderController>();
    CoreController coreController = Get.find<CoreController>();
    List<PlatformFile> paths = [];
    try {
      paths = (await FilePicker.platform.pickFiles(
        allowMultiple: true,
        onFileLoading: (FilePickerStatus status) => print(status),
      ))!.files;

      await Helpers.loader();
      await orderController.uploadDeliveryProof(
        orderId: orderId,
        fileTypes: paths.map((e) => Helpers.getFileType(e.extension!)).toList(),
        files: paths.map((e) => File(e.path!)).toList(),
      );
      if (status != null) {
        await orderController.changeOrderStatus(orderId: orderId, status: status);
      }
      await getOrders();
      coreController.socket.emit("loby", {
        'type': 'order',
        'receiverId': buyerId,
        'order': (orderController.orders
            .where((e) => e.id == orderId)
            .toList()
            .first as OrderModel).toJson(),
      });
      await Helpers.hideLoader();
      Navigator.pop(context);
    } on PlatformException catch (e) {
      Helpers.toast('Unsupported operation$e');
    } catch (e) {
      Helpers.toast('Something went wrong');
    }
  }


  Future<void> getOrders() async {
    OrderController orderController = Get.find<OrderController>();
    orderController.ordersPageNumber.value = 1;
    orderController.areMoreOrdersAvailable.value = true;
    await orderController.getOrders(status: isSeller ? 'SOLD' : 'BOUGHT');
  }


  void _selectDuelWinnerDialog(BuildContext context) {
    OrderController orderController = Get.find<OrderController>();
    final duelUsers = orderController.duelUsers;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: backgroundDarkJungleGreenColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0)),
          child: SelectDuelWinnerDialog(
            onSelectWinner: (value){
              if(value.toString() == duelUsers[0]){
                if(isSeller){
                  orderController.duelWinner.value = "$buyerId/BUYER_DELIVERY_CONFIRMED";
                }else{
                  orderController.duelWinner.value = "$sellerId/SELLER_DELIVERY_CONFIRMED";
                }
              }else{
                if(isSeller){
                  orderController.duelWinner.value = "$sellerId/SELLER_DELIVERY_CONFIRMED";
                }else{
                  orderController.duelWinner.value = "$buyerId/BUYER_DELIVERY_CONFIRMED";
                }
              }
              orderController.selectedUser.value = value.toString();
              debugPrint(orderController.duelWinner.value);
            },
            onSubmit: () {
              if(orderController.duelWinner.isEmpty){
                Helpers.toast("Please Select Winner");
              }else if(orderController.selectedDuelProofs.isEmpty){
                Helpers.toast("Please Upload Proofs");
              }else{
                selectDuelWinner(
                    context,
                    winnerId: int.tryParse(orderController.duelWinner.value.split("/")[0])!,
                    status: orderController.duelWinner.value.split("/")[1]
                );
              }
            },
          )
        );
      },
    );
  }
}
