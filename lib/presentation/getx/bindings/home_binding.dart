import 'package:get/get.dart';
import 'package:loby/domain/usecases/auth/get_cities.dart';
import 'package:loby/domain/usecases/auth/get_countries.dart';
import 'package:loby/domain/usecases/auth/get_profile_tags.dart';
import 'package:loby/domain/usecases/auth/get_states.dart';
import 'package:loby/domain/usecases/auth/signup.dart';
import 'package:loby/domain/usecases/auth/update_profile.dart';
import 'package:loby/domain/usecases/home/delete_notification.dart';
import 'package:loby/domain/usecases/home/get_categories.dart';
import 'package:loby/domain/usecases/home/get_category_games.dart';
import 'package:loby/domain/usecases/home/get_games.dart';
import 'package:loby/domain/usecases/home/get_notifications.dart';
import 'package:loby/domain/usecases/home/get_unread_count.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';
import 'package:loby/presentation/getx/controllers/home_controller.dart';

class HomeBinding extends Bindings {

  @override
  void dependencies() {

    final getCategories = Get.find<GetCategories>();
    final getGames = Get.find<GetGames>();
    final getCategoryGames = Get.find<GetCategoryGames>();
    final getNotifications = Get.find<GetNotifications>();
    final deleteNotification = Get.find<DeleteNotification>();
    final getUnreadCount = Get.find<GetUnreadCount>();



    Get.lazyPut(() => HomeController(
      getCategories: getCategories,
      getGames: getGames,
      getCategoryGames: getCategoryGames,
      getNotifications: getNotifications,
      deleteNotification: deleteNotification,
      getUnreadCount: getUnreadCount,
    ));
  }

}