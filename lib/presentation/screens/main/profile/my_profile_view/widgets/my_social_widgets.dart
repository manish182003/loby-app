import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../widgets/cusstom_text.dart';
import '../../../../../widgets/input_text_widget.dart';

class MySocialWidget extends StatefulWidget {
  const MySocialWidget({Key? key}) : super(key: key);

  @override
  State<MySocialWidget> createState() => _MySocialWidgetState();
}

class _MySocialWidgetState extends State<MySocialWidget> {
  final TextEditingController _instagram_Controller = TextEditingController();
  String instagram_userName = 'loby.gg';

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
              buildItem(textTheme, context, 'Instagram', 'https://www.instagram.com/', 'loby.gg', _instagram_Controller),
              const SizedBox(height: 16),
              buildItem(textTheme, context, 'YouTube', 'https://www.youtube.com/c/', 'jabykoay', _instagram_Controller),
              const SizedBox(height: 16),
              buildItem(textTheme, context, 'Discord', 'https://discord.com/channels/', '827464017693769748', _instagram_Controller),
              const SizedBox(height: 16),
              buildItem(textTheme, context, 'Twitch', 'https://www.twitch.tv/shroud', 'shroud', _instagram_Controller),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildItem(TextTheme textTheme, BuildContext context, String socialTitle, String socialLink, String userName, TextEditingController controller) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(socialTitle,
              overflow: TextOverflow.ellipsis,
              style: textTheme.headline5
                  ?.copyWith(color: textLightColor)),
          const SizedBox(
            width: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(socialLink,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.headline6
                      ?.copyWith(color: textWhiteColor)),
              SizedBox(width: 8),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: InputTextWidget(
                  controller: controller,
                  onChanged: (String value) {
                    instagram_userName = value;
                    debugPrint('Hello from input: $instagram_userName');
                  },
                  hintName: userName,
                  keyboardType: TextInputType.name,
                ),
              ),
            ],
          )
        ],
      );
  }
}