import 'package:dartz/dartz.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/home/category_games_response.dart';
import 'package:loby/domain/entities/response_entities/home/category_response.dart';
import 'package:loby/domain/entities/response_entities/home/game_response.dart';
import 'package:loby/domain/entities/response_entities/order/order_response.dart';

import '../entities/response_entities/home/global_search_response.dart';
import '../entities/response_entities/home/notification_response.dart';


abstract class HomeRepository{
  Future<Either<Failure, CategoryResponse>> getCategories({String? name, int? page, int? categoryId});

  Future<Either<Failure, GameResponse>> getGames({String? name, int? page, int? gameId});

  Future<Either<Failure, CategoryGamesResponse>> getCategoryGames({int? categoryId, String? search});

  Future<Either<Failure, NotificationResponse>> getNotifications({int? notificationId, int? page});

  Future<Either<Failure, Map<String, dynamic>>> deleteNotification({int? notificationId});

  Future<Either<Failure, int>> getUnreadCount({String? type});


  Future<Either<Failure, GlobalSearchResponse>> globalSearch({String? search});


}