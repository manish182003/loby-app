import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:loby/data/models/order/order_model.dart';
import 'package:loby/domain/entities/order/order.dart';
import 'package:loby/presentation/getx/controllers/core_controller.dart';
import 'package:loby/presentation/getx/controllers/order_controller.dart';
import 'package:loby/presentation/screens/main/profile/my_order/widgets/select_duel_winner_dialog.dart';
import 'package:loby/presentation/widgets/rating_dialog.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../../core/utils/helpers.dart';
import '../../../../../../services/routing_service/routes_name.dart';
import '../../../../../widgets/buttons/custom_button.dart';
import '../../../../../widgets/confirmation_dialog.dart';
import 'order_status_constants.dart';

class OrderStatusTile extends StatelessWidget {
  final Order order;
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

  OrderStatusTile({
    super.key,
    required this.orderId,
    required this.isDone,
    required this.title,
    required this.date,
    this.isSeller = false,
    this.isDuel = false,
    required this.isLast,
    this.isDisputeRaised = false,
    required this.lastStatus,
    required this.sellerId,
    required this.buyerId,
    required this.order,
  });
  final OrderController orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double rating = 0.0;
    TextEditingController review = TextEditingController();
    print('rating->${orderController.ratingDone.value}');
    print(lastStatus);

    return Column(children: [
      _statusTile(textTheme, isDone: isDone, title: title, date: date),
      SizedBox(height: 2.h),

      /// if Dispute is Raised ///
      isLast
          ? isDisputeRaised
              ? Column(
                  children: [
                    _statusTile(
                      textTheme,
                      isDone: true,
                      title: isDuel
                          ? "Seller & Challenger selection doesn’t match. Dispute Raised. Transaction on hold"
                          : "Dispute Raised. Transaction on hold",
                      date: date,
                      isDisputedRaised: true,
                    ),
                    SizedBox(height: 2.h),
                  ],
                )
              : isSeller
                  ? isDuel
                      ?

                      /// if Duel (Seller) ///
                      lastStatus == 'ORDER_PLACED'
                          ? _duelOrderPlaced(context)
                          : lastStatus == 'ORDER_IN_PROGRESS'
                              ? _selectDuelWinner(context)
                              : lastStatus == 'BUYER_DELIVERY_CONFIRMED'
                                  ? _selectDuelWinner(context)
                                  : lastStatus == "LOBY_PROTECTION_PERIOD" &&
                                          orderController.ratingDone.value ==
                                              false
                                      ? Padding(
                                          padding: EdgeInsets.only(bottom: 2.h),
                                          child: CustomButton(
                                            color: purpleLightIndigoColor,
                                            name: order.ratingReviews == null
                                                ? "Review & Rating"
                                                : "Review & Rating Submitted",
                                            textColor: textWhiteColor,
                                            radius: 50,
                                            onTap: order.ratingReviews == null
                                                ? () async {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return RatingDialog(
                                                            title:
                                                                "Review & Rating",
                                                            descriptions:
                                                                "Congratulations on successfully delivering a service. Kindly rate the buyer to help us serve you better",
                                                            text: "OK",
                                                            review: review,
                                                            onChanged: (star) {
                                                              rating = star;
                                                            },
                                                            onSubmit: () async {
                                                              confirmSellerDelivery(
                                                                  context,
                                                                  status: '',
                                                                  rating:
                                                                      rating,
                                                                  review: review
                                                                      .text);
                                                            },
                                                          );
                                                        });
                                                  }
                                                : () {},
                                          ),
                                        )
                                      : const SizedBox()
                      :

                      /// else normal seller ///
                      _seller(context, textTheme, rating, review)
                  :

                  /// if Duel (Buyer) ///
                  isDuel
                      ? lastStatus == 'ORDER_IN_PROGRESS'
                          ? _selectDuelWinner(context)
                          : lastStatus == 'SELLER_DELIVERY_CONFIRMED'
                              ? _selectDuelWinner(context)
                              : lastStatus == "LOBY_PROTECTION_PERIOD" &&
                                      orderController.ratingDone.value == false
                                  ? Padding(
                                      padding: EdgeInsets.only(bottom: 2.h),
                                      child: CustomButton(
                                        color: purpleLightIndigoColor,
                                        name: order.ratingReviews == null
                                            ? "Review & Rating"
                                            : "Review & Rating Submitted",
                                        textColor: textWhiteColor,
                                        radius: 50,
                                        onTap: order.ratingReviews == null
                                            ? () async {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return RatingDialog(
                                                        title:
                                                            "Review & Rating",
                                                        descriptions:
                                                            "Congratulations on successfully getting your service delivered. Kindly rate the seller & the service to help us serve you better",
                                                        text: "OK",
                                                        review: review,
                                                        onChanged: (star) {
                                                          rating = star;
                                                        },
                                                        onSubmit: () async {
                                                          confirmSellerDelivery(
                                                              context,
                                                              status: '',
                                                              rating: rating,
                                                              review:
                                                                  review.text);
                                                        },
                                                      );
                                                    });
                                              }
                                            : () {},
                                      ),
                                    )
                                  : const SizedBox()
                      :

                      /// else normal Buyer ///
                      _buyer(context, rating, review)
          : const SizedBox()
    ]);
  }

  Widget _statusTile(TextTheme textTheme,
      {required bool isDone,
      required String title,
      required String date,
      bool isDisputedRaised = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Row(
            children: [
              SvgPicture.asset(
                isDisputedRaised
                    ? 'assets/icons/cross.svg'
                    : title == statusesName[sellerRejected]
                        ? 'assets/icons/cross.svg'
                        : 'assets/icons/verified_user_bedge.svg',
                height: 18,
                width: 18,
                color: isDone ? null : iconWhiteColor,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(title,
                    // maxLines: 3,
                    // overflow: TextOverflow.ellipsis,
                    style: textTheme.headlineSmall?.copyWith(
                        color: isDisputedRaised
                            ? carminePinkColor
                            : title == statusesName[sellerRejected]
                                ? carminePinkColor
                                : textWhiteColor)),
              ),
            ],
          ),
        ),
        Text(date,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: textTheme.headlineSmall?.copyWith(color: textLightColor)),
      ],
    );
  }

  Widget _duelOrderPlaced(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
        Padding(
          padding: EdgeInsets.only(bottom: 2.h),
          child: RichText(
            text: TextSpan(
              style: textTheme.titleMedium!.copyWith(color: textLightColor),
              children: [
                const TextSpan(
                    text:
                        '1. Sellers are requsted to discuss & freeze all terms & conditions with the opponent on ',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    )),
                TextSpan(
                  text: 'Loby Chat',
                  style: textTheme.titleMedium!.copyWith(
                    color: aquaGreenColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const TextSpan(
                    text:
                        ' before accpecting or declining the Duel.\n2. Amount of ',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    )),
                TextSpan(
                  text: NumberFormat.currency(locale: 'en_IN', symbol: 'Rs. ')
                      .format(order.price),
                  style: textTheme.titleMedium!.copyWith(
                    color: aquaGreenColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const TextSpan(
                    text:
                        ' will be kept on hold if you accept the Duel. \n3. Any conversation outside ',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    )),
                TextSpan(
                  text: 'Loby Chat',
                  style: textTheme.titleMedium!.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const TextSpan(
                  text: ' will not be insured/covered by Loby Protection.',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _selectDuelWinner(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
        _statusTile(
          textTheme,
          isDone: false,
          title: "Select Winner",
          date: "",
        ),
        SizedBox(height: 2.h),
        CustomButton(
          color: purpleLightIndigoColor,
          name: "Select Winner",
          textColor: textWhiteColor,
          radius: 50,
          onTap: () async {
            _selectDuelWinnerDialog(context);
          },
        ),
        SizedBox(height: 2.h),
      ],
    );
  }

  Widget _seller(BuildContext context, TextTheme textTheme, double rating,
      TextEditingController review) {
    return Column(
      children: [
        lastStatus == 'ORDER_PLACED'
            ? Padding(
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
                        //   onTap: () async {
                        //   showDialog(
                        //       context: context,
                        //       builder: (BuildContext context) {
                        //         return RatingDialog(
                        //           title: "Review & Rating",
                        //           descriptions: "Congratulations on successfully getting your service delivered. Kindly rate thus seller & its service to help us serve you better",
                        //           text: "OK",
                        //           review: review,
                        //           onChanged: (star) {
                        //             rating = star;
                        //           },
                        //           onSubmit: () async {
                        //             confirmSellerDelivery(
                        //                 context, status: 'SELLER_ACCEPTED',
                        //                 rating: rating,
                        //                 review: review.text);
                        //           },
                        //         );
                        //       });
                        // },
                        onTap: () async {
                          changeOrderStatus(context, status: 'SELLER_ACCEPTED');
                        },
                      ),
                    ),
                  ],
                ),
              )
            : lastStatus == "ORDER_IN_PROGRESS"
                ? Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                    child: CustomButton(
                      color: purpleLightIndigoColor,
                      name: "Upload Proofs & Confirm Delivery",
                      textColor: textWhiteColor,
                      radius: 50,
                      onTap: () async {
                        _uploadProofsDialog(context);
                      },
                    ),
                  )
                : const SizedBox(),
        lastStatus == "ORDER_PLACED"
            ? Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(children: [
                      TextSpan(
                        text:
                            'Sellers are requsted to discuss & freeze all delivery details with buyer on ',
                        style: textTheme.titleMedium
                            ?.copyWith(color: textLightColor),
                      ),
                      TextSpan(
                          text: 'Loby Chat ',
                          style: textTheme.titleMedium
                              ?.copyWith(color: aquaGreenColor)),
                      TextSpan(
                          text:
                              'before accpecting or declining the Order. Any conversation outside Loby Chat will not be insured/covered by Loby Protection',
                          style: textTheme.titleMedium
                              ?.copyWith(color: textLightColor)),
                    ])),
              )
            : lastStatus == "LOBY_PROTECTION_PERIOD" &&
                    orderController.ratingDone.value == false
                ? Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                    child: CustomButton(
                      color: purpleLightIndigoColor,
                      name: order.ratingReviews == null
                          ? "Review & Rating"
                          : "Review & Rating Submitted",
                      textColor: textWhiteColor,
                      radius: 50,
                      onTap: order.ratingReviews == null
                          ? () async {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return RatingDialog(
                                      title: "Review & Rating",
                                      descriptions:
                                          "Congratulations on successfully delivering a service. Kindly rate the buyer to help us serve you better",
                                      text: "OK",
                                      review: review,
                                      onChanged: (star) {
                                        rating = star;
                                      },
                                      onSubmit: () async {
                                        confirmSellerDelivery(context,
                                            status: '',
                                            rating: rating,
                                            review: review.text);
                                      },
                                    );
                                  });
                            }
                          : () {},
                    ),
                  )
                : const SizedBox(),
      ],
    );
  }

  Widget _buyer(
      BuildContext context, double rating, TextEditingController review) {
    logger.i('buyer status->$lastStatus');
    return lastStatus == "SELLER_DELIVERY_CONFIRMED"
        ? Column(
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
                        changeOrderStatus(context,
                            status: 'BUYER_DELIVERY_REJECTED');

                        // showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return RatingDialog(
                        //         title: "Review & Rating",
                        //         descriptions: "Congratulations on successfully getting your service delivered. Kindly rate thus seller & its service to help us serve you better",
                        //         text: "OK",
                        //         review: review,
                        //         onChanged: (star) {
                        //           rating = star;
                        //         },
                        //         onSubmit: () async {
                        //           confirmDelivery(
                        //               context, status: 'BUYER_DELIVERY_REJECTED',
                        //               rating: rating,
                        //               review: review.text);
                        //         },
                        //       );
                        //     });
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
                                descriptions:
                                    "Congratulations on successfully getting your service delivered. Kindly rate the seller & the service to help us serve you better",
                                text: "OK",
                                review: review,
                                onChanged: (star) {
                                  rating = star;
                                },
                                onSubmit: () async {
                                  confirmBuyerDelivery(context,
                                      status: 'BUYER_DELIVERY_CONFIRMED',
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
          )
        : lastStatus == "LOBY_PROTECTION_PERIOD" &&
                orderController.ratingDone.value == false
            ? Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: CustomButton(
                  color: purpleLightIndigoColor,
                  name: order.ratingReviews == null
                      ? "Review & Rating"
                      : "Review & Rating Submitted",
                  textColor: textWhiteColor,
                  radius: 50,
                  onTap: order.ratingReviews == null
                      ? () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return RatingDialog(
                                  title: "Review & Rating",
                                  descriptions:
                                      "Congratulations on successfully delivering a service. Kindly rate the buyer to help us serve you better",
                                  text: "OK",
                                  review: review,
                                  onChanged: (star) {
                                    rating = star;
                                  },
                                  onSubmit: () async {
                                    confirmSellerDelivery(context,
                                        status: '',
                                        rating: rating,
                                        review: review.text);
                                  },
                                );
                              });
                        }
                      : () {},
                ),
              )
            : const SizedBox();
  }

  void selectDuelWinner(BuildContext context,
      {required int winnerId, required String status}) async {
    OrderController orderController = Get.find<OrderController>();
    CoreController coreController = Get.find<CoreController>();
    await Helpers.loader();
    final isSuccess = await orderController.selectDuelWinner(
        winnerId: winnerId, orderId: orderId);
    if (isSuccess) {
      await orderController.uploadDeliveryProof(
        orderId: orderId,
        fileTypes: orderController.selectedDuelProofs
            .map((element) => element.fileType)
            .toList(),
        files: orderController.selectedDuelProofs
            .map((element) => element.file)
            .toList(),
      );
      await orderController.changeOrderStatus(orderId: orderId, status: status);
      await getOrders();
      orderController.selectedUser.value = "";
      orderController.duelWinner.value = "";
      orderController.selectedDuelProofs.clear();

      coreController.socket.emit("loby", {
        'type': 'order',
        'receiverId': isSeller ? buyerId : sellerId,
        'order': (orderController.orders
                .where((e) => e.id == orderId)
                .toList()
                .first as OrderModel)
            .toJson(),
      });
      await Helpers.hideLoader();
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      await Helpers.hideLoader();
    }
  }

  void confirmSellerDelivery(BuildContext context,
      {required String status,
      bool? ratingDone,
      required double rating,
      String? review}) async {
    OrderController orderController = Get.find<OrderController>();
    CoreController coreController = Get.find<CoreController>();
    await Helpers.loader();
    final isSuccess = await orderController.submitRating(
        orderId: orderId, stars: rating, review: review);
    if (isSuccess) {
      // await orderController.changeOrderStatus(orderId: orderId, status: status);
      await getOrders();

      coreController.socket.emit("loby", {
        'type': 'order',
        'receiverId': buyerId,
        'order': (orderController.orders
                .where((e) => e.id == orderId)
                .toList()
                .first as OrderModel)
            .toJson(),
      });
      ratingDone = true;
      await Helpers.hideLoader();
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      await Helpers.hideLoader();
    }
  }

  void confirmBuyerDelivery(BuildContext context,
      {required String status, required double rating, String? review}) async {
    OrderController orderController = Get.find<OrderController>();
    CoreController coreController = Get.find<CoreController>();
    await Helpers.loader();
    final isSuccess = await orderController.submitRating(
        orderId: orderId, stars: rating, review: review);
    if (isSuccess) {
      await orderController.changeOrderStatus(orderId: orderId, status: status);
      await getOrders();

      coreController.socket.emit("loby", {
        'type': 'order',
        'receiverId': sellerId,
        'order': (orderController.orders
                .where((e) => e.id == orderId)
                .toList()
                .first as OrderModel)
            .toJson(),
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
    final response = await orderController.changeOrderStatus(
        orderId: orderId, status: status);
    if (response['success']) {
      await getOrders();
      coreController.socket.emit("loby", {
        'type': 'order',
        'receiverId': isSeller ? buyerId : sellerId,
        'order': (orderController.orders
                .where((e) => e.id == orderId)
                .toList()
                .first as OrderModel)
            .toJson(),
      });
      await Helpers.hideLoader();
      Navigator.pop(context);
    } else if (response['reason'] == 'insufficient balance') {
      Helpers.hideLoader();
      ConfirmationBottomDialog(
          textTheme: Theme.of(context).textTheme,
          contentName:
              "You have insifficient tokens to buy this service. Would you like to Add Tokens to your Wallet ?",
          yesBtnClick: () async {
            Navigator.pop(context);
            context.pushNamed(addFundScreenPage);
          }).showBottomDialog(context);
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
      ))!
          .files;

      await Helpers.loader();
      await orderController.uploadDeliveryProof(
        orderId: orderId,
        fileTypes: paths.map((e) => Helpers.getFileType(e.extension!)).toList(),
        files: paths.map((e) => File(e.path!)).toList(),
      );
      if (status != null) {
        await orderController.changeOrderStatus(
            orderId: orderId, status: status);
      }
      await getOrders();
      coreController.socket.emit("loby", {
        'type': 'order',
        'receiverId': buyerId,
        'order': (orderController.orders
                .where((e) => e.id == orderId)
                .toList()
                .first as OrderModel)
            .toJson(),
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
    final duelUsers = [
      isSeller
          ? order.user?.displayName ?? ''
          : order.userGameService?.user?.displayName ?? '',
      // isSeller
      //     ? order.userGameService?.user?.displayName ?? ''
      //     : order.userGameService?.user?.displayName ?? '',
      'You'
    ];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            elevation: 0,
            backgroundColor: backgroundDarkJungleGreenColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            child: SelectDuelWinnerDialog(
              options: duelUsers,
              onSelectWinner: (value) {
                if (value.toString() == duelUsers[0]) {
                  if (isSeller) {
                    orderController.duelWinner.value =
                        "$buyerId/SELLER_DELIVERY_CONFIRMED";
                  } else {
                    orderController.duelWinner.value =
                        "$sellerId/BUYER_DELIVERY_CONFIRMED";
                  }
                } else {
                  if (isSeller) {
                    orderController.duelWinner.value =
                        "$sellerId/SELLER_DELIVERY_CONFIRMED";
                  } else {
                    orderController.duelWinner.value =
                        "$buyerId/BUYER_DELIVERY_CONFIRMED";
                  }
                }
                orderController.selectedUser.value = value.toString();
                debugPrint(orderController.duelWinner.value);
              },
              onSubmit: () {
                if (orderController.duelWinner.isEmpty) {
                  Helpers.toast("Please Select Winner");
                } else if (orderController.selectedDuelProofs.isEmpty) {
                  Helpers.toast("Please Upload Proofs");
                } else {
                  selectDuelWinner(context,
                      winnerId: int.tryParse(
                          orderController.duelWinner.value.split("/")[0])!,
                      status: orderController.duelWinner.value.split("/")[1]);
                }
              },
            ));
      },
    );
  }

  void _uploadProofsDialog(BuildContext context) {
    OrderController orderController = Get.find<OrderController>();
    CoreController coreController = Get.find<CoreController>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            elevation: 0,
            backgroundColor: backgroundDarkJungleGreenColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            child: SelectDuelWinnerDialog(
              isNormalOrder: true,
              onSubmit: () async {
                if (orderController.selectedDuelProofs.isEmpty) {
                  Helpers.toast("Please Upload Proofs");
                } else {
                  await Helpers.loader();
                  final isSuccess = await orderController.uploadDeliveryProof(
                    orderId: orderId,
                    fileTypes: orderController.selectedDuelProofs
                        .map((element) => element.fileType)
                        .toList(),
                    files: orderController.selectedDuelProofs
                        .map((element) => element.file)
                        .toList(),
                  );
                  if (isSuccess) {
                    await orderController.changeOrderStatus(
                        orderId: orderId, status: sellerDeliveryConfirmed);
                    await getOrders();
                    coreController.socket.emit("loby", {
                      'type': 'order',
                      'receiverId': buyerId,
                      'order': (orderController.orders
                              .where((e) => e.id == orderId)
                              .toList()
                              .first as OrderModel)
                          .toJson(),
                    });
                    await Helpers.hideLoader();
                    Navigator.pop(context);
                  } else {
                    Helpers.hideLoader();
                  }
                }
              },
            ));
      },
    );
  }
}
