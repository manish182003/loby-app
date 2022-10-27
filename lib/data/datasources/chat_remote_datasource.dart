import 'dart:io';

import 'package:loby/data/models/response_models/chat/chat_response_model.dart';
import 'package:loby/data/models/response_models/chat/message_response_model.dart';
import 'package:loby/domain/entities/response_entities/chat/message_response.dart';

abstract class ChatRemoteDatasource{

  Future<ChatResponseModel> getChats(String? name, int? page);

  Future<MessageResponseModel> getMessages(int? chatId);

  Future<Map<String, dynamic>> sendMessage(int? receiverId, String? message, int? fileType, File? file);

  Future<Map<String, dynamic>> checkEligibility(int? receiverId);

}