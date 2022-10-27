import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:loby/core/utils/exceptions.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/data/datasources/chat_remote_datasource.dart';
import 'package:loby/data/models/response_models/chat/message_response_model.dart';
import 'package:loby/domain/entities/response_entities/chat/chat_response.dart';
import 'package:loby/domain/entities/response_entities/chat/message_response.dart';
import 'package:loby/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl extends ChatRepository{

  final ChatRemoteDatasource _chatRemoteDatasource;

  ChatRepositoryImpl(this._chatRemoteDatasource);

  @override
  Future<Either<Failure, ChatResponse>> getChats({String? name, int? page}) async{
    try {
      return Right(await _chatRemoteDatasource.getChats(name, page));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, MessageResponseModel>> getMessages({int? chatId}) async{
    try {
      return Right(await _chatRemoteDatasource.getMessages(chatId));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> sendMessage({int? receiverId, String? message, int? fileType, File? file}) async{
    try {
      return Right(await _chatRemoteDatasource.sendMessage(receiverId, message, fileType, file));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> checkEligibility({int? receiverId}) async{
    try {
      return Right(await _chatRemoteDatasource.checkEligibility(receiverId));
    } on ServerException catch (e) {
      // Loggers can be added here for analyzation.
      return Left(ServerFailure(message: e.message.toString()));
    }
  }




}