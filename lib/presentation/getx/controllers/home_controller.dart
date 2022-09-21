import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/core/usecases/home_params.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/home/category.dart';
import 'package:loby/domain/entities/home/category_games.dart';
import 'package:loby/domain/entities/home/game.dart';
import 'package:loby/domain/entities/home/notification.dart' as notification;
import 'package:loby/domain/entities/order/order.dart';
import 'package:loby/domain/usecases/order/create_order.dart';
import 'package:loby/domain/usecases/home/delete_notification.dart';
import 'package:loby/domain/usecases/home/get_categories.dart';
import 'package:loby/domain/usecases/home/get_category_games.dart';
import 'package:loby/domain/usecases/home/get_games.dart';
import 'package:loby/domain/usecases/home/get_notifications.dart';
import 'package:loby/domain/usecases/order/get_orders.dart';
import 'package:loby/domain/usecases/home/get_unread_count.dart';

class HomeController extends GetxController{
  final GetCategories _getCategories;
  final GetGames _getGames;
  final GetCategoryGames _getCategoryGames;
  final GetNotifications _getNotifications;
  final DeleteNotification _deleteNotification;
  final GetUnreadCount _getUnreadCount;

  HomeController({
    required GetCategories getCategories,
    required GetGames getGames,
    required GetCategoryGames getCategoryGames,
    required GetNotifications getNotifications,
    required DeleteNotification deleteNotification,
    required GetUnreadCount getUnreadCount,
  }) : _getCategories = getCategories,
      _getGames = getGames,
        _getCategoryGames = getCategoryGames,
  _getNotifications = getNotifications,
  _deleteNotification = deleteNotification,
  _getUnreadCount = getUnreadCount;

  final categories = <Category>[].obs;
  final isCategoryFetching = false.obs;
  final disclaimer = ''.obs;

  final games = <Game>[].obs;
  final isGamesFetching = false.obs;

  final categoryGames = <CategoryGames>[].obs;
  final isCategoryGamesFetching = false.obs;

  final profileSelectedOptionIndex = 0.obs;

  final selectedCategoryName = TextEditingController().obs;
  final selectedGameName = TextEditingController().obs;

  final selectedCategoryId = 0.obs;
  final selectedGameId = 0.obs;

  final orders = <Order>[].obs;
  final isOrdersFetching = false.obs;

  final notifications = <notification.Notification>[].obs;
  final isNotificationFetching = false.obs;
  final notificationPageNumber = 1.obs;

  final chatCount = 0.obs;
  final notificationCount = 0.obs;



  final errorMessage = ''.obs;

  Future<bool> getCategories({String? name, int? page, int? categoryId}) async {
    isCategoryFetching(true);

    final failureOrSuccess = await _getCategories(
      Params(homeParams: HomeParams(
        name: name,
        page: page,
        categoryId: categoryId,
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
        isCategoryFetching(false);
      },
          (success) {
        categories.value = success.categories;
        isCategoryFetching(false);

      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }

  Future<bool> getGames({String? name, int? page, int? gameId}) async {
    isGamesFetching(true);

    final failureOrSuccess = await _getGames(
      Params(homeParams: HomeParams(
        name: name,
        page: page,
        gameId: gameId,
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
        isGamesFetching(false);


      },
          (success) {

        games.value = success.games;
        isGamesFetching(false);

      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }

  Future<bool> getCategoryGames({int? categoryId, String? search}) async {
    isCategoryGamesFetching(true);

    final failureOrSuccess = await _getCategoryGames(
      Params(homeParams: HomeParams(
        categoryId: categoryId,
            search: search
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
        isCategoryGamesFetching(false);

      },
          (success) {
            categoryGames.value = success.categoryGames.categoryGames!;
        isCategoryGamesFetching(false);

      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }


  Future<bool> getNotifications({int? notificationId}) async {
    isNotificationFetching(true);
    final failureOrSuccess = await _getNotifications(
      Params(homeParams: HomeParams(
        page: notificationPageNumber.value,
        notificationId: notificationId
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
        isNotificationFetching(false);
      },
          (success) {
        notifications.value = success.notifications;
        isNotificationFetching(false);
        // Helpers.toast('Profile Changed');
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }


  Future<bool> deleteNotification({int? notificationId}) async {
    final failureOrSuccess = await _deleteNotification(
      Params(homeParams: HomeParams(
          notificationId: notificationId
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {

        // Helpers.toast('Profile Changed');
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }

  Future<bool> getUnreadCount({String? type}) async {
    final failureOrSuccess = await _getUnreadCount(
      Params(homeParams: HomeParams(
          type: type
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {

            if(type == 'chat'){
              chatCount.value = success;
            }else{
              notificationCount.value = success;
            }

        // Helpers.toast('Profile Changed');
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }






}