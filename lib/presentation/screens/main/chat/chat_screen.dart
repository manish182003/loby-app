import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/presentation/getx/controllers/chat_controller.dart';
import 'package:loby/presentation/getx/controllers/home_controller.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/screens/main/chat/widgets/chat_tile.dart';
import 'package:loby/presentation/widgets/custom_app_bar.dart';
import 'package:loby/presentation/widgets/custom_loader.dart';

class ChatScreen extends StatefulWidget {
  bool isFromCustomTab;
  ChatScreen({
    super.key,
    this.isFromCustomTab = false,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatController chatController = Get.find<ChatController>();
  ProfileController profileController = Get.find<ProfileController>();
  HomeController homeController = Get.find<HomeController>();
  final controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    chatController.chatsPageNumber.value = 1;
    chatController.areMoreChatsAvailable.value = true;
    chatController.getChats();

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        chatController.getChats();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    homeController.getUnreadCount(type: 'chat');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context: context,
        appBarName: "Chat",
        isBackIcon: widget.isFromCustomTab ? false : true,
      ),
      body: Obx(() {
        if (chatController.isChatsFetching.value) {
          return const CustomLoader();
        } else if (chatController.chats.isEmpty) {
          return const NoDataFoundWidget();
        } else {
          return ListView.builder(
            shrinkWrap: true,
            controller: controller,
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 20),
            itemCount: chatController.chats.length + 1,
            itemBuilder: (context, index) {
              if (index < chatController.chats.length) {
                final chat = chatController.chats[index];
                return ChatTile(chat: chat);
              } else {
                return Obx(() {
                  if (chatController.areMoreChatsAvailable.value) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 32.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    return const SizedBox();
                  }
                });
              }
            },
          );
        }
      }),
    );
  }
}
