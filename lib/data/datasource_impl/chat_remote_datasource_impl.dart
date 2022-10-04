import 'dart:io';

import 'package:dio/dio.dart';
import 'package:loby/core/utils/constants.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/data/models/response_models/chat/chat_response_model.dart';
import 'package:loby/data/models/response_models/chat/message_response_model.dart';
import '../../core/utils/exceptions.dart';
import '../datasources/chat_remote_datasource.dart';

class ChatRemoteDatasourceImpl extends ChatRemoteDatasource{

  final Dio _dio;
  ChatRemoteDatasourceImpl(this._dio);

  @override
  Future<ChatResponseModel> getChats(String? name, int? page)async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getChats,
        queryParams: {'name': name, 'page' : '${page ?? ''}'},
        headers: headers,
      );

      return ChatResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<MessageResponseModel> getMessages(int? chatId) async{
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getMessages,
        queryParams: {'chat_channel_id': chatId, 'sortBy' : 'DESC'},
        headers: headers,
      );

      return MessageResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> sendMessage(int? receiverId, String? message, int? fileType, File? file) async{
    try {

      print(receiverId);
      print(message);
      print(file);
      print(fileType);


      final headers = await Helpers.getApiHeaders();

      FormData formData = FormData()
        ..fields.add(
          MapEntry('receiver_id', "$receiverId"),
        );

        if(message != null){
          formData.fields.add(
            MapEntry('message', message),
          );
        }

      if(file != null && file.path.isNotEmpty) {
        formData.files.add(MapEntry('file_path',
            MultipartFile.fromFileSync(file.path)));

        formData.fields.add(
          MapEntry('file_type', "${fileType ?? ""}"),
        );
      }

      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.sendMessage,
        data: formData,
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }






}