import 'package:dio/dio.dart';
import 'package:loby/core/utils/constants.dart';
import 'package:loby/core/utils/exceptions.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/data/datasources/home_remote_datasource.dart';
import 'package:loby/data/models/response_models/home/category_games_response_model.dart';
import 'package:loby/data/models/response_models/home/category_response_model.dart';
import 'package:loby/data/models/response_models/home/faqs_data_response_model.dart';
import 'package:loby/data/models/response_models/home/game_response_model.dart';
import 'package:loby/data/models/response_models/home/global_search_response_model.dart';
import 'package:loby/data/models/response_models/home/notification_response_model.dart';
import 'package:loby/data/models/response_models/home/static_data_response_model.dart';
import 'package:loby/data/models/response_models/order/order_response_model.dart';

class HomeRemoteDatasourceImpl extends HomeRemoteDatasource {
  final Dio _dio;
  HomeRemoteDatasourceImpl(this._dio);

  @override
  Future<CategoryResponseModel> getCategories(
      String? name, int? page, int? categoryId) async {
    try {
      String token = await Helpers.getApiToken();
      final Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };

      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getCategories,
        extra: {
          'name': name,
          'page': '${page ?? ''}',
          'catgeory_id': '${categoryId ?? ''}'
        },
        headers: headers,
      );

      return CategoryResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<GameResponseModel> getGames(
      String? name, int? page, int? gameId) async {
    try {
      String token = await Helpers.getApiToken();
      final Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };

      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getGames,
        extra: {'name': name, 'page': '${page ?? ''}'},
        headers: headers,
      );

      return GameResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<CategoryGamesResponseModel> getCategoryGames(
      int? categoryId, String? search) async {
    try {
      String token = await Helpers.getApiToken();
      final Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };

      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getCategoryGames,
        extra: {'catgeory_id': '$categoryId', 'name': search},
        headers: headers,
      );

      return CategoryGamesResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  Future<Map<String, dynamic>> createOrder(
      int? listingId, int? quantity, String? price) async {
    String token = await Helpers.getApiToken();
    final Map<String, dynamic> headers = {
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.createOrder,
        extra: {
          'user_game_service_id': "${listingId ?? ''}",
          'quantity': "${quantity ?? ''}",
          'price': price ?? '',
        },
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  Future<OrderResponseModel> getOrders(int? orderId, String? status) async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getOrders,
        extra: {'user_order_id': "${orderId ?? ""}", 'status': status},
        headers: headers,
      );

      return OrderResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<NotificationResponseModel> getNotifications(
      int? notificationId, int? page) async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getNotifications,
        extra: {
          'notification_id': "${notificationId ?? ""}",
          'page': "${page ?? ""}"
        },
        headers: headers,
      );

      return NotificationResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> deleteNotification(int? notificationId) async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.delete,
        ApiEndpoints.deleteNotification,
        extra: {'id': "${notificationId ?? ""}"},
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<int> getUnreadCount(String? type) async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        type == 'chat'
            ? ApiEndpoints.getUnreadMessageCount
            : ApiEndpoints.getUnreadNotificationCount,
        // extra: {'id': "${notificationId ?? ""}"},
        headers: headers,
      );

      return response!["data"] ?? 0;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<GlobalSearchResponseModel> globalSearch(String? search) async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getBuyerListings,
        extra: {'search_all': search ?? ''},
        headers: headers,
      );

      return GlobalSearchResponseModel.fromJson(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<StaticDataResponseModel> getStaticData() async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getStaticData,
        headers: headers,
      );

      return StaticDataResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<FaqsDataResponseModel> getAllFaqs() async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getAllFaqsData,
        headers: headers,
      );
      return FaqsDataResponseModel.fromJson(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
