import 'package:flutter/material.dart';
import 'package:loby/core/theme/colors.dart';

class NotificationItemWidget extends StatelessWidget {

  const NotificationItemWidget(
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
        onTap: () {
          debugPrint('hello bhai click hua');
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
          child: Card(
            elevation: 0,
            color: backgroundBalticSeaColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Container(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
              decoration: BoxDecoration(
                color: backgroundBalticSeaColor,
                border: Border.all(width: 0.2, color: dividerColor),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Sucessfully withdrawn Rs. 12,400 through UPI from Wallet ',
                    style: textTheme.headline4?.copyWith(color: textWhiteColor),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      'May 26, 2022 18:23',
                      style: textTheme.headline6?.copyWith(color: textLightColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
