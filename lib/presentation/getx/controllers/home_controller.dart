import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/core/usecases/home_params.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/home/category.dart';
import 'package:loby/domain/entities/home/category_games.dart';
import 'package:loby/domain/entities/home/game.dart';
import 'package:loby/domain/entities/home/notification.dart' as notification;
import 'package:loby/domain/entities/home/static_data.dart';
import 'package:loby/domain/entities/listing/service_listing.dart';
import 'package:loby/domain/entities/profile/user.dart';
import 'package:loby/domain/usecases/home/delete_notification.dart';
import 'package:loby/domain/usecases/home/get_categories.dart';
import 'package:loby/domain/usecases/home/get_category_games.dart';
import 'package:loby/domain/usecases/home/get_games.dart';
import 'package:loby/domain/usecases/home/get_notifications.dart';
import 'package:loby/domain/usecases/home/get_unread_count.dart';
import 'package:loby/presentation/getx/controllers/listing_controller.dart';

import '../../../domain/usecases/home/get_static_data.dart';
import '../../../domain/usecases/home/global_search.dart';

class HomeController extends GetxController{
  final GetCategories _getCategories;
  final GetGames _getGames;
  final GetCategoryGames _getCategoryGames;
  final GetNotifications _getNotifications;
  final DeleteNotification _deleteNotification;
  final GetUnreadCount _getUnreadCount;
  final GlobalSearch _globalSearch;
  final GetStaticData _getStaticData;

  HomeController({
    required GetCategories getCategories,
    required GetGames getGames,
    required GetCategoryGames getCategoryGames,
    required GetNotifications getNotifications,
    required DeleteNotification deleteNotification,
    required GetUnreadCount getUnreadCount,
    required GlobalSearch globalSearch,
    required GetStaticData getStaticData,
  }) : _getCategories = getCategories,
      _getGames = getGames,
        _getCategoryGames = getCategoryGames,
  _getNotifications = getNotifications,
  _deleteNotification = deleteNotification,
  _getUnreadCount = getUnreadCount,
        _globalSearch = globalSearch,
  _getStaticData = getStaticData;

  ListingController listingController = Get.find<ListingController>();

  final categories = <Category>[].obs;
  final isCategoryFetching = false.obs;
  final disclaimer = ''.obs;

  final games = <Game>[].obs;
  final isGamesFetching = false.obs;


  final categoryGames = <CategoryGames>[].obs;
  final isCategoryGamesFetching = false.obs;
  final areMoreCategoryGamesAvailable = true.obs;
  final categoriesGamePageNumber = 1.obs;

  final profileSelectedOptionIndex = 0.obs;

  final selectedCategoryName = TextEditingController().obs;
  final selectedGameName = TextEditingController().obs;

  final selectedCategoryId = 0.obs;
  final selectedGameId = 0.obs;


  final notifications = <notification.Notification>[].obs;
  final isNotificationFetching = false.obs;
  final areMoreNotificationAvailable = true.obs;
  final notificationPageNumber = 1.obs;

  final chatCount = 0.obs;
  final notificationCount = 0.obs;

  final isGlobalSearchFetching = false.obs;
  final serviceListingResults = <ServiceListing>[].obs;
  final userResults = <User>[].obs;
  final gameResults = <Game>[].obs;


  final staticData = <StaticData>[].obs;
  final isStaticDataFetching = false.obs;




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
    // categoriesGamePageNumber.value == 1 ? isCategoryGamesFetching(true) : isCategoryGamesFetching(false);

    isCategoryGamesFetching(true);

    if(areMoreCategoryGamesAvailable.value){
      final failureOrSuccess = await _getCategoryGames(
        Params(homeParams: HomeParams(
            categoryId: categoryId,
            search: search,
            page: categoriesGamePageNumber.value
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
          categoryGames.value = success.categoryGames.categoryGames ?? [];
          isCategoryGamesFetching(false);

        },
      );
      return failureOrSuccess.isRight() ? true : false;
    }
    return false;
  }


  Future<bool> getNotifications({int? notificationId}) async {
    notificationPageNumber.value == 1 ? isNotificationFetching(true) : isNotificationFetching(false);

    if(areMoreNotificationAvailable.value){
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
              areMoreNotificationAvailable.value = success.notifications.length == 10;

              if (notificationPageNumber > 1) {
                notifications.addAll(success.notifications);
              } else {
                notifications.value = success.notifications;
              }

              notificationPageNumber.value++;

              isNotificationFetching.value = false;
          // Helpers.toast('Profile Changed');
        },
      );
      return failureOrSuccess.isRight() ? true : false;
    }
    return false;
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
        Helpers.toast("Something Went Wrong in $type Api");
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




  Future<bool> globalSearch({required String search}) async {
    isGlobalSearchFetching(true);
    final failureOrSuccess = await _globalSearch(
      Params(homeParams: HomeParams(
          search: search,
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
        isGlobalSearchFetching(false);
      },
          (success) {
            listingController.buyerListings.value = success.userGameServiceDetails;
            serviceListingResults.value = success.userGameServiceDetails;
            userResults.value = success.userDetails;
            gameResults.value = success.gameDetails;
            isGlobalSearchFetching(false);
        // Helpers.toast('Profile Changed');
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }



  Future<bool> getStaticData() async {
    isStaticDataFetching(true);
    final failureOrSuccess = await _getStaticData(
      const Params(homeParams: HomeParams(

      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
        isStaticDataFetching(false);
      },
          (success) {
            staticData.value = success.staticData;
            isStaticDataFetching(false);

        // Helpers.toast('Profile Changed');
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }





}