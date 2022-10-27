import 'package:get/get.dart';
import 'package:loby/domain/usecases/chat/check_eligibility.dart';
import 'package:loby/domain/usecases/chat/get_chats.dart';
import 'package:loby/domain/usecases/chat/get_messages.dart';
import 'package:loby/domain/usecases/chat/send_message.dart';
import 'package:loby/presentation/getx/controllers/chat_controller.dart';


class ChatBinding extends Bindings{
  @override
  void dependencies() {

    final getChats = Get.find<GetChats>();
    final getMessages = Get.find<GetMessages>();
    final sendMessage = Get.find<SendMessage>();
    final checkEligibility = Get.find<CheckEligibility>();

    Get.lazyPut(() => ChatController(
      getChats: getChats,
      getMessages: getMessages,
      sendMessage: sendMessage,
      checkEligibility: checkEligibility
    ));
  }
}