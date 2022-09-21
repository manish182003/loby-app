import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import '../../../../../domain/entities/chat/message.dart';


class MessageWidget extends StatelessWidget {
  final Message message;
  const MessageWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    ProfileController profileController = Get.find<ProfileController>();

    print("here ${message.userId == profileController.profile.id}");

    return message.userId == profileController.profile.id ? Padding(
      padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
      child: Column(
        children: [
          /*Row(
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
          ),*/
          Row(
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
                      message.message ?? "",
                        style: textTheme.headline6?.copyWith(color: textLightColor),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ) : Padding(
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
                    message.message ?? "",
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
