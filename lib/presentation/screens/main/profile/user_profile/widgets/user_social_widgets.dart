import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loby/domain/entities/profile/user.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../widgets/cusstom_text.dart';

class UserSocialWidget extends StatelessWidget {
  final User user;
  const UserSocialWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return _buildWidget(textTheme, context);
  }

  _buildWidget(TextTheme textTheme, BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            buildItem(textTheme, context, 'assets/icons/instagram_one_icon.svg', 'Instagram', user.instagramId ?? "", 38.0, 38.0),
            const SizedBox(height: 16),
            buildItem(textTheme, context, 'assets/icons/youtube_icon.svg', 'YouTube', user.youtubeId ?? "", 32.0, 32.0),
            const SizedBox(height: 16),
            buildItem(textTheme, context, 'assets/icons/discord_icon.svg', 'Discord', user.discordId ?? "", 32.0, 32.0),
            const SizedBox(height: 16),
            buildItem(textTheme, context, 'assets/icons/twitch_icon.svg', 'Twitch', user.twitchId ?? "", 32.0, 32.0),
            const SizedBox(height: 16),
          ],
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
                              ?.copyWith(color: textTunaBlueColor)),
                      const SizedBox(height: 6),
                      Text(socialLink,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.headline6
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