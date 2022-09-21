


import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/chat/chat.dart';
import 'package:loby/domain/entities/home/category.dart';

import '../../home/game.dart';

class ChatResponse extends Equatable {

  final List<Chat> chats;

  const ChatResponse({
    required this.chats,
  });

  @override
  List<Object> get props => [chats];
}
