import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/domain/entities/profile/duel_details.dart';
import 'package:loby/domain/entities/profile/duel_details_count.dart';
import 'package:loby/domain/entities/profile/user.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/widgets/custom_cached_network_image.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../widgets/custom_loader.dart';

class UserDuelsWidget extends StatefulWidget {
  final User user;

  const UserDuelsWidget({super.key, required this.user});

  @override
  State<UserDuelsWidget> createState() => _UserDuelsWidgetState();
}

class _UserDuelsWidgetState extends State<UserDuelsWidget> {
  ProfileController profileController = Get.find<ProfileController>();
  final controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    profileController.duelDetailsPageNumber.value = 1;
    profileController.areMoreDuelDetailsAvailable.value = true;
    profileController.getDuel(userId: widget.user.id);

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        profileController.getDuel(userId: widget.user.id);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Obx(() {
      if (profileController.isDuelDetailsFetching.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (profileController.duelDetailsList.isEmpty) {
        return const NoDataFoundWidget();
      } else {
        final duelDetailsCount = profileController.duelDetailsCount;
        return Column(
          children: <Widget>[
            winLossTile(textTheme, duelDetailsCount.value),
            ListView.builder(
              shrinkWrap: true,
              controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 20),
              itemCount: profileController.duelDetailsList.length + 1,
              itemBuilder: (context, index) {
                if (index < profileController.duelDetailsList.length) {
                  final duelDetails = profileController.duelDetailsList[index];
                  return DuelWidget(
                    duelDetails: duelDetails,
                  );
                } else {
                  return Obx(() {
                    if (profileController.areMoreDuelDetailsAvailable.value) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 32.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else {
                      return const SizedBox();
                    }
                  });
                }
              },
            ),
          ],
        );
      }
    });
  }

  Widget winLossTile(TextTheme textTheme, DuelDetailsCount duelDetailsCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        color: backgroundBalticSeaColor,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Container(
            decoration: BoxDecoration(
              color: aquaGreenColor,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Total WINS',
                          textAlign: TextAlign.center,
                          style: textTheme.headlineMedium?.copyWith(
                              color: textTunaBlueColor,
                              fontWeight: FontWeight.w500)),
                      Text("${duelDetailsCount.winCount}",
                          textAlign: TextAlign.center,
                          style: textTheme.headlineLarge?.copyWith(
                              color: textTunaBlueColor,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Total LOSSES',
                          textAlign: TextAlign.center,
                          style: textTheme.headlineMedium?.copyWith(
                              color: textTunaBlueColor,
                              fontWeight: FontWeight.w500)),
                      Text("${duelDetailsCount.loseCount ?? 0}",
                          textAlign: TextAlign.center,
                          style: textTheme.headlineLarge?.copyWith(
                              color: textTunaBlueColor,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  _buildUser(TextTheme textTheme, String name, Color borderColor,
      BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTitleField(textTheme, name, borderColor, context),
        _buildUserAvtar(lavaRedColor),
        _buildNameField(textTheme, 'Mukesh',
            textTheme.titleLarge?.copyWith(color: textLightColor)),
      ],
    );
  }

  _buildNameField(TextTheme textTheme, String name, var style) {
    return Text(
      name,
      style: style,
    );
  }

  _buildTitleField(TextTheme textTheme, String name, Color borderColor,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
      child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          /*decoration: BoxDecoration(
            color: textFieldColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(10.0),
          ),*/
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.center,
                name,
                style: textTheme.headlineSmall?.copyWith(color: whiteColor),
              ))),
    );
  }

  _buildUserAvtar(Color borderColor) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: CircleAvatar(
        radius: 32,
        backgroundColor: butterflyBlueColor,
        child: Padding(
          padding: EdgeInsets.all(2.0),
          child: CircleAvatar(
            backgroundColor: backgroundDarkJungleGreenColor,
            radius: 32,
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/img.png'),
                radius: 32,
                backgroundColor: backgroundDarkJungleGreenColor,
              ),
            ), //CircleAvatar
          ),
        ),
      ),
    );
  }
}

class DuelWidget extends StatelessWidget {
  final DuelDetails duelDetails;

  const DuelWidget({super.key, required this.duelDetails});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        // context.pushNamed(createNewDisputePage, extra: {'disputeId' : "${dispute.id}"});
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
                          title: 'Winner',
                          imageUrl: duelDetails.winner?.image,
                          name: duelDetails.winner?.displayName),
                      const SizedBox(
                        width: 8,
                      ),
                      buildUser(textTheme, context,
                          title: 'Loser',
                          imageUrl: duelDetails.loser?.image,
                          name: duelDetails.loser?.displayName),
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
                                  duelDetails.userGameService?.game?.name ?? '',
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
                                  duelDetails.userGameService?.title ?? '',
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  buildUser(TextTheme textTheme, BuildContext context,
      {required String title, required String? imageUrl, required name}) {
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
          child: CircleAvatar(
            radius: 36,
            backgroundColor: butterflyBlueColor,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
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
          name ?? '',
          style: textTheme.headlineSmall?.copyWith(color: textLightColor),
        )
      ],
    );
  }
}
