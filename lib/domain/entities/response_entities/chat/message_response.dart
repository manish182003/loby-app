


import 'package:equatable/equatable.dart';

import 'package:loby/domain/entities/chat/chat.dart';
import 'package:loby/domain/entities/chat/message.dart';
import 'package:loby/domain/entities/home/category.dart';

import '../../home/game.dart';

class MessageResponse extends Equatable {

  final List<Message> messages;

  const MessageResponse({
    required this.messages,
  });

  @override
  List<Object> get props => [messages];
}
