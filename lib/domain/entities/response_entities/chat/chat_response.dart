


import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/chat/chat.dart';


class ChatResponse extends Equatable {

  final List<Chat> chats;

  const ChatResponse({
    required this.chats,
  });

  @override
  List<Object> get props => [chats];
}
