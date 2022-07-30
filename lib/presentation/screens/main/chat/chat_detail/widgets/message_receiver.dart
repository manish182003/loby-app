import 'package:flutter/material.dart';

import '../../../../../../core/theme/colors.dart';

class MessageReceiverWidget extends StatelessWidget {
  final String imageUrl;
  final String text;
  final String time;

  const MessageReceiverWidget(
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: const BoxDecoration(
                color: butterflyBlueColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
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
                    style: textTheme.headline6?.copyWith(color: textWhiteColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
