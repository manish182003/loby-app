import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:loby/data/models/chat/chat_model.dart';
import 'package:loby/data/models/chat/message_model.dart';
import 'package:loby/data/models/order/order_model.dart';
import 'package:loby/presentation/getx/controllers/chat_controller.dart';
import 'package:loby/presentation/getx/controllers/order_controller.dart';
import 'dart:ui' as ui;
import 'package:socket_io_client/socket_io_client.dart' as io;

class CoreController extends GetxController{


  late io.Socket socket;
  ChatController chatController = Get.find<ChatController>();


  Future<void> connect(int userId)async{
    socket = io.io("http://192.168.52.210:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
      },
    );
    socket.connect();
    socket.onConnect((data){
      socketListener(userId);
      debugPrint("Socket is Connected");
    });
    debugPrint('socket status is connected? ${socket.connected}');
  }


  void socketListener(int userId){
    socket.on("$userId", (data) {
      debugPrint('socket data $data');
      _socketActions(data: data);
    });
  }

  void _socketActions({required Map<String, dynamic> data}){

    switch(data['type']){

      case 'chat':
        _chatAction(data: data);
        break;

      case 'order':
        _orderAction(data: data);
        break;

    }

  }


  void _chatAction({required Map<String, dynamic> data}){
    int height = 0;
    int width = 0;
    final message = MessageModel.fromJson(data['message']);

    if(message.fileType == 2){
      final String url = message.filePath?.replaceAll("images", "chat") ?? " ";
      Image image = Image.network(url);

      image.image.resolve(const ImageConfiguration()).addListener(ImageStreamListener((ImageInfo info, bool isSync) {
        height = info.image.height;
        width = info.image.width;
      }));
    }

    final socketMessageMap = {
      "author": {
        "firstName": message.user!.displayName,
        "id": "${message.userId}",
        "lastName": "",
        if(message.user?.image != null) "imageUrl": message.user!.image,
      },
      "createdAt": message.createdAt!.millisecondsSinceEpoch,
      "id": "${message.id}",
      "status": message.readStatus! ?  "seen" : "delivered",
      "type": message.orderId != null ? 'custom' : message.fileType == 2 ? "image" : "text",
      "text": message.message ?? message.filePath ?? " ",
      "height": height,
      "name": "Loby_${DateTime.now().millisecondsSinceEpoch}",
      "size": 0,
      "uri": message.filePath ??  " ",
      "width": width,
      "metadata": {
        'image': message.orderId == null ? "" : message.userOrder!.userGameService!.userGameServiceImages!.isEmpty ? '' : message.userOrder!.userGameService!.userGameServiceImages?.first.type == 2 ? message.userOrder!.userGameService!.userGameServiceImages!.first.path! : '',
        'name' : message.orderId == null ? "" : message.userOrder!.userGameService!.title,
        'desc' : message.orderId == null ? "" : message.userOrder!.userGameService!.description,
        'category' : message.orderId == null ? "" : message.userOrder!.userGameService!.category!.name,
        'price' : message.orderId == null ? "" : message.userOrder!.userGameService!.price,
      }
    };
    chatController.chatMessages.insert(0, types.Message.fromJson(socketMessageMap));
    chatController.chatMessages.refresh();

    final chat = chatController.chats.where((element) => element.id == data['message']['contact']['id']).toList();
    if(chat.isEmpty){
      chatController.chats.insert(0, ChatModel.fromJson(data['message']['contact']));
    }else{
      chatController.chats.removeWhere((element) => element.id == data['message']['contact']['id']);
      chatController.chats.insert(0, ChatModel.fromJson(data['message']['contact']));
    }
    chatController.chats.refresh();

  }


  void _orderAction({required Map<String, dynamic> data}){
    OrderController orderController = Get.find<OrderController>();
    final index = orderController.orders.indexWhere((element) => element.id == data['order']['id']);

    print("orderController.orders before ${orderController.orders[index].userGameService!.game!.image}");

    orderController.orders[index] = OrderModel.fromJson(data['order']);
    orderController.orders.refresh();

    print("orderController.orders after ${orderController.orders[index].userGameService!.game!.image}");

  }


}