import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/chat/chat_response.dart';
import 'package:loby/domain/entities/response_entities/chat/message_response.dart';

abstract class ChatRepository{
  Future<Either<Failure, ChatResponse>> getChats({String? name, int? page});

  Future<Either<Failure, MessageResponse>> getMessages({int? chatId});

  Future<Either<Failure, Map<String, dynamic>>> sendMessage({int? receiverId, String? message, int? fileType, File? file});

  Future<Either<Failure, Map<String, dynamic>>> checkEligibility({int? receiverId});


}