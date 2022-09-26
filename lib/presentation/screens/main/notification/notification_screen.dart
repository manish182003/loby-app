import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:loby/presentation/getx/controllers/home_controller.dart';
import 'package:loby/presentation/screens/main/notification/widgets/notification_item_widget.dart';
import 'package:loby/presentation/widgets/custom_app_bar.dart';
import 'package:loby/presentation/widgets/custom_loader.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/colors.dart';
import '../../../widgets/body_padding_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.getNotifications();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: appBar(context: context, appBarName: "Notifications", isBackIcon: false),
        body: Obx(() {
          if(homeController.isNotificationFetching.value){
            return const CustomLoader();
          }else {
            return BodyPaddingWidget(
              child: ListView.separated(
                itemCount: homeController.notifications.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 16),
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return NotificationItemWidget(notification: homeController.notifications[index]);
                }, separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 1.h,);
              },
              ),
            );
          }
        }),
    );
  }
}
