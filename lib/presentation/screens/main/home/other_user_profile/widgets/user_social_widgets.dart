import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../widgets/cusstom_text.dart';

class UserSocialWidget extends StatelessWidget {
  const UserSocialWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return _buildWidget(textTheme, context);
  }

  _buildWidget(TextTheme textTheme, BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              buildItem(textTheme, context, 'assets/icons/instagram_one_icon.svg', 'Instagram', 'https://www.instagram.com/loby.gg', 38.0, 38.0),
              const SizedBox(height: 16),
              buildItem(textTheme, context, 'assets/icons/youtube_icon.svg', 'YouTube', 'https://www.youtube.com/c/jabykoay',32.0, 32.0),
              const SizedBox(height: 16),
              buildItem(textTheme, context, 'assets/icons/discord_icon.svg', 'Discord', 'https://discord.com/channels/827464017693769748', 32.0, 32.0),
              const SizedBox(height: 16),
              buildItem(textTheme, context, 'assets/icons/twitch_icon.svg', 'Twitch', 'https://www.twitch.tv/shroud', 32.0, 32.0),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildItem(TextTheme textTheme, BuildContext context, String socialIcon, String socialTitle, String socialLink, double width, double height) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 45, minWidth: double.infinity,),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  child: Container(
                    child: SvgPicture.asset(
                      socialIcon,
                      height: width,
                      width: height,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(socialTitle,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.headline5
                              ?.copyWith(color: textTunaBlueColor)),
                      SizedBox(height: 8),
                      Text(socialLink,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.subtitle1
                              ?.copyWith(color: purpleLightIndigoColor)),
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