import 'package:loby/data/models/response_models/home/category_games_response_model.dart';
import 'package:loby/data/models/response_models/home/category_response_model.dart';
import 'package:loby/data/models/response_models/home/faqs_data_response_model.dart';
import 'package:loby/data/models/response_models/home/game_response_model.dart';
import 'package:loby/data/models/response_models/home/notification_response_model.dart';

import '../models/response_models/home/global_search_response_model.dart';
import '../models/response_models/home/static_data_response_model.dart';

abstract class HomeRemoteDatasource {
  Future<CategoryResponseModel> getCategories(
      String? name, int? page, int? categoryId);

  Future<GameResponseModel> getGames(String? name, int? page, int? gameId);

  Future<CategoryGamesResponseModel> getCategoryGames(
      int? categoryId, String? search);

  Future<NotificationResponseModel> getNotifications(
      int? notificationId, int? page);

  Future<Map<String, dynamic>> deleteNotification(int? notificationId);

  Future<int> getUnreadCount(String? type);

  Future<GlobalSearchResponseModel> globalSearch(String? search);

  Future<StaticDataResponseModel> getStaticData();
  Future<FaqsDataResponseModel> getAllFaqs();
}
