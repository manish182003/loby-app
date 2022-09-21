import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/core/usecases/profile_params.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/presentation/getx/controllers/chat_controller.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/screens/main/chat/widgets/chat_tile.dart';
import 'package:loby/presentation/widgets/custom_app_bar.dart';
import 'package:loby/presentation/widgets/custom_loader.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  ChatController chatController = Get.find<ChatController>();
  ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatController.socketListener(profileController.profile.id!);
    chatController.getChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context: context, appBarName: "Chat", isBackIcon: false),
        body: Obx(() {
          if(chatController.isChatsFetching.value){
            return const CustomLoader();
          }else {
            return ListView.builder(
              itemCount: chatController.chats.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                return ChatTile(chat: chatController.chats[index]);
              },
            );
          }
        }),
    );
  }
}
