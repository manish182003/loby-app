import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/order/dispute.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../widgets/custom_cached_network_image.dart';
import '../my_order/widgets/order_status_constants.dart';

class DisputeWidget extends StatelessWidget {
  final String disputeType;
  final String currentStatus;
  final Dispute dispute;

  const DisputeWidget({Key? key, required this.disputeType, required this.currentStatus, required this.dispute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: (){
        context.pushNamed(createNewDisputePage, queryParams: {'disputeId' : "${dispute.id}"});
      },
      child: Column(
        children: <Widget>[
          Card(
            color: textFieldColor,
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      buildUser(textTheme, context,title:  'Seller', imageUrl: dispute.userOrder!.userGameService!.user!.image,name:  dispute.userOrder!.userGameService!.user!.displayName ?? ''),
                      const SizedBox(width: 8,),
                      buildUser(textTheme, context,title:  'Buyer', imageUrl: dispute.userOrder!.user!.image ,name:  dispute.userOrder!.user!.displayName ?? ''),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: orangeColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8.0),
                              child: Text(dispute.userOrder!.userGameService!.game!.name!,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.headline6?.copyWith(color: textWhiteColor)),
                            ),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: butterflyBlueColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8.0),
                              child: Text(dispute.userOrder!.userGameService!.title!,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.headline6
                                      ?.copyWith(color: textWhiteColor)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Listing ID : ',
                          style: textTheme.headline6?.copyWith(color: textLightColor),
                        ),
                        TextSpan(
                            text: dispute.userOrder!.userGameService!.id.toString(),
                            style: textTheme.headline6?.copyWith(color: textWhiteColor)),
                      ],
                    ),
                  ),
                ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Listing Name : ',
                            style: textTheme.headline6?.copyWith(color: textLightColor),
                          ),
                          TextSpan(
                              text: dispute.userOrder!.userGameService!.title.toString(),
                              style: textTheme.headline6?.copyWith(color: textWhiteColor)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Current Status : ',
                          style: textTheme.headline6?.copyWith(color: textLightColor),
                        ),
                        TextSpan(
                            text: "${dispute.result} on ${Helpers.formatDateTime(dateTime: dispute.updatedAt!)}",
                            style: textTheme.headline6?.copyWith(color: disputeType == 'PENDING' ? lavaRedColor : aquaGreenColor)),
                      ],
                    ),
                  ),
                ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  buildUser(TextTheme textTheme, BuildContext context, {required String title, required String? imageUrl,required name}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.30,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  textAlign: TextAlign.center,
                  title,
                  style: textTheme.headline5?.copyWith(color: whiteColor),
                ))),
        Padding(
          padding: EdgeInsets.symmetric(vertical:8.0, horizontal: 0.0),
          child: CircleAvatar(
            radius: 36,
            backgroundColor: butterflyBlueColor,
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: CircleAvatar(
                backgroundColor: backgroundDarkJungleGreenColor,
                radius: 36,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(36),
                    child: CustomCachedNetworkImage(
                      imageUrl: imageUrl,
                      name: name,
                    ),
                  ),
                ), //CircleAvatar
              ),
            ),
          ),
        ),
        Text(
          name,
          style: textTheme.headline5?.copyWith(color: textLightColor),
        )
      ],
    );
  }



}
