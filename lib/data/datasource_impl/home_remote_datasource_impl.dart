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

class HomeRemoteDatasourceImpl extends HomeRemoteDatasource{

  final Dio _dio;
  HomeRemoteDatasourceImpl(this._dio);

  @override
  Future<CategoryResponseModel> getCategories(String? name, int? page, int? categoryId)async {
    try {
      String token = await Helpers.getApiToken();
      final Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };

      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getCategories,
        queryParams: {'name': name, 'page' : '${page ?? ''}', 'catgeory_id': '${categoryId ?? ''}'},
        headers: headers,
      );

      return CategoryResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<GameResponseModel> getGames(String? name, int? page, int? gameId) async{
    try {
      String token = await Helpers.getApiToken();
      final Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };



      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getGames,
        // queryParams: {'name': name, 'page' : '${page ?? ''}', 'catgeory_id': '${categoryId ?? ''}'},
        headers: headers,
      );

      return GameResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<CategoryGamesResponseModel> getCategoryGames(int? categoryId, String? search)async {
    try {
      String token = await Helpers.getApiToken();
      final Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };


      print("categpry $categoryId");

      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getCategoryGames,
        queryParams: {'catgeory_id': '$categoryId', 'name' : search},
        headers: headers,
      );

      return CategoryGamesResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

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
  Future<NotificationResponseModel> getNotifications(int? notificationId, int? page)async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getNotifications,
        queryParams: {'notification_id': "${notificationId ?? ""}", 'page': "${page ?? ""}"},
        headers: headers,
      );

      return NotificationResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> deleteNotification(int? notificationId)async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.delete,
        ApiEndpoints.deleteNotification,
        queryParams: {'id': "${notificationId ?? ""}"},
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<int> getUnreadCount(String? type) async{
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        type == 'chat' ? ApiEndpoints.getUnreadMessageCount : ApiEndpoints.getUnreadNotificationCount,
        // queryParams: {'id': "${notificationId ?? ""}"},
        headers: headers,
      );

      return response!["data"] ?? 0;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}