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
  final controller = ScrollController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    asyncFunctions();
  }

  Future<void> asyncFunctions() async {
    homeController.notificationPageNumber.value = 1;
    homeController.areMoreNotificationAvailable.value = true;
    await homeController.getNotifications();
    homeController.getUnreadCount(type: 'notification');

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        homeController.getNotifications();
      }
    });
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: appBar(context: context, appBarName: "Notifications", isBackIcon: false),
        body: BodyPaddingWidget(
          child: Obx(() {
            if(homeController.isNotificationFetching.value){
              return const CustomLoader();
            }else if(homeController.notifications.isEmpty) {
              return const NoDataFoundWidget();
            }else{
              return ListView.separated(
                shrinkWrap: true,
                controller: controller,
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 20),
                itemCount: homeController.notifications.length + 1,
                itemBuilder: (context, index) {
                  if (index < homeController.notifications.length) {
                    final notification = homeController.notifications[index];
                    return NotificationItemWidget(notification: notification);
                  } else {
                    return Obx(() {
                      if (homeController.areMoreNotificationAvailable.value) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 32.0),
                          child: Center(
                              child: CircularProgressIndicator()),
                        );
                      } else {
                        return const SizedBox();
                      }
                    });
                  }
                }, separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 2.h,);
              },
              );
            }
          }),
        ),
    );
  }
}
