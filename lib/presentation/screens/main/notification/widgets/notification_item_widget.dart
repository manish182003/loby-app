import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/home/notification.dart' as notify;
import 'package:loby/presentation/getx/controllers/core_controller.dart';
import 'package:loby/presentation/getx/controllers/home_controller.dart';
import 'package:sizer/sizer.dart';

class NotificationItemWidget extends StatelessWidget {
  final notify.Notification notification;

  const NotificationItemWidget({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
    CoreController coreController = Get.find<CoreController>();
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
        onTap: () {
          coreController.onNotificationClick(jsonEncode(notification), context);
        },
        child: Dismissible(
          key: Key(notification.title ?? ''),
          onDismissed: (direction) {
            homeController.deleteNotification(notificationId: notification.id);
          },
          background: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 6.w),
            decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.9),
                borderRadius: BorderRadius.circular(
                  8.0,
                )),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: backgroundBalticSeaColor,
              border: Border.all(width: 0.2, color: dividerColor),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  notification.message!,
                  style:
                      textTheme.headlineMedium?.copyWith(color: textWhiteColor),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    Helpers.formatDateTime(dateTime: notification.updatedAt!),
                    style:
                        textTheme.titleLarge?.copyWith(color: textLightColor),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
