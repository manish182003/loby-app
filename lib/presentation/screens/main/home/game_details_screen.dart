import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/utils/constants.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/listing/service_listing.dart';
import 'package:loby/presentation/getx/controllers/chat_controller.dart';
import 'package:loby/presentation/getx/controllers/home_controller.dart';
import 'package:loby/presentation/getx/controllers/listing_controller.dart';
import 'package:loby/presentation/getx/controllers/order_controller.dart';
import 'package:loby/presentation/screens/main/profile/wallet/widgets/token_widget.dart';
import 'package:loby/presentation/widgets/body_padding_widget.dart';
import 'package:loby/presentation/widgets/carousel.dart';
import 'package:loby/presentation/widgets/confirmation_dialog.dart';
import 'package:loby/presentation/widgets/custom_loader.dart';
import 'package:sizer/sizer.dart';
import 'package:text_helpers/text_helpers.dart';

import '../../../../core/theme/colors.dart';
import '../../../../domain/entities/listing/user_game_service_image.dart';
import '../../../../services/routing_service/routes_name.dart';
import '../../../getx/controllers/profile_controller.dart';
import '../../../widgets/bottom_dialog.dart';
import '../../../widgets/buttons/custom_button.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/profile_picture.dart';

class GameDetailScreen extends StatefulWidget {
  final int serviceListingId;
  final String? from;

  const GameDetailScreen(
      {super.key, required this.serviceListingId, this.from});

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  ListingController listingController = Get.find<ListingController>();
  HomeController homeController = Get.find<HomeController>();
  OrderController orderController = Get.find<OrderController>();
  ChatController chatController = Get.find<ChatController>();
  ProfileController profileController = Get.find<ProfileController>();

  // ServiceListing listing = ServiceListing();
  bool loading = true;

  List<String> mergedList = [];
  List<Widget> serviceOptionList = [];

  @override
  void dispose() {
    listingController.quantityCount.value = 1;
    listingController.totalPrice.value = "";
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      listingController.buyerListingPageNumber.value = 1;
      listingController.areMoreListingAvailable.value = true;
      await listingController.getBuyerListings(
          listingId: widget.serviceListingId);

      // final listing = listingController.buyerListings.where((element) => element.id == widget.serviceListingId).toList();
      // if(listing.isEmpty){
      //   final profileListing = listingController.buyerListingsProfile.where((listing) => listing.id == widget.serviceListingId).toList();
      //   if(profileListing.isEmpty){
      //     listingController.buyerListingPageNumber.value = 1;
      //     listingController.areMoreListingAvailable.value = true;
      //     await listingController.getBuyerListings(listingId: widget.serviceListingId);
      //   }else{
      //     listingController.buyerSingleListing.value = profileListing.first;
      //   }
      // }else{
      //   listingController.buyerSingleListing.value = listing.first;
      // }

      if (listingController.buyerSingleListing.value.userGameServiceOptions!
          .any((element) => element.serviceOptions!.isNotEmpty)) {
        serviceOptionList = List.from(listingController
            .buyerSingleListing.value.userGameServiceOptions!
            .map((e) {
          final sameServiceOption = listingController
              .buyerSingleListing.value.userGameServiceOptions!
              .where((element) =>
                  element.serviceOptions!.first.service!.name ==
                  e.serviceOptions!.first.service!.name)
              .toList();
          if (mergedList.contains(e.serviceOptions!.first.service!.name)) {
            return const SizedBox();
          } else {
            mergedList.add(e.serviceOptions!.first.service!.name!);
            return Padding(
              padding: EdgeInsets.only(bottom: 1.h),
              child: _rowWidget(
                text1: e.serviceOptions!.first.service!.previewName!,
                text2: sameServiceOption
                    .map((e) => e.serviceOptions!.first.serviceOptionName!)
                    .toList()
                    .join(", "),
              ),
            );
          }
        }).toList());
      }

      setState(() {
        loading = false;
      });
    });
  }

  Widget serviceOptions() {
    return serviceOptionList.isEmpty
        ? const SizedBox()
        : Column(
            children: serviceOptionList,
          );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        appBar: appBar(context: context, appBarName: ""),
        body: Obx(() {
          if (listingController.isBuyerListingsFetching.value || loading) {
            return const CustomLoader();
          } else {
            final listing = listingController.buyerSingleListing.value;
            List<UserGameServiceImage> userGameServiceImages = listing
                .userGameServiceImages!
                .where((element) => element.type != 3)
                .toList();

            return SingleChildScrollView(
              child: BodyPaddingWidget(
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // SizedBox(
                                //   width: 42,
                                //   height: 42,
                                //   child: MaterialButton(
                                //     shape: const CircleBorder(),
                                //     color: textCharcoalBlueColor,
                                //     onPressed: () {
                                //       Navigator.pop(context);
                                //     },
                                //     child: const Icon(
                                //       Icons.arrow_back_ios,
                                //       size: 18,
                                //       color: Colors.white,
                                //     ),
                                //   ),
                                // ),
                                // Text("${widget.gameName}", style: textTheme.headline2?.copyWith(color: aquaGreenColor),),
                                GestureDetector(
                                  onTap: () {
                                    context.pushNamed(searchScreenPage);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: textCharcoalBlueColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Icon(
                                      CupertinoIcons.search,
                                      size: 23,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                    userGameServiceImages.isEmpty
                        ? Carousel(
                            images: [CarouselList(type: 5, path: '')],
                          )
                        : Carousel(
                            images: [
                              for (final i in listing.userGameServiceImages!)
                                CarouselList(type: i.type!, path: i.path!)
                            ],
                          ),
                    userGameServiceImages.isEmpty
                        ? const SizedBox()
                        : SizedBox(
                            height: 2.h,
                          ),
                    Text(listing.title!,
                        style: textTheme.headlineSmall
                            ?.copyWith(color: textWhiteColor)),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _circularInfoBox(textTheme,
                              color: orangeColor, info: listing.game!.name!),
                          SizedBox(width: 1.w),
                          _circularInfoBox(textTheme,
                              color: purpleLightIndigoColor,
                              info: listing.category!.name!),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Card(
                      color: backgroundBalticSeaColor,
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              _rowWidget(
                                  text1:
                                      "Unit Token / Per ${listing.unit!.name}",
                                  text2: "${listing.price}",
                                  isNormal: true),
                              SizedBox(height: 1.h),
                              _rowWidget(
                                  text1: "Stock", text2: "${listing.stockAvl}"),
                              SizedBox(height: 1.h),
                              listing.user?.id == profileController.profile.id
                                  ? const SizedBox()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (listing.quantity > 1) {
                                              setState(() {
                                                listing.quantity--;
                                              });
                                              // listingController.totalPrice.value = (listing.price! * listingController.quantityCount.value).toString();
                                            }
                                          },
                                          child: SvgPicture.asset(
                                            'assets/icons/minus_circle_icon.svg',
                                            color: whiteColor,
                                            width: 5.h,
                                            height: 5.h,
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          constraints: const BoxConstraints(
                                              minHeight: 46, minWidth: 46),
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  spreadRadius: 1,
                                                  blurRadius: 5,
                                                  color: Colors.black
                                                      .withAlpha(50))
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(32),
                                            color: iconWhiteColor,
                                          ),
                                          child: Center(
                                            child: Text("${listing.quantity}",
                                                style: textTheme.displaySmall
                                                    ?.copyWith(
                                                        color: bodyTextColor)),
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        GestureDetector(
                                          onTap: () {
                                            if (listing.quantity <
                                                listing.stockAvl!) {
                                              setState(() {
                                                listing.quantity++;
                                              });
                                              // listingController.totalPrice.value = (listing.price! * listingController.quantityCount.value).toString();
                                            }
                                          },
                                          child: SvgPicture.asset(
                                            'assets/icons/plus_circle_icon.svg',
                                            color: whiteColor,
                                            width: 5.h,
                                            height: 5.h,
                                          ),
                                        ),
                                      ],
                                    ),
                              SizedBox(height: 1.h),
                              _rowWidget(
                                  text1: "Total Token",
                                  text2: (listing.quantity * listing.price!)
                                      .toString(),
                                  isNormal: true),
                              SizedBox(height: 1.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    listing.user?.id == profileController.profile.id
                        ? const SizedBox()
                        : widget.from == ListingPageRedirection.profile
                            ? const SizedBox()
                            : GestureDetector(
                                onTap: () {
                                  listingController.buyerListingsProfile
                                      .clear();
                                  context.pushNamed(userProfilePage, extra: {
                                    'userId': "${listing.user?.id}",
                                    'from': 'other'
                                  });
                                },
                                child: Card(
                                  color: backgroundBalticSeaColor,
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                    side: const BorderSide(
                                        color: textLightColor, width: 0.5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          ProfilePicture(
                                              profile: listing.user!),
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  18, 0, 0, 0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 36.w,
                                                        child: InlineText(
                                                          listing.user!
                                                              .displayName!,
                                                          // overflow: TextOverflow.ellipsis,
                                                          // maxLines: 1,
                                                          // softWrap: true,
                                                          style: textTheme
                                                              .displayMedium
                                                              ?.copyWith(
                                                                  color:
                                                                      profileNameYellowColor),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          width: 8.0),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 12.0,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          SvgPicture.asset(
                                                            'assets/icons/user_rating_icon.svg',
                                                            color:
                                                                iconWhiteColor,
                                                            height: 16.0,
                                                            width: 16.0,
                                                          ),
                                                          const SizedBox(
                                                              width: 4.0),
                                                          Text(
                                                            "${listing.user?.avgRatingCount ?? 0.0}",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: textTheme
                                                                .headlineMedium
                                                                ?.copyWith(
                                                                    color:
                                                                        textWhiteColor),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          width: 16.0),
                                                      Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                            'assets/icons/user_chat_icon.svg',
                                                            color:
                                                                iconWhiteColor,
                                                            height: 16.0,
                                                            width: 16.0,
                                                          ),
                                                          const SizedBox(
                                                              width: 8.0),
                                                          Text(
                                                            "${listing.user?.commentCount}",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: textTheme
                                                                .headlineMedium
                                                                ?.copyWith(
                                                                    color:
                                                                        textWhiteColor),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 4.0),
                                          GestureDetector(
                                            onTap: () {
                                              profileController.followUnfollow(
                                                  userId: listing.user?.id);
                                              setState(() {
                                                listing.user
                                                    ?.userFollowStatus = listing
                                                            .user
                                                            ?.userFollowStatus ==
                                                        'N'
                                                    ? 'Y'
                                                    : 'N';
                                              });
                                            },
                                            child: SvgPicture.asset(
                                              listing.user?.userFollowStatus ==
                                                      'N'
                                                  ? 'assets/icons/follow.svg'
                                                  : 'assets/icons/unfollow.svg',
                                              color: iconWhiteColor,
                                              width: 48,
                                              height: 48,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            _rowWidget(
                                text1: "listing ID",
                                text2: "#${listing.listingNumber}"),
                            SizedBox(height: 1.h),
                            _rowWidget(
                              text1: "Game",
                              text2: listing.game!.name!,
                            ),
                            SizedBox(height: 1.h),
                            _rowWidget(
                              text1: "Category",
                              text2: listing.category!.name!,
                            ),
                            SizedBox(height: 1.h),
                            serviceOptions(),
                            // _rowWidget(textTheme, text1: "Service Type", text2: listing.userGameServiceOptions!.map((e) => e.serviceOptions?.first.serviceOptionName).toList().join(", ")),
                            _rowWidget(
                              text1: "Game Platform",
                              text2: listing.game!.platform!,
                            ),
                            SizedBox(height: 1.h),
                            _rowWidget(
                                text1: "Link",
                                text2: getFileLink(listing),
                                isLink: true),
                            SizedBox(height: 3.h),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          textAlign: TextAlign.start,
                                          "Description: ",
                                          style: textTheme.headlineSmall
                                              ?.copyWith(color: textLightColor),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Text(
                                          textAlign: TextAlign.start,
                                          listing.description!,
                                          style: textTheme.titleLarge
                                              ?.copyWith(color: textWhiteColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                          ],
                        ),
                      ),
                    ),
                    listing.user?.id == profileController.profile.id
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(
                                top: 0.0, left: 7.0, bottom: 24.0, right: 7.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  height: 48,
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    color: purpleLightIndigoColor,
                                    onPressed: () async {
                                      Helpers.loader();
                                      final isSuccess =
                                          await chatController.checkEligibility(
                                              receiverId: listing.user!.id!);
                                      await chatController.getChats();
                                      final chat = chatController
                                          .checkEligibilityResponse.value;
                                      Helpers.hideLoader();
                                      if (isSuccess) {
                                        context.pushNamed(messagePage, extra: {
                                          'chatId': "${chat.id}",
                                          'senderId': "${chat.senderId}",
                                          'receiverId': "${chat.receiverId}"
                                        });
                                      } else {
                                        BottomDialog(
                                                textTheme: textTheme,
                                                tileName: "Buy a Service First",
                                                titleColor: aquaGreenColor,
                                                contentName:
                                                    "Sorry you can not chat with a verified profile without buying a service",
                                                contentLinkName: '')
                                            .showBottomDialog(context);
                                      }
                                    },
                                    child: SvgPicture.asset(
                                      'assets/icons/chat_icon.svg',
                                      color: iconWhiteColor,
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12.0),
                                Expanded(
                                  child: CustomButton(
                                    color: orangeColor,
                                    name: "Buy Now",
                                    textColor: textWhiteColor,
                                    onTap: () async {
                                      ConfirmationBottomDialog(
                                          textTheme: textTheme,
                                          contentName:
                                              "Are you sure you want to Buy this Service ?",
                                          yesBtnClick: () async {
                                            Helpers.loader();
                                            final response =
                                                await orderController
                                                    .createOrder(
                                              isUpdatingTime: false,
                                              listingId: listing.id!,
                                              quantity: listing.quantity,
                                              price: (listing.quantity *
                                                      listing.price!)
                                                  .toString(),
                                            );
                                            Helpers.hideLoader();
                                            if (response['success']) {
                                              listing.stockAvl =
                                                  (listing.stockAvl! -
                                                      listing.quantity);
                                              print(profileController
                                                  .profile.walletMoney);
                                              profileController
                                                      .profile.walletMoney =
                                                  (profileController.profile
                                                          .walletMoney! -
                                                      (listing.quantity *
                                                          listing.price!));
                                              print(profileController
                                                  .profile.walletMoney);
                                              Navigator.pop(context);
                                              BottomDialog(
                                                  textTheme: textTheme,
                                                  tileName: "Congratulations",
                                                  titleColor: aquaGreenColor,
                                                  contentName:
                                                      "Payment Successful. You can check your order status from ",
                                                  contentLinkName: 'My Orders',
                                                  onOk: () {
                                                    homeController
                                                        .getUnreadCount(
                                                            type: 'chat');
                                                    homeController
                                                        .getUnreadCount(
                                                            type:
                                                                'notification');
                                                    Navigator.pop(context);
                                                    context
                                                        .pushNamed(myOrderPage);
                                                  }).showBottomDialog(context);
                                            } else if (response['reason'] ==
                                                'insufficient balance') {
                                              Navigator.pop(context);
                                              ConfirmationBottomDialog(
                                                  textTheme: Theme.of(context)
                                                      .textTheme,
                                                  contentName:
                                                      "You have insifficient tokens to buy this service. Would you like to Add Tokens to your Wallet ?",
                                                  yesBtnClick: () async {
                                                    Navigator.pop(context);
                                                    context.pushNamed(
                                                        addFundScreenPage);
                                                  }).showBottomDialog(context);
                                            } else {
                                              Helpers.hideLoader();
                                            }
                                          }).showBottomDialog(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
            );
          }
        }),
      ),
    );
  }

  String getFileLink(ServiceListing listing) {
    final link =
        listing.userGameServiceImages!.where((element) => element.type == 3);
    if (link.isNotEmpty) {
      return link.first.path!;
    } else {
      return '';
    }
  }

  Widget _circularInfoBox(
    TextTheme textTheme, {
    Color? color,
    String? info,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Text(info!,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: textTheme.headlineSmall?.copyWith(color: textWhiteColor)),
      ),
    );
  }

  Widget _rowWidget(
      {required String text1,
      required String text2,
      bool isNormal = false,
      bool isLink = false}) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: textTheme.headlineSmall?.copyWith(color: textLightColor),
        ),
        SizedBox(
          width: 10.w,
        ),
        isNormal
            ? TokenWidget(
                size: 25,
                text: Text(text2,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.displayLarge
                        ?.copyWith(color: aquaGreenColor)))
            : Flexible(
                child: GestureDetector(
                  onTap: () {
                    if (isLink) {
                      Helpers.launch(text2);
                    }
                  },
                  child: Text(
                    text2,
                    maxLines: 3,
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.headlineSmall?.copyWith(color: whiteColor),
                  ),
                ),
              ),
      ],
    );
  }
}
