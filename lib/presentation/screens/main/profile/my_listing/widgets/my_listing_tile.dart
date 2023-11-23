import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/listing/service_listing.dart';
import 'package:loby/presentation/getx/controllers/listing_controller.dart';
import 'package:loby/presentation/screens/main/profile/wallet/widgets/token_widget.dart';
import 'package:loby/presentation/widgets/custom_bottom_sheet.dart';
import 'package:loby/presentation/widgets/custom_cached_network_image.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../widgets/CustomSwitch.dart';
import '../../../../../widgets/SuccessfullyDeleteListingBottomDialog.dart';
import '../../../../../widgets/bottom_dialog.dart';
import '../../../../../widgets/confirmation_dialog.dart';
import 'edit_listing.dart';

class MyListingTile extends StatefulWidget {
  final ServiceListing listing;

  const MyListingTile({super.key, required this.listing});

  @override
  State<MyListingTile> createState() => _MyListingTileState();
}

class _MyListingTileState extends State<MyListingTile> {
  ListingController listingController = Get.find<ListingController>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        listingController.totalPrice.value =
            (listingController.quantityCount.value * widget.listing.price!)
                .toString();
        context.pushNamed(gameDetailPage, queryParams: {
          'serviceListingId': "${widget.listing.id}",
          'from': 'myListing'
        });
      },
      child: Card(
        color: backgroundBalticSeaColor,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                  child: Container(
                    height: 12.h,
                    width: 38.w,
                    decoration: BoxDecoration(
                      color: aquaGreenColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CustomCachedNetworkImage(
                        imageUrl: Helpers.getListingImage(widget.listing),
                        placeHolder: Image.asset(
                          "assets/images/listing_placeholder.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                // ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Inactive",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: textTheme.headline5
                            ?.copyWith(color: textWhiteColor)),
                    SizedBox(
                      width: 2.w,
                    ),
                    CustomSwitch(
                      value: widget.listing.status == "0" ? false : true,
                      onChanged: (bool val) {
                        setState(() {
                          if (val) {
                            widget.listing.status = "1";
                          } else {
                            widget.listing.status = "0";
                          }
                          listingController.changeListingStatus(
                              listingId: widget.listing.id!, type: 'change');
                        });
                      },
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text("Active",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: textTheme.headline5
                            ?.copyWith(color: textWhiteColor)),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
            SizedBox(
              width: 43.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // widget.listing.title!
                          children: <Widget>[
                            Text(widget.listing.title!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: textTheme.headline5
                                    ?.copyWith(color: textWhiteColor)),
                            // SizedBox(height: 1.h,),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(widget.listing.game?.name! ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: textTheme.headline6
                                      ?.copyWith(color: textInputTitleColor)),
                            )
                          ])),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 14.w,
                        child: Container(
                          decoration: BoxDecoration(
                            color: orangeColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          margin: const EdgeInsets.only(right: 4.0),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 6.0),
                            child: Text(
                              widget.listing.category?.name! ?? '',
                              style: textTheme.headline6
                                  ?.copyWith(color: textWhiteColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      TokenWidget(
                        size: 20,
                        text: Text("${widget.listing.price!}",
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.headline2
                                ?.copyWith(color: aquaGreenColor)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          // width: 38.w,
                          child: _actionButton(textTheme, title: "Edit",
                              onTap: () async {
                        Helpers.loader();
                        await listingController.getConfigurations(
                            categoryId: widget.listing.categoryId,
                            gameId: widget.listing.gameId);
                        Helpers.hideLoader();
                        _showEditListingBottomSheet(context, widget.listing);
                      }, color: butterflyBlueColor)),
                      SizedBox(
                          // width: 38.w,
                          child: _actionButton(textTheme, title: "Delete",
                              onTap: () {
                        // Helpers.loader();
                        _deleteDialog(context);
                        // Helpers.hideLoader();
                      }, color: lavaRedColor)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),

        // child: Column(
        //   // crossAxisAlignment: CrossAxisAlignment.stretch,
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: <Widget>[
        //     AspectRatio(
        //       aspectRatio: 18.0 / 12.0,
        //       child: Padding(
        //         padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
        //         child: Container(
        //           decoration: BoxDecoration(
        //             color: aquaGreenColor,
        //             borderRadius: BorderRadius.circular(16),
        //           ),
        //           child: ClipRRect(
        //             borderRadius: BorderRadius.circular(16),
        //             child: CustomCachedNetworkImage(
        //               imageUrl: Helpers.getListingImage(widget.listing),
        //               placeHolder: Image.asset("assets/images/listing_placeholder.jpg", fit: BoxFit.cover,),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: <Widget>[
        //           Text(widget.listing.title!,
        //               overflow: TextOverflow.ellipsis,
        //               maxLines: 1,
        //               style: textTheme.headline5?.copyWith(color: textWhiteColor)),
        //           Padding(
        //             padding: const EdgeInsets.symmetric(vertical: 5.0),
        //             child: Text(widget.listing.game?.name! ?? '',
        //                 overflow: TextOverflow.ellipsis,
        //                 maxLines: 1,
        //                 style: textTheme.headline6?.copyWith(color: textInputTitleColor)),
        //           ),
        //           Text("${widget.listing.stockAvl} Stocks Available",
        //               overflow: TextOverflow.ellipsis,
        //               maxLines: 1,
        //               style: textTheme.headline6?.copyWith(color: widget.listing.stockAvl == 0 ? carminePinkColor : textInputTitleColor)),
        //           SizedBox(height: 1.h),
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: <Widget>[
        //               SizedBox(
        //                 width: 14.w,
        //                 child: Container(
        //                   decoration: BoxDecoration(
        //                     color: orangeColor,
        //                     borderRadius: BorderRadius.circular(16),
        //                   ),
        //                   margin: const EdgeInsets.only(right: 4.0),
        //                   alignment: Alignment.center,
        //                   child: Padding(
        //                     padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
        //                     child: Text(widget.listing.category?.name! ?? '', style: textTheme.headline6?.copyWith(color: textWhiteColor), maxLines: 1, overflow: TextOverflow.ellipsis,),
        //                   ),
        //                 ),
        //               ),
        //               TokenWidget(
        //                 size: 20,
        //                 text: Text( "${widget.listing.price!}",
        //                     overflow: TextOverflow.ellipsis,
        //                     style: textTheme.headline2
        //                         ?.copyWith(color: aquaGreenColor)),
        //               )

        //             ],
        //           ),
        //           const SizedBox(height: 4.0),
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               SizedBox(
        //                 // width: 38.w,
        //                 child: _actionButton(textTheme, title: "Edit", onTap: ()async{
        //                   Helpers.loader();
        //                   await listingController.getConfigurations(categoryId: widget.listing.categoryId, gameId: widget.listing.gameId);
        //                   Helpers.hideLoader();
        //                   _showEditListingBottomSheet(context, widget.listing);
        //                 }, color: butterflyBlueColor)
        //               ),
        //               // SizedBox(
        //               //     width: MediaQuery.of(context).size.width * 0.18,
        //               //     child: _actionButton(textTheme, title: "Delete", color: lavaRedColor, onTap: (){
        //               //       ConfirmationBottomDialog(
        //               //           textTheme: textTheme,
        //               //           contentName: "Are you sure you want delete this listing ?",
        //               //           yesBtnClick: ()async{
        //               //             Helpers.loader();
        //               //             final isSuccess = await listingController.changeListingStatus(listingId: widget.listing.id!, type: 'delete');
        //               //             Helpers.hideLoader();
        //               //             if(isSuccess){
        //               //               listingController.buyerListingsProfile.removeWhere((element) => element.id == widget.listing.id);
        //               //               listingController.buyerListingsProfile.refresh();
        //               //               Navigator.pop(context);
        //               //               SuccessfullyDeleteListingDialog(
        //               //                 textTheme: textTheme,
        //               //                 contentName: "Your listing has been completely deleted. Any ongoing order still needs to be completed",).showBottomDialog(context);
        //               //             }
        //               //       }).showBottomDialog(context);
        //               //     })
        //               // ),
        //             ],
        //           ),
        //           const SizedBox(height: 8.0),
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Text("Inactive",
        //                   overflow: TextOverflow.ellipsis,
        //                   maxLines: 1,
        //                   style: textTheme.headline5
        //                       ?.copyWith(color: textWhiteColor)),
        //               CustomSwitch(
        //                 value: widget.listing.status == "0" ? false : true,
        //                 onChanged: (bool val) {
        //                   setState(() {
        //                     if(val){
        //                       widget.listing.status = "1";
        //                     }else{
        //                       widget.listing.status = "0";
        //                     }
        //                     listingController.changeListingStatus(listingId: widget.listing.id!, type: 'change');
        //                   });
        //                 },
        //               ),
        //               Text("Active",
        //                   overflow: TextOverflow.ellipsis,
        //                   maxLines: 1,
        //                   style: textTheme.headline5
        //                       ?.copyWith(color: textWhiteColor)),
        //             ],
        //           ),
        //           const SizedBox(height: 16.0),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }

  Future<void> _deleteDialog(BuildContext context) async {
    final textTheme = Theme.of(context).textTheme;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundDarkJungleGreenColor,

          // title: Text('Delete Slot'),

          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('Are you sure?',
                    style:
                        textTheme.headline5?.copyWith(color: textWhiteColor)),
                Text('You want to delete this Listing',
                    style:
                        textTheme.headline5?.copyWith(color: textWhiteColor)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              width: 28.w,
            ),
            TextButton(
              child: Text(
                'Delete',
                style: TextStyle(color: aquaGreenColor),
              ),
              onPressed: () {
                listingController
                    .changeListingStatus(
                        listingId: widget.listing.id!, type: 'delete')
                    .then((value) {
                  listingController.buyerListingsProfile.removeWhere(
                      (element) => element.id == widget.listing.id);
                  listingController.buyerListingsProfile.refresh();
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }

  Widget _actionButton(TextTheme textTheme,
      {required String title,
      required Function() onTap,
      required Color color}) {
    return TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ))),
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(title,
            style: textTheme.headline6?.copyWith(color: textWhiteColor)),
      ),
    );
  }

  void _showEditListingBottomSheet(
      BuildContext context, ServiceListing listing) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: CustomBottomSheet(
              isDismissible: false,
              initialChildSize: 0.90,
              maxChildSize: 0.90,
              minChildSize: 0.5,
              child: EditListing(listing: listing)),
        );
      },
    );
  }
}
