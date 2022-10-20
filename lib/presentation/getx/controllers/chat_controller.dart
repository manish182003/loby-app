import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loby/core/usecases/chat_params.dart';
import 'package:loby/core/usecases/home_params.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/data/models/chat/message_model.dart';
import 'package:loby/domain/entities/chat/chat.dart';
import 'package:loby/domain/entities/chat/message.dart';
import 'package:loby/domain/usecases/chat/get_chats.dart';
import 'package:loby/domain/usecases/chat/get_messages.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:loby/presentation/getx/controllers/core_controller.dart';
import 'dart:ui' as ui;
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:loby/domain/usecases/chat/send_message.dart';


class ChatController extends GetxController{

  final GetChats _getChats;
  final GetMessages _getMessages;
  final SendMessage _sendMessage;

  ChatController({
    required GetChats getChats,
    required GetMessages getMessages,
    required SendMessage sendMessage,
  }) : _getChats = getChats,
  _getMessages = getMessages,
  _sendMessage = sendMessage;

  final errorMessage = "".obs;


  final chats = <Chat>[].obs;
  final isChatsFetching = false.obs;
  final areMoreChatsAvailable = true.obs;
  final chatsPageNumber = 1.obs;


  // final messages = <Message>[].obs;
  final chatMessagesMap = <Map<String, dynamic>>[].obs;
  final chatMessages = <types.Message>[].obs;
  final isMessagesFetching = false.obs;



  Future<bool> getChats({String? name}) async {
    chatsPageNumber.value == 1 ? isChatsFetching(true) : isChatsFetching(false);

    if(areMoreChatsAvailable.value){
      final failureOrSuccess = await _getChats(
        Params(chatParams: ChatParams(
            name: name,
            page: chatsPageNumber.value
        ),),
      );

      failureOrSuccess.fold(
            (failure) {
          errorMessage.value = Helpers.convertFailureToMessage(failure);
          debugPrint(errorMessage.value);
          Helpers.toast(errorMessage.value);
          isChatsFetching(false);
        },
            (success) {
          areMoreChatsAvailable.value = success.chats.length == 10;

          if (chatsPageNumber > 1) {
            chats.addAll(success.chats.where((a) => chats.every((b) => a.id != b.id)));
          } else {
            chats.value = success.chats;
          }
          chatsPageNumber.value++;

          isChatsFetching.value = false;
        },
      );
      return failureOrSuccess.isRight() ? true : false;
    }
    return false;
  }

  Future<bool> getMessages({required int? chatId}) async {
    isMessagesFetching(true);

    final failureOrSuccess = await _getMessages(
      Params(chatParams: ChatParams(
        chatId: chatId,
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
        isMessagesFetching(false);
      },
          (success) {
        // messages.value = success.messages;

        for(final i in success.messages){

          int height = 0;
          int width = 0;

          if(i.fileType == 2){
            final String url = i.filePath?.replaceAll("images", "chat") ?? " ";
            Image image = Image.network(url);

            image.image.resolve(const ImageConfiguration()).addListener(ImageStreamListener((ImageInfo info, bool isSync) {
              height = info.image.height;
              width = info.image.width;
            }));
          }

          chatMessagesMap.add({
            "author": {
              "firstName": i.user!.displayName,
              "id": "${i.userId}",
              "lastName": "",
              if(i.user?.image != null) "imageUrl": i.user!.image,
            },
            "createdAt": i.createdAt!.millisecondsSinceEpoch,
            "id": "${i.id}",
            "status": i.readStatus! ?  "seen" : "delivered",
            "type": i.orderId != null ? 'custom' : i.fileType == 2 ? "image" : "text",
            "text": i.message ?? i.filePath?.replaceAll("images", "chat") ?? " ",
            "height": height,
            "name": "Loby_${DateTime.now().millisecondsSinceEpoch}",
            "size": 0,
            "uri": i.filePath?.replaceAll("images", "chat") ?? " ",
            "width": width,
            "metadata": {
              'image': i.orderId == null ? "" : Helpers.getListingImage(i.userOrder!.userGameService!),
              'name' : i.orderId == null ? "" : i.userOrder?.userGameService?.title,
              'desc' : i.orderId == null ? "" : i.userOrder?.userGameService?.description,
              'category' : i.orderId == null ? "" : i.userOrder?.userGameService?.category!.name,
              'price' : i.orderId == null ? "" : i.userOrder?.userGameService?.price,
            }
          });
        }
        chatMessages.value = chatMessagesMap.map((e) => types.Message.fromJson(e)).toList();
        isMessagesFetching(false);
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }


  Future<bool> sendMessage({int? receiverId, String? message, int? fileType, File? file}) async {
    CoreController coreController = Get.find<CoreController>();

    final failureOrSuccess = await _sendMessage(
      Params(chatParams: ChatParams(
        receiverId: receiverId,
        message: message,
        fileType: fileType,
        file: file,
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {
            if(coreController.socket.connected){
              coreController.socket.emit('loby', {
                'type' : 'chat',
                'receiverId' : receiverId,
                'message': success['data'],
              });
            }
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }




}