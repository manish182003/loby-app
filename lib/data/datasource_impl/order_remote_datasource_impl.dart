import 'dart:io';

import 'package:dio/dio.dart';
import 'package:loby/core/utils/constants.dart';
import 'package:loby/core/utils/exceptions.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/data/datasources/home_remote_datasource.dart';
import 'package:loby/data/models/response_models/home/category_games_response_model.dart';
import 'package:loby/data/models/response_models/home/category_response_model.dart';
import 'package:loby/data/models/response_models/home/game_response_model.dart';
import 'package:loby/data/models/response_models/home/notification_response_model.dart';
import 'package:loby/data/models/response_models/order/order_response_model.dart';

import '../datasources/order_remote_datasource.dart';

class OrderRemoteDatasourceImpl extends OrderRemoteDatasource{

  final Dio _dio;
  OrderRemoteDatasourceImpl(this._dio);


  @override
  Future<Map<String, dynamic>> createOrder(int? listingId, int? quantity, String? price)async {
    String token = await Helpers.getApiToken();
    final Map<String, dynamic> headers = {
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.createOrder,
        queryParams: {'user_game_service_id': "${listingId ?? ''}", 'quantity' : "${quantity ?? ''}", 'price' : price ?? '',},
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<OrderResponseModel> getOrders(int? orderId, String? status)async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getOrders,
        queryParams: {'user_order_id': "${orderId ?? ""}", 'status': status},
        headers: headers,
      );

      return OrderResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> changeOrderStatus(int? orderId, String? status) async{
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.changeOrderStatus,
        queryParams: {'user_order_id': "${orderId ?? ""}", 'status': status},
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> uploadDeliveryProof(int? orderId, List<int>? fileType, List<File>? file) async{
    try {

      print(orderId);
      print(fileType);
      print(file);

      final headers = await Helpers.getApiHeaders();

      FormData formData = FormData()
        ..fields.add(
          MapEntry('user_order_id', "${orderId ?? ''}"),
        );


      if(file != null) {
        formData.fields.add(MapEntry('type', "${fileType ?? ''}"));
        for (int i = 0; i < file.length; i++) {
          formData.files.add(MapEntry('file',
              MultipartFile.fromFileSync(file[i].path,
                // contentType: MediaType('image', 'jpg'),
              )));
        }
      }

      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.uploadDeliveryProof,
        data: formData,
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> submitRating(int? orderId, double? stars, String? review)async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.submitRating,
        queryParams: {'user_order_id': "${orderId ?? ""}", 'star': '${stars ?? ''}','comments' : review },
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> selectDuelWinner(int? winnerId, int? orderId)async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.selectDuelWinner,
        queryParams: {'winner_id': "${winnerId ?? ""}", 'user_order_id': "${orderId ?? ""}"},
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}