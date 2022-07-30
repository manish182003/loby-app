import 'package:flutter/material.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../widgets/cusstom_text.dart';

class UserSocialWidget extends StatelessWidget {
  const UserSocialWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return _buildWidget(textTheme);
  }

  _buildWidget(TextTheme textTheme) {
    return Column(
      children: <Widget>[
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Instagram",
                  style: textTheme.headline5
                      ?.copyWith(color: textLightColor),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: MyText(
                  name: "https://www.instagram.com/loby.gg",
                  textColor: textWhiteColor,
                  myBackgroundColor: textFieldColor,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "YouTube",
                  style: textTheme.headline5
                      ?.copyWith(color: textLightColor),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: MyText(
                  name: "https://www.youtube.com/c/jabykoay",
                  textColor: textWhiteColor,
                  myBackgroundColor: textFieldColor,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Discord",
                  style: textTheme.headline5
                      ?.copyWith(color: textLightColor),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: MyText(
                  name: "https://discord.com/channels/827464017693769748",
                  textColor: textWhiteColor,
                  myBackgroundColor: textFieldColor,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Twitch",
                  style: textTheme.headline5
                      ?.copyWith(color: textLightColor),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: MyText(
                  name: "https://www.twitch.tv/shroud",
                  textColor: textWhiteColor,
                  myBackgroundColor: textFieldColor,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}