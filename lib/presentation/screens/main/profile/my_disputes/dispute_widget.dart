import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/order/dispute.dart';
import 'package:loby/domain/entities/profile/user.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../getx/controllers/profile_controller.dart';
import '../../../../widgets/profile_picture.dart';

class DisputeWidget extends StatelessWidget {
  final String disputeType;
  final String currentStatus;
  final Dispute dispute;
  final String? from;

  const DisputeWidget(
      {super.key,
      required this.disputeType,
      required this.currentStatus,
      required this.dispute,
      this.from});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        if (from == 'list') {
          context.pushNamed(createNewDisputePage,
              extra: {'disputeId': "${dispute.id}"});
        }
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
                      buildUser(textTheme, context,
                          profile: dispute.userOrder!.userGameService!.user!,
                          userId: dispute.userOrder!.userGameService!.user!.id!,
                          title: 'Seller',
                          imageUrl:
                              dispute.userOrder!.userGameService!.user!.image,
                          name: dispute.userOrder!.userGameService!.user!
                                  .displayName ??
                              ''),
                      const SizedBox(
                        width: 8,
                      ),
                      buildUser(textTheme, context,
                          profile: dispute.userOrder!.user!,
                          userId: dispute.userOrder!.user!.id!,
                          title: 'Buyer',
                          imageUrl: dispute.userOrder!.user!.image,
                          name: dispute.userOrder!.user!.displayName ?? ''),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 16.0),
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
                              child: Text(
                                  dispute
                                      .userOrder!.userGameService!.game!.name!,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.titleLarge
                                      ?.copyWith(color: textWhiteColor)),
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
                              child: Text(
                                  dispute.userOrder!.userGameService!.title!,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.titleLarge
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
                            text: 'Dispute ID : ',
                            style: textTheme.titleLarge
                                ?.copyWith(color: textLightColor),
                          ),
                          TextSpan(
                              text: dispute.disputeNumber.toString(),
                              style: textTheme.titleLarge
                                  ?.copyWith(color: textWhiteColor)),
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
                            text: 'Listing ID : ',
                            style: textTheme.titleLarge
                                ?.copyWith(color: textLightColor),
                          ),
                          TextSpan(
                              text: dispute
                                  .userOrder!.userGameService!.listingNumber
                                  .toString(),
                              style: textTheme.titleLarge
                                  ?.copyWith(color: textWhiteColor)),
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
                            style: textTheme.titleLarge
                                ?.copyWith(color: textLightColor),
                          ),
                          TextSpan(
                              text: dispute.userOrder!.userGameService!.title
                                  .toString(),
                              style: textTheme.titleLarge
                                  ?.copyWith(color: textWhiteColor)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  dispute.disputeWinner == 'None'
                      ? const SizedBox()
                      : Align(
                          alignment: Alignment.center,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Winner : ',
                                  style: textTheme.titleLarge
                                      ?.copyWith(color: textLightColor),
                                ),
                                TextSpan(
                                    text: dispute.disputeWinner,
                                    style: textTheme.titleLarge
                                        ?.copyWith(color: textWhiteColor)),
                              ],
                            ),
                          ),
                        ),
                  dispute.disputeWinner == 'None'
                      ? const SizedBox(height: 0)
                      : const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Current Status : ',
                            style: textTheme.titleLarge
                                ?.copyWith(color: textLightColor),
                          ),
                          TextSpan(
                              text:
                                  "${dispute.result} on ${Helpers.formatDateTime(dateTime: dispute.updatedAt!)}",
                              style: textTheme.titleLarge?.copyWith(
                                  color: dispute.result!.contains('PENDING')
                                      ? lavaRedColor
                                      : aquaGreenColor)),
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

  buildUser(TextTheme textTheme, BuildContext context,
      {required int userId,
      required String title,
      required String? imageUrl,
      required String name,
      required User profile}) {
    ProfileController profileController = Get.find<ProfileController>();
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
                  style: textTheme.headlineSmall?.copyWith(color: whiteColor),
                ))),
        GestureDetector(
          onTap: () {
            context.pushNamed(userProfilePage, extra: {
              'userId': "$userId",
              'from': profileController.profile.id == userId
                  ? ConditionalConstants.myProfile
                  : ConditionalConstants.otherProfile,
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
            child: ProfilePicture(
              profile: profile,
              radius: 36,
            ),
          ),
        ),
        Text(
          name,
          style: textTheme.headlineSmall?.copyWith(color: textLightColor),
        )
      ],
    );
  }
}
