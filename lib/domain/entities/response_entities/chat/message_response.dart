


import 'package:equatable/equatable.dart';

import 'package:loby/domain/entities/chat/message.dart';


class MessageResponse extends Equatable {

  final List<Message> messages;

  const MessageResponse({
    required this.messages,
  });

  @override
  List<Object> get props => [messages];
}
