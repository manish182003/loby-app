import 'package:dartz/dartz.dart';
import 'package:loby/core/utils/exceptions.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/data/datasources/home_remote_datasource.dart';
import 'package:loby/domain/entities/response_entities/home/category_games_response.dart';
import 'package:loby/domain/entities/response_entities/home/category_response.dart';
import 'package:loby/domain/entities/response_entities/home/game_response.dart';
import 'package:loby/domain/entities/response_entities/home/global_search_response.dart';
import 'package:loby/domain/entities/response_entities/home/notification_response.dart';
import 'package:loby/domain/entities/response_entities/home/static_data_response.dart';
import 'package:loby/domain/entities/response_entities/order/order_response.dart';
import 'package:loby/domain/repositories/home_repository.dart';

import '../../domain/entities/response_entities/order/order_response.dart';

class HomeRepositoryImpl extends HomeRepository{

  final HomeRemoteDatasource _homeRemoteDatasource;

  HomeRepositoryImpl(this._homeRemoteDatasource);

  @override
  Future<Either<Failure, CategoryResponse>> getCategories({String? name, int? page, int? categoryId})async {
    try {
      return Right(await _homeRemoteDatasource.getCategories(name, page, categoryId));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, GameResponse>> getGames({String? name, int? page, int? gameId}) async{
    try {
      return Right(await _homeRemoteDatasource.getGames(name, page, gameId));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, CategoryGamesResponse>> getCategoryGames({int? categoryId,  String? search}) async{
    try {
      return Right(await _homeRemoteDatasource.getCategoryGames(categoryId, search));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }


  @override
  Future<Either<Failure, NotificationResponse>> getNotifications({int? notificationId, int? page})async {
    try {
      return Right(await _homeRemoteDatasource.getNotifications(notificationId, page));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> deleteNotification({int? notificationId})async {
    try {
      return Right(await _homeRemoteDatasource.deleteNotification(notificationId));
    } on ServerException catch (e) {
      // Loggers can be added here for analyzation.
      return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getUnreadCount({String? type})async {
    try {
      return Right(await _homeRemoteDatasource.getUnreadCount(type));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, GlobalSearchResponse>> globalSearch({String? search}) async{
    try {
      return Right(await _homeRemoteDatasource.globalSearch(search));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, StaticDataResponse>> getStaticData()async {
    try {
      return Right(await _homeRemoteDatasource.getStaticData());
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }


}