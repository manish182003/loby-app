// ignore_for_file: file_names

import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/listing/service_listing.dart';
import 'package:loby/presentation/getx/controllers/listing_controller.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/screens/main/profile/wallet/widgets/token_widget.dart';
import 'package:loby/presentation/widgets/ConfirmationRiseDisputeBottomDialog.dart';
import 'package:loby/presentation/widgets/custom_cached_network_image.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:sizer/sizer.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../widgets/profile_picture.dart';

class ItemList extends StatefulWidget {
  final String from;
  final bool menuIcon;
  final ServiceListing listing;

  const ItemList(
      {super.key,
      required this.from,
      this.menuIcon = false,
      required this.listing});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  ListingController listingController = Get.find<ListingController>();
  ProfileController profileController = Get.find<ProfileController>();
  TextEditingController reportController = TextEditingController();
  final CustomPopupMenuController _controller = CustomPopupMenuController();
  Rx<String?> videoImage = ''.obs;

  @override
  void initState() {
    var image = Helpers.getListingImage(widget.listing);
    if (image != null && image.contains('mp4')) {
      getVideoThumbnail(image);
    }
    super.initState();
  }

  getVideoThumbnail(String path) async {
    print('path->$path');
    videoImage.value = await VideoThumbnail.thumbnailFile(
      video: path,
      imageFormat: ImageFormat.PNG,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        listingController.totalPrice.value =
            (listingController.quantityCount.value * widget.listing.price!)
                .toString();
        context.pushNamed(gameDetailPage, extra: {
          'serviceListingId': "${widget.listing.id}",
          'from': widget.from
        });
      },
      child: Card(
        color: backgroundBalticSeaColor,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18.0 / 12.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: aquaGreenColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Obx(
                      () => CustomCachedNetworkImage(
                        imageUrl: videoImage.value == null ||
                                videoImage.value!.isEmpty
                            ? Helpers.getListingImage(widget.listing)
                            : videoImage.value,
                        placeHolder: Image.asset(
                          "assets/images/listing_placeholder.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.listing.title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: textTheme.headlineSmall
                          ?.copyWith(color: textWhiteColor)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(widget.listing.game?.name! ?? '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: textTheme.titleLarge
                            ?.copyWith(color: textInputTitleColor)),
                  ),
                  const SizedBox(height: 2.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 13.w,
                        child: Container(
                          decoration: BoxDecoration(
                            color: orangeColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 6.0),
                            child: Text(widget.listing.category?.name! ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.titleLarge
                                    ?.copyWith(color: textWhiteColor)),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 4.0),
                        child: Column(
                          children: <Widget>[
                            TokenWidget(
                              text: Text(
                                "${widget.listing.price!}",
                                style: textTheme.displayMedium
                                    ?.copyWith(color: aquaGreenColor),
                              ),
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  const Divider(
                    color: dividerColor,
                    height: 4,
                    thickness: 2,
                    endIndent: 0,
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProfilePicture(
                        profile: widget.listing.user!,
                        radius: 15,
                        iconSize: 14,
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 20.w,
                                  child: Text(
                                    widget.listing.user!.displayName!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: textTheme.headlineMedium?.copyWith(
                                        fontSize: 11.0, color: textWhiteColor),
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/user_rating_icon.svg',
                                      color: iconWhiteColor,
                                    ),
                                    const SizedBox(width: 2.0),
                                    Text(
                                      "${widget.listing.user?.avgRatingCount ?? 0.0}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: textTheme.headlineMedium?.copyWith(
                                          fontSize: 11.0,
                                          color: textWhiteColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 4.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/user_chat_icon.svg',
                                      color: iconWhiteColor,
                                    ),
                                    const SizedBox(width: 2.0),
                                    Text(
                                      "${widget.listing.user?.commentCount ?? 0}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: textTheme.headlineMedium?.copyWith(
                                          fontSize: 11.0,
                                          color: textWhiteColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      widget.listing.user?.id == profileController.profile.id
                          ? const SizedBox()
                          : Container(
                              child: widget.menuIcon
                                  ? CustomPopupMenu(
                                      arrowColor: lavaRedColor,
                                      menuBuilder: () => ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Container(
                                          color: lavaRedColor,
                                          child: IntrinsicWidth(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: ['Report Listing']
                                                  .map(
                                                    (item) => GestureDetector(
                                                      behavior: HitTestBehavior
                                                          .translucent,
                                                      onTap: () async {
                                                        _controller.hideMenu();
                                                        ConfirmationRiseDisputeBottomDialog(
                                                          textTheme: textTheme,
                                                          contentName:
                                                              "Are you sure you want to report this listing ?",
                                                          yesBtnClick:
                                                              () async {
                                                            if (reportController
                                                                .text
                                                                .trim()
                                                                .isEmpty) {
                                                              Helpers.toast(
                                                                  'Reason for Report is Required.');
                                                              return;
                                                            }
                                                            await Helpers
                                                                .loader();
                                                            bool isSuccess = await listingController
                                                                .reportListing(
                                                                    userGameServiceId:
                                                                        widget
                                                                            .listing
                                                                            .id);
                                                            await Helpers
                                                                .hideLoader();
                                                            if (isSuccess) {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            }
                                                          },
                                                          reportController:
                                                              reportController,
                                                          hintText:
                                                              'Reason For Report',
                                                          isReport: true,
                                                        ).showBottomDialog(
                                                            context);
                                                        // await Helpers.loader();
                                                        // await listingController
                                                        //     .reportListing(
                                                        //         userGameServiceId:
                                                        //             widget
                                                        //                 .listing
                                                        //                 .id);
                                                        // await Helpers
                                                        //     .hideLoader();
                                                        // _controller.hideMenu();
                                                        /* ConfirmationRiseDisputeBottomDialog(
                          textTheme: textTheme,
                          contentName:
                          "Are you sure you want raise a dispute against this order ?",
                        ).showBottomDialog(context);*/
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 20),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10),
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
                                      verticalMargin: 2,
                                      controller: _controller,
                                      child: Container(
                                        padding: const EdgeInsets.all(0),
                                        child: const Icon(Icons.more_vert,
                                            size: 20.0, color: iconWhiteColor),
                                      ),
                                    )
                                  : Container(),
                            )
                      /*SizedBox(
                          height: 4.h,
                          width: 5.w,
                          child: IconButton(
                            padding: const EdgeInsets.all(0.0),
                            color: iconWhiteColor,
                            icon: const Icon(Icons.more_vert, size: 18.0),
                            onPressed: () {
                              context.pushNamed(createNewDisputePage);
                            },
                          ))*/
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
