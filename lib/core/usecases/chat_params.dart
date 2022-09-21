import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ChatParams extends Equatable {
  final String? name;
  final int? chatId;
  final int? receiverId;
  final String? message;
  final int? fileType;
  final File? file;



  const ChatParams({
    this.name,
    this.chatId,
    this.receiverId,
    this.message,
    this.fileType,
    this.file,
  });

  @override
  List<Object> get props => [];
}
