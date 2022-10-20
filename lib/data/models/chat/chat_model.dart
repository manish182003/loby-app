// ignore_for_file: overridden_fields, annotate_overrides

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:loby/data/models/profile/user_model.dart';
import 'package:loby/domain/entities/chat/chat.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';

import 'message_model.dart';

class ChatModel extends Chat{
  const ChatModel({
    this.id,
    this.senderId,
    this.receiverId,
    this.badgeCount,
    this.chatLatestDate,
    this.chatLatestMessage,
    this.senderInfo,
    this.receiverInfo,
    this.message,
  });

  final int? id;
  final int? senderId;
  final int? receiverId;
  final int? badgeCount;
  final DateTime? chatLatestDate;
  final String? chatLatestMessage;
  final UserModel? senderInfo;
  final UserModel? receiverInfo;
  final MessageModel? message;



  factory ChatModel.fromJson(Map<String, dynamic> json) {
    ProfileController profileController = Get.find<ProfileController>();
    return ChatModel(
        id: json["id"],
        senderId: profileController.profile.id == json["sender_id"] ? json["sender_id"] : json["receiver_id"],
        receiverId: profileController.profile.id == json["sender_id"] ? json["receiver_id"] : json["sender_id"],
        badgeCount: json["badgeCount"],
        chatLatestDate: DateTime.parse(json["chatLatestDate"]),
        chatLatestMessage: json["chatLatestMessage"],
        senderInfo:  profileController.profile.id == json["sender_id"] ? UserModel.fromJson(json["senderInfo"]) :  UserModel.fromJson(json["receiverInfo"]),
        receiverInfo: profileController.profile.id == json["sender_id"] ? UserModel.fromJson(json["receiverInfo"]) : UserModel.fromJson(json["senderInfo"]),
        message: json['chats'].map<MessageModel>((message) => MessageModel.fromJson(message)).toList().first,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "sender_id": senderId,
    "receiver_id": receiverId,
    "badgeCount": badgeCount,
    "chatLatestDate": chatLatestDate?.toIso8601String(),
    "chatLatestMessage": chatLatestMessage,
    "senderInfo": senderInfo?.toJson(),
    "receiverInfo": receiverInfo?.toJson(),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [id, senderId, receiverId, badgeCount];
}