import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loby/domain/entities/order/order.dart';
import 'package:loby/presentation/getx/controllers/order_controller.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/widgets/rating_dialog.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../../core/utils/helpers.dart';
import '../../../../../widgets/buttons/custom_button.dart';

class OrderStatusTile extends StatelessWidget {
  final int orderId;
  final int challengerId;
  final int myId;
  final bool isDone;
  final String title;
  final String date;
  final bool isSeller;
  final bool isDuel;
  final bool isLast;
  final String lastStatus;
  const OrderStatusTile({Key? key, required this.orderId, required this.isDone, required this.title, required this.date, this.isSeller = false, this.isDuel = false, required this.isLast, required this.lastStatus, required this.challengerId, required this.myId}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double rating = 0.0;
    TextEditingController review = TextEditingController();

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/verified_user_bedge.svg',
              height: 18,
              width: 18,
              color: isDone ? null : iconWhiteColor,
            ),
            SizedBox(width: 3.w),
            Text(title,
                overflow: TextOverflow.ellipsis,
                style: textTheme.headline5?.copyWith(color: textWhiteColor)),
            Expanded(
              child: Text(date,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.headline5?.copyWith(
                      color: textLightColor)),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        isLast ? isSeller ? isDuel ?

        /// if Duel (Seller) ///
        lastStatus == 'ORDER_PLACED' ? _duelOrderPlaced(context) :
        lastStatus == 'SELLER_DELIVERY_CONFIRMED' ? _selectDuelWinner(context) :
        const SizedBox() :

        /// else normal seller ///
        _seller(context, textTheme) :

        /// if Duel (Buyer) ///
        isDuel ?
        lastStatus == 'SELLER_DELIVERY_CONFIRMED' ? _selectDuelWinner(context) :
        const SizedBox() :

        /// else normal Buyer ///
       _buyer(context, rating, review) :
        const SizedBox()
      ]
    );
  }

  Widget _duelOrderPlaced(BuildContext context){
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

  Widget _selectDuelWinner(BuildContext context){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomButton(
                color: orangeColor,
                name: "Challenger",
                textColor: textWhiteColor,
                left: 0.w,
                right: 0.w,
                radius: 50,
                onTap: () async {
                  selectDuelWinner(context, winnerId: challengerId);
                },
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: CustomButton(
                color: purpleLightIndigoColor,
                name: "You",
                textColor: textWhiteColor,
                radius: 50,
                onTap: () async {
                  selectDuelWinner(context, winnerId: myId);
                },
              ),
            ),
          ],
        ),
        CustomButton(
          color: purpleLightIndigoColor,
          name: "Upload Proofs",
          textColor: textWhiteColor,
          radius: 50,
          onTap: () async {
            _openFileExplorer(context);
          },
        )
      ],
    );
  }

  Widget _seller(BuildContext context, TextTheme textTheme){
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

        lastStatus == "ORDER_PLACED" ?  Padding(
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
                    style: textTheme.subtitle1?.copyWith(color: aquaGreenColor)),
                TextSpan(
                    text: 'before accpecting or declining the Order. Any conversation outside Loby Chat will not be insured/covered by Loby Protection',
                    style: textTheme.subtitle1?.copyWith(color: textLightColor)),
              ])),
        ) : const SizedBox(),
      ],
    );
  }

  Widget _buyer(BuildContext context, double rating, TextEditingController review){
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
                          onChanged: (star){
                            rating = star;
                          },
                          onSubmit: () async{
                            confirmDelivery(context, status: 'BUYER_DELIVERY_REJECTED', rating: rating, review: review.text);
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
                          onChanged: (star){
                            rating = star;
                          },
                          onSubmit: () async{
                            confirmDelivery(context, status: 'BUYER_DELIVERY_CONFIRMED', rating: rating, review: review.text);
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


  void selectDuelWinner(BuildContext context, {required int winnerId})async{
    OrderController orderController = Get.find<OrderController>();
    await Helpers.loader();
    await orderController.selectDuelWinner(winnerId:  winnerId, orderId: orderId);
    await orderController.getOrders();
    await Helpers.hideLoader();
    Navigator.pop(context);
  }


  void confirmDelivery(BuildContext context, {required String status, required double rating, String? review})async{
    OrderController orderController = Get.find<OrderController>();
    await Helpers.loader();
    await orderController.submitRating(orderId: orderId, stars: rating, review: review);
    await orderController.changeOrderStatus(orderId: orderId, status: status);
    await orderController.getOrders();
    await Helpers.hideLoader();
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void changeOrderStatus(BuildContext context, {required String status})async{
    OrderController orderController = Get.find<OrderController>();
    await Helpers.loader();
    await orderController.changeOrderStatus(orderId: orderId, status: status);
    await orderController.getOrders();
    await Helpers.hideLoader();
    Navigator.pop(context);
  }

  void _openFileExplorer(BuildContext context, {String? status}) async {
    OrderController orderController = Get.find<OrderController>();
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
      if(status != null) await orderController.changeOrderStatus(orderId: orderId, status: status);
      await orderController.getOrders();
      await Helpers.hideLoader();
      Navigator.pop(context);

    } on PlatformException catch (e) {
      Helpers.toast('Unsupported operation$e');
    } catch (e) {
      Helpers.toast('Something went wrong');
    }
  }
}
