// ignore_for_file: overridden_fields, annotate_overrides

import 'package:loby/core/utils/helpers.dart';
import 'package:loby/data/models/order/order_model.dart';
import 'package:loby/data/models/profile/user_model.dart';
import 'package:loby/domain/entities/chat/message.dart';

class MessageModel extends Message{
  const MessageModel({
    this.id,
    this.chatChannelId,
    this.userId,
    this.message,
    this.filePath,
    this.fileType,
    this.readStatus,
    this.orderId,
    this.createdAt,
    this.updatedAt,
    this.userOrder,
    this.user,
  });

  final int? id;
  final int? chatChannelId;
  final int? userId;
  final String? message;
  final String? filePath;
  final int? fileType;
  final bool? readStatus;
  final int? orderId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final OrderModel? userOrder;
  final UserModel? user;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    id: json["id"],
    chatChannelId: json["chat_channel_id"],
    userId: json["user_id"],
    message: json["message"],
    filePath: json["file_path"] == null ? null : Helpers.getImage(json["file_path"]),
    fileType: int.tryParse(json["file_type"].toString()),
    readStatus: json["read_status"],
    orderId: json["order_id"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    userOrder: json["userOrder"] == null ? null : OrderModel.fromJson(json["userOrder"]),
    user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "chat_channel_id": chatChannelId,
    "user_id": userId,
    "message": message,
    "file_path": filePath,
    "file_type": fileType,
    "read_status": readStatus,
    "order_id": orderId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "userOrder": userOrder?.toJson(),
    "user": user?.toJson(),
  };

  @override

  List<Object?> get props => [id, chatChannelId, userId, message];
}
