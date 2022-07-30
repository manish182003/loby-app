import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/theme/colors.dart';

class MessageSenderWidget extends StatelessWidget {
  final String imageUrl;
  final String text;
  final String time;

  const MessageSenderWidget(
      {Key? key,
      required this.imageUrl,
      required this.text,
      required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundColor: backgroundDarkJungleGreenColor,
                radius: 24,
                child: Padding(
                  padding: EdgeInsets.all(1.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/img.png'),
                    radius: 24,
                  ),
                ), //CircleAvatar
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Mukesh",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: textTheme.headline5?.copyWith(color: textWhiteColor),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        time,
                        style: textTheme.headline6?.copyWith(color: textLightColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 12.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: textFieldColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 11,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: textTheme.headline6?.copyWith(color: textLightColor),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
