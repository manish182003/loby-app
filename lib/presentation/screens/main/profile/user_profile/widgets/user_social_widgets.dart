import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/profile/user.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../widgets/buttons/custom_button.dart';
import '../../../../../widgets/cusstom_text.dart';
import 'package:loby/core/utils/constants.dart';

import 'my_social_widgets.dart';


class UserSocialWidget extends StatelessWidget {
  final User user;
  final String from;

  const UserSocialWidget({Key? key, required this.user, required this.from})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    ProfileController profileController = Get.find<ProfileController>();
    return Obx(() {
      if(profileController.isSocialsEditable.value){
        return MySocialWidget(user: user);
      }else{
        return Column(
          children: [
            _buildWidget(textTheme, context),
            SizedBox(height: 4.h,),
            CustomButton(
              color: butterflyBlueColor,
              name: "Edit",
              left: 50.w,
              right: 0.w,
              bottom: 4.h,
              onTap: () async {
                profileController.isSocialsEditable.value = true;
                // await Helpers.hideLoader();
              },
            ),
          ],
        );
      }
    });
  }

  _buildWidget(TextTheme textTheme, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        buildItem(
            textTheme,
            context,
            'assets/icons/instagram_one_icon.svg',
            'Instagram',
            user.instagramId ?? "",
            50.0,
            50.0),
        const SizedBox(height: 16),
        buildItem(
            textTheme,
            context,
            'assets/icons/youtube_icon.svg',
            'YouTube',
            user.youtubeId ?? "",
            40.0,
            40.0),
        const SizedBox(height: 16),
        buildItem(
            textTheme,
            context,
            'assets/icons/discord_icon.svg',
            'Discord',
            user.discordId ?? "",
            40.0,
            40.0),
        const SizedBox(height: 16),
        buildItem(
            textTheme,
            context,
            'assets/icons/twitch_icon.svg',
            'Twitch',
            user.twitchId ?? "",
            40.0,
            40.0),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget buildItem(TextTheme textTheme, BuildContext context, String socialIcon,
      String socialTitle, String socialLink, double width, double height) {
    return Container(
      height: 8.5.h,
      decoration: BoxDecoration(
        color: textFieldColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  child: SvgPicture.asset(
                    socialIcon,
                    height: width,
                    width: height,
                  ),
                ),
                const SizedBox(width: 8.0,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(socialTitle,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.headline4
                              ?.copyWith(color: aquaGreenColor)),
                      const SizedBox(height: 6),
                      GestureDetector(
                        onTap: () {
                          Helpers.launch(socialLink);
                        },
                        child: Text(socialLink,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.headline6
                                ?.copyWith(color: whiteColor)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}