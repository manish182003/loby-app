import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/presentation/getx/controllers/home_controller.dart';
import 'package:loby/presentation/getx/controllers/listing_controller.dart';
import 'package:loby/presentation/getx/controllers/order_controller.dart';
import 'package:loby/presentation/widgets/body_padding_widget.dart';
import 'package:loby/presentation/widgets/carousel.dart';
import 'package:loby/presentation/widgets/custom_loader.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/colors.dart';
import '../../../../services/routing_service/routes_name.dart';
import '../../../widgets/bottom_dialog_widget.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/buttons/custom_button.dart';

class GameDetailScreen extends StatefulWidget {
  final int serviceListingId;

  const GameDetailScreen({Key? key, required this.serviceListingId})
      : super(key: key);

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {

  ListingController listingController = Get.find<ListingController>();
  HomeController homeController = Get.find<HomeController>();
  OrderController orderController = Get.find<OrderController>();

  List<String> images = [
    'assets/images/img.png',
    'assets/images/img.png',
    'assets/images/img.png'
  ];

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
    listingController.getBuyerListings();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;



    return Scaffold(

      appBar: appBar(context: context, appBarName: ""),
      body: Obx(() {
        if(listingController.isBuyerListingsFetching.value){
          return const CustomLoader();
        }else{
          final listing = listingController.buyerListings
              .where((listing) => listing.id == widget.serviceListingId)
              .toList()
              .first;
          return SingleChildScrollView(
            child: BodyPaddingWidget(
              child: Column(
                children: [
                  listing.userGameServiceImages!.isEmpty
                      ? const SizedBox()
                      : Carousel(
                    images: listing.userGameServiceImages!,
                  ),
                  listing.userGameServiceImages!.isEmpty
                      ? const SizedBox()
                      : SizedBox(height: 2.h,),
                  Text(listing.description!,
                      style: textTheme.headline5?.copyWith(
                          color: textWhiteColor)),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _circularInfoBox(textTheme, color: orangeColor,
                          info: listing.game!.name!),
                      SizedBox(width: 1.w),
                      _circularInfoBox(textTheme, color: purpleLightIndigoColor,
                          info: listing.category!.name!),
                    ],
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
                            _rowWidget(textTheme,
                                text1: "Unit Price / Per ${listing.unit!.name}",
                                text2: "${listing.price}",
                                isNormal: true),
                            SizedBox(height: 1.h),
                            _rowWidget(textTheme, text1: "Stock",
                                text2: "${listing.stockAvl}"),
                            SizedBox(height: 1.h),
                            Obx(() {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (listingController.quantityCount
                                          .value > 1) {
                                        listingController.quantityCount.value--;
                                        listingController.totalPrice.value =
                                            (listing.price! *
                                                listingController.quantityCount
                                                    .value).toString();
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
                                            color: Colors.black.withAlpha(50))
                                      ],
                                      borderRadius: BorderRadius.circular(32),
                                      color: iconWhiteColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                          "${listingController.quantityCount
                                              .value}",
                                          style: textTheme.headline3?.copyWith(
                                              color: bodyTextColor)),
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  GestureDetector(
                                    onTap: () {
                                      if (listingController.quantityCount
                                          .value <
                                          listing.stockAvl!) {
                                        listingController.quantityCount.value++;
                                        listingController.totalPrice.value =
                                            (listing.price! *
                                                listingController.quantityCount
                                                    .value).toString();
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
                              );
                            }),
                            SizedBox(height: 1.h),
                            Obx(() {
                              return _rowWidget(textTheme, text1: "Total Price",
                                  text2: listingController.totalPrice.value,
                                  isNormal: true);
                            }),
                            SizedBox(height: 1.h),
                            _rowWidget(textTheme, text1: "Earn Loby Coins",
                                text2: "${listing.category?.lobyCoinsPercent}"),
                            SizedBox(height: 1.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h,),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(userProfilePage, queryParams: {
                        'userId': "${listing.user?.id}",
                        'from': 'other'
                      });
                    },
                    child: Card(
                      color: backgroundBalticSeaColor,
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: const BorderSide(
                            color: textLightColor, width: 0.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: aquaGreenColor,
                                radius: 36,
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(36),
                                    child: CachedNetworkImage(
                                      imageUrl: listing.user?.image ?? "",
                                      fit: BoxFit.cover,
                                      height: 110,
                                      width: 110,
                                      placeholder: (context,
                                          url) => const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,)),
                                      errorWidget: (context, url,
                                          error) => const Icon(Icons.error),
                                    ),
                                  ),
                                ), //CircleAvatar
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            listing.user!.name!,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: textTheme.headline3
                                                ?.copyWith(color: textWhiteColor),
                                          ),
                                          const SizedBox(width: 8.0),
                                          listing.user!.verifiedProfile ?? false ? SvgPicture.asset(
                                            'assets/icons/verified_user_bedge.svg',
                                            height: 15,
                                            width: 15,
                                          ) : const SizedBox(),
                                        ],
                                      ),
                                      const SizedBox(height: 8.0,),
                                      Row(
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/icons/user_rating_icon.svg',
                                                color: iconWhiteColor,
                                                height: 13.0,
                                                width: 13.0,
                                              ),
                                              const SizedBox(width: 4.0),
                                              Text(
                                                "${listing.user
                                                    ?.avgRatingCount ?? 0.0}",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: textTheme.headline5
                                                    ?.copyWith(
                                                    color: textWhiteColor),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 16.0),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/icons/user_chat_icon.svg',
                                                color: iconWhiteColor,
                                                height: 13.0,
                                                width: 13.0,
                                              ),
                                              const SizedBox(width: 4.0),
                                              Text(
                                                "${listing.user?.commentCount}",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: textTheme.headline5
                                                    ?.copyWith(
                                                    color: textWhiteColor),
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
                              listing.user?.userFollowStatus == null
                                  ? const SizedBox()
                                  : Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                color: shipGreyColor,
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: shipGreyColor,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SvgPicture.asset(
                                      'assets/icons/a_check_icon.svg',
                                      color: iconWhiteColor,
                                      width: 12,
                                      height: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          _rowWidget(textTheme, text1: "Listing ID",
                              text2: "#${listing.id}"),
                          SizedBox(height: 1.h),
                          _rowWidget(textTheme, text1: "Game",
                            text2: listing.game!.name!,),
                          SizedBox(height: 1.h),
                          _rowWidget(textTheme, text1: "Category",
                            text2: listing.category!.name!,),
                          SizedBox(height: 1.h),
                          _rowWidget(textTheme, text1: "Service Type", text2: listing.userGameServiceOptions!.map((e) => e.serviceOptions?.first.serviceOptionName).toList().join(", ")),
                          SizedBox(height: 1.h),
                          _rowWidget(textTheme, text1: "Game Platform",
                            text2: listing.game!.platform!,),
                          SizedBox(height: 3.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        textAlign: TextAlign.start,
                                        "Description: ",
                                        style: textTheme.headline5?.copyWith(
                                            color: textLightColor),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text(
                                        textAlign: TextAlign.start,
                                        listing.description!,
                                        style: textTheme.headline6
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
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, left: 7.0, bottom: 24.0, right: 7.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.15,
                          height: 48,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            color: purpleLightIndigoColor,
                            onPressed: () {
                              debugPrint("Click Search");
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
                              final isSuccess = await orderController.createOrder(
                                  listingId: listing.id!,
                                  quantity: listingController.quantityCount.value,
                                  price: listingController.totalPrice.value
                              );
                              if (isSuccess) {
                                BottomDialog(
                                    textTheme: textTheme,
                                    tileName: "Congratulations",
                                    titleColor: aquaGreenColor,
                                    contentName: "Payment Successful. You can check your order status from ",
                                    contentLinkName: 'My Orders',
                                  onOk: (){
                                    homeController.getUnreadCount(type: 'chat');
                                    homeController.getUnreadCount(type: 'notification');
                                    Navigator.pop(context);
                                    context.pushNamed(myOrderPage);

                                  }
                                )
                                    .showBottomDialog(context);
                              }
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
    );
  }


  Widget _circularInfoBox(TextTheme textTheme, {Color? color, String? info,}) {
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
            style: textTheme.headline5?.copyWith(color: textWhiteColor)),
      ),
    );
  }

  Widget _rowWidget(TextTheme textTheme,
      {required String text1, required String text2, bool isNormal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: textTheme.headline5
              ?.copyWith(color: textLightColor),
        ),
        SizedBox(width: 10.w,),
        Flexible(
          child: Text(
              text2,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: isNormal ? textTheme.headline1?.copyWith(
                  color: aquaGreenColor) : textTheme.headline5?.copyWith(
                  color: whiteColor)
          ),
        ),
      ],
    );
  }
}
