import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:loby/data/models/chat/chat_model.dart';
import 'package:loby/data/models/chat/message_model.dart';
import 'package:loby/domain/entities/chat/chat.dart';
import 'package:loby/domain/entities/response_entities/chat/chat_response.dart';
import 'package:loby/domain/entities/response_entities/chat/message_response.dart';

// ignore_for_file: overridden_fields, annotate_overrides


class MessageResponseModel extends MessageResponse {

  final List<MessageModel> messages;

  const MessageResponseModel({
    required this.messages,
  }) : super(messages: messages);

  @override
  List<Object> get props => [messages];

  factory MessageResponseModel.fromJSON(Map<String, dynamic> json) =>
      MessageResponseModel(
        messages: (json['data']['rows'] as List<dynamic>)
            .map<MessageModel>((chat) => MessageModel.fromJson(chat))
            .toList(),
      );



}
