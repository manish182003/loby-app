import 'package:loby/data/models/chat/chat_model.dart';
import 'package:loby/domain/entities/chat/chat.dart';
import 'package:loby/domain/entities/response_entities/chat/chat_response.dart';

// ignore_for_file: overridden_fields, annotate_overrides


class ChatResponseModel extends ChatResponse {

  final List<Chat> chats;

  const ChatResponseModel({
    required this.chats,
  }) : super(chats: chats);

  @override
  List<Object> get props => [chats];

  factory ChatResponseModel.fromJSON(Map<String, dynamic> json) =>
      ChatResponseModel(
        chats: (json['data'] as List<dynamic>)
            .map<ChatModel>((chat) => ChatModel.fromJson(chat))
            .toList(),
      );
}
