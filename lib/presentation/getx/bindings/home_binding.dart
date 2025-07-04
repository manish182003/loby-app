import 'package:get/get.dart';
import 'package:loby/domain/usecases/home/delete_notification.dart';
import 'package:loby/domain/usecases/home/get_all_banners.dart';
import 'package:loby/domain/usecases/home/get_all_faqs.dart';
import 'package:loby/domain/usecases/home/get_categories.dart';
import 'package:loby/domain/usecases/home/get_category_games.dart';
import 'package:loby/domain/usecases/home/get_games.dart';
import 'package:loby/domain/usecases/home/get_notifications.dart';
import 'package:loby/domain/usecases/home/get_static_data.dart';
import 'package:loby/domain/usecases/home/get_unread_count.dart';
import 'package:loby/domain/usecases/home/global_search.dart';
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
    final globalSearch = Get.find<GlobalSearch>();
    final getStaticData = Get.find<GetStaticData>();
    final getFaqs = Get.find<GetAllFaqs>();
    final getBanners = Get.find<GetAllBanners>();

    Get.lazyPut(() => HomeController(
          getCategories: getCategories,
          getGames: getGames,
          getCategoryGames: getCategoryGames,
          getNotifications: getNotifications,
          deleteNotification: deleteNotification,
          getUnreadCount: getUnreadCount,
          globalSearch: globalSearch,
          getStaticData: getStaticData,
          getAllFaqs: getFaqs,
          getAllBanners: getBanners,
        ));
  }
}
