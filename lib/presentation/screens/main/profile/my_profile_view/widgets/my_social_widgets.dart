import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/profile/user.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/widgets/buttons/custom_button.dart';
import 'package:loby/presentation/widgets/custom_loader.dart';
import 'package:loby/presentation/widgets/text_fields/text_field_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../widgets/cusstom_text.dart';
import '../../../../../widgets/input_text_widget.dart';

class MySocialWidget extends StatefulWidget {
  final User user;

  const MySocialWidget({Key? key, required this.user}) : super(key: key);

  @override
  State<MySocialWidget> createState() => _MySocialWidgetState();
}

class _MySocialWidgetState extends State<MySocialWidget> {

  ProfileController profileController = Get.find<ProfileController>();

  TextEditingController instagram = TextEditingController(text: "https://www.instagram.com/");
  TextEditingController youtube = TextEditingController(text: "https://www.youtube.com/c/");
  TextEditingController discord = TextEditingController(text: "https://discord.com/channels/");
  TextEditingController twitch = TextEditingController(text: "https://www.twitch.tv/shroud");


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.getProfile(from: "social");
  }


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;


    return Obx(() {
      if(profileController.isSocialLinksFetching.value){
        return const CustomLoader();
      }else{

        instagram.text = profileController.profile.instagramId ?? "https://www.instagram.com/";
        youtube.text = profileController.profile.youtubeId ?? "https://www.youtube.com/c/";
        discord.text = profileController.profile.discordId ?? "https://discord.com/channels/";
        twitch.text = profileController.profile.twitchId ?? "https://www.twitch.tv/shroud";

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 2.h),
            buildItem(textTheme, 'Instagram',  instagram),
            SizedBox(height: 2.h),
            buildItem(textTheme, 'YouTube', youtube),
            SizedBox(height: 2.h),
            buildItem(textTheme, 'Discord',  discord),
            SizedBox(height: 2.h),
            buildItem(textTheme, 'Twitch', twitch),
            SizedBox(height: 6.h),
            CustomButton(
              color: butterflyBlueColor,
              name: "Update",
              left: 50.w,
              right: 0.w,
              bottom: 4.h,
              onTap: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                await Helpers.loader();
                await profileController.updateSocialLinks(
                    insta: instagram.text,
                    youtube: youtube.text,
                    discord: discord.text,
                    twitch: twitch.text,
                );

                await Helpers.hideLoader();
              },
            ),
          ],
        );
      }

    });
  }


  Widget buildItem(TextTheme textTheme, String socialTitle,
      TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(socialTitle,
            overflow: TextOverflow.ellipsis,
            style: textTheme.headline4
                ?.copyWith(color: textLightColor)),
        SizedBox(height: 1.h,),
        TextFieldWidget(
          textEditingController: controller,
        ),
        SizedBox(width: 1.h),
      ],
    );
  }
}