import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loby/core/utils/constants.dart';
import 'package:loby/data/datasource_impl/auth_remote_datasource_impl.dart';
import 'package:loby/data/datasource_impl/chat_remote_datasource_impl.dart';
import 'package:loby/data/datasource_impl/home_remote_datasource_impl.dart';
import 'package:loby/data/datasource_impl/listing_remote_datasource_impl.dart';
import 'package:loby/data/datasource_impl/profile_remote_datasource_impl.dart';
import 'package:loby/data/datasources/auth_remote_datasource.dart';
import 'package:loby/data/datasources/chat_remote_datasource.dart';
import 'package:loby/data/datasources/home_remote_datasource.dart';
import 'package:loby/data/datasources/listing_remote_datasource.dart';
import 'package:loby/data/datasources/order_remote_datasource.dart';
import 'package:loby/data/datasources/profile_remote_datasource.dart';
import 'package:loby/data/repositories/auth_repository_impl.dart';
import 'package:loby/data/repositories/chat_repository_impl.dart';
import 'package:loby/data/repositories/home_repsitory_impl.dart';
import 'package:loby/data/repositories/listing_repository_impl.dart';
import 'package:loby/data/repositories/profile_repository_impl.dart';
import 'package:loby/domain/repositories/auth_repository.dart';
import 'package:loby/domain/repositories/chat_repository.dart';
import 'package:loby/domain/repositories/home_repository.dart';
import 'package:loby/domain/repositories/listing_repository.dart';
import 'package:loby/domain/repositories/order_repository.dart';
import 'package:loby/domain/repositories/profile_repository.dart';
import 'package:loby/domain/usecases/auth/add_fcm_token.dart';
import 'package:loby/domain/usecases/auth/check_username.dart';
import 'package:loby/domain/usecases/auth/get_cities.dart';
import 'package:loby/domain/usecases/auth/get_countries.dart';
import 'package:loby/domain/usecases/auth/get_profile_tags.dart';
import 'package:loby/domain/usecases/auth/get_states.dart';
import 'package:loby/domain/usecases/auth/login.dart';
import 'package:loby/domain/usecases/auth/signup.dart';
import 'package:loby/domain/usecases/auth/update_profile.dart';
import 'package:loby/domain/usecases/chat/get_chats.dart';
import 'package:loby/domain/usecases/chat/get_messages.dart';
import 'package:loby/domain/usecases/chat/send_message.dart';
import 'package:loby/domain/usecases/home/get_static_data.dart';
import 'package:loby/domain/usecases/home/global_search.dart';
import 'package:loby/domain/usecases/order/change_order_status.dart';
import 'package:loby/domain/usecases/order/create_order.dart';
import 'package:loby/domain/usecases/order/get_disputes.dart';
import 'package:loby/domain/usecases/order/get_orders.dart';
import 'package:loby/domain/usecases/order/create_order.dart';
import 'package:loby/domain/usecases/home/delete_notification.dart';
import 'package:loby/domain/usecases/home/get_categories.dart';
import 'package:loby/domain/usecases/home/get_category_games.dart';
import 'package:loby/domain/usecases/home/get_games.dart';
import 'package:loby/domain/usecases/home/get_notifications.dart';
import 'package:loby/domain/usecases/order/get_orders.dart';
import 'package:loby/domain/usecases/home/get_unread_count.dart';
import 'package:loby/domain/usecases/listing/create_listing.dart';
import 'package:loby/domain/usecases/listing/get_buyer_listings.dart';
import 'package:loby/domain/usecases/listing/get_configurations.dart';
import 'package:loby/domain/usecases/listing/report_listing.dart';
import 'package:loby/domain/usecases/order/raise_dispute.dart';
import 'package:loby/domain/usecases/order/select_duel_winner.dart';
import 'package:loby/domain/usecases/order/submit_dispute_proof.dart';
import 'package:loby/domain/usecases/order/submit_rating.dart';
import 'package:loby/domain/usecases/order/upload_delivery_proof.dart';
import 'package:loby/domain/usecases/profile/add_bank_details.dart';
import 'package:loby/domain/usecases/profile/add_funds.dart';
import 'package:loby/domain/usecases/profile/follow_unfollow.dart';
import 'package:loby/domain/usecases/profile/get_bank_details.dart';
import 'package:loby/domain/usecases/profile/get_duel.dart';
import 'package:loby/domain/usecases/profile/get_followers.dart';
import 'package:loby/domain/usecases/profile/get_payment_transactions.dart';
import 'package:loby/domain/usecases/profile/get_profile.dart';
import 'package:loby/domain/usecases/profile/get_ratings.dart';
import 'package:loby/domain/usecases/profile/profile_verification.dart';
import 'package:loby/domain/usecases/profile/submit_feedback.dart';
import 'package:loby/domain/usecases/profile/update_social_links.dart';
import 'package:loby/domain/usecases/profile/verify_payment.dart';
import 'package:loby/domain/usecases/profile/withdraw_money.dart';
import 'package:loby/presentation/getx/bindings/auth_binding.dart';
import 'package:loby/presentation/getx/bindings/chat_binding.dart';
import 'package:loby/presentation/getx/bindings/core_binding.dart';
import 'package:loby/presentation/getx/bindings/home_binding.dart';
import 'package:loby/presentation/getx/bindings/listing_binding.dart';
import 'package:loby/presentation/getx/bindings/order_binding.dart';
import 'package:loby/presentation/getx/bindings/profile_binding.dart';

import '../data/datasource_impl/order_remote_datasource_impl.dart';
import '../data/repositories/order_repository_impl.dart';
import '../domain/usecases/listing/change_listing_status.dart';
import '../domain/usecases/profile/get_wallet_transactions.dart';

class DependencyInjector{

  static void inject() {
    _injectExternalDependencies();
    _injectDataSources();
    _injectRepositories();
    _injectAuthUsecases();
    _injectHomeUsecases();
    _injectListingUsecases();
    _injectOrderUsecases();
    _injectChatUsecases();
    _injectProfileUsecases();


    AuthBinding().dependencies();
    HomeBinding().dependencies();
    ListingBinding().dependencies();
    OrderBinding().dependencies();
    ChatBinding().dependencies();
    ProfileBinding().dependencies();
    CoreBinding().dependencies();
  }


  static void _injectExternalDependencies() {
    final dio = Dio(
      BaseOptions(baseUrl: ApiEndpoints.baseURL),
    );
    Get.lazyPut<Dio>(() => dio);
  }


  static void _injectDataSources() {
    final dio = Get.find<Dio>();
    Get.lazyPut<AuthRemoteDatasource>(() => AuthRemoteDatasourceImpl(dio));
    Get.lazyPut<HomeRemoteDatasource>(() => HomeRemoteDatasourceImpl(dio));
    Get.lazyPut<ListingRemoteDatasource>(() => ListingRemoteDatasourceImpl(dio));
    Get.lazyPut<OrderRemoteDatasource>(() => OrderRemoteDatasourceImpl(dio));
    Get.lazyPut<ChatRemoteDatasource>(() => ChatRemoteDatasourceImpl(dio));
    Get.lazyPut<ProfileRemoteDatasource>(() => ProfileRemoteDatasourceImpl(dio));

  }

  static void _injectRepositories() {

    final authDatasource = Get.find<AuthRemoteDatasource>();
    final homeDatasource = Get.find<HomeRemoteDatasource>();
    final listingDatasource = Get.find<ListingRemoteDatasource>();
    final orderDatasource = Get.find<OrderRemoteDatasource>();
    final chatDatasource = Get.find<ChatRemoteDatasource>();
    final profileDatasource = Get.find<ProfileRemoteDatasource>();

    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(authDatasource));
    Get.lazyPut<HomeRepository>(() => HomeRepositoryImpl(homeDatasource));
    Get.lazyPut<ListingRepository>(() => ListingRepositoryImpl(listingDatasource));
    Get.lazyPut<OrderRepository>(() => OrderRepositoryImpl(orderDatasource));
    Get.lazyPut<ChatRepository>(() => ChatRepositoryImpl(chatDatasource));
    Get.lazyPut<ProfileRepository>(() => ProfileRepositoryImpl(profileDatasource));
  }

  static void _injectAuthUsecases() {
    final authRepository = Get.find<AuthRepository>();

    Get.lazyPut(() => Signup(authRepository));
    Get.lazyPut(() => Login(authRepository));
    Get.lazyPut(() => GetCountries(authRepository));
    Get.lazyPut(() => GetStates(authRepository));
    Get.lazyPut(() => GetCities(authRepository));
    Get.lazyPut(() => GetProfileTags(authRepository));
    Get.lazyPut(() => UpdateProfile(authRepository));
    Get.lazyPut(() => CheckUsername(authRepository));
    Get.lazyPut(() => AddFCMToken(authRepository));

  }

  static void _injectHomeUsecases() {
    final homeRepository = Get.find<HomeRepository>();

    Get.lazyPut(() => GetCategories(homeRepository));
    Get.lazyPut(() => GetGames(homeRepository));
    Get.lazyPut(() => GetCategoryGames(homeRepository));
    Get.lazyPut(() => GetNotifications(homeRepository));
    Get.lazyPut(() => DeleteNotification(homeRepository));
    Get.lazyPut(() => GetUnreadCount(homeRepository));
    Get.lazyPut(() => GlobalSearch(homeRepository));
    Get.lazyPut(() => GetStaticData(homeRepository));

  }

  static void _injectListingUsecases() {
    final listingRepository = Get.find<ListingRepository>();

    Get.lazyPut(() => GetConfigurations(listingRepository));
    Get.lazyPut(() => CreateListing(listingRepository));
    Get.lazyPut(() => GetBuyerListings(listingRepository));
    Get.lazyPut(() => ReportListing(listingRepository));
    Get.lazyPut(() => ChangeListingStatus(listingRepository));
  }


  static void _injectChatUsecases() {
    final chatRepository = Get.find<ChatRepository>();

    Get.lazyPut(() => GetChats(chatRepository));
    Get.lazyPut(() => GetMessages(chatRepository));
    Get.lazyPut(() => SendMessage(chatRepository));

  }

  static void _injectOrderUsecases() {
    final orderRepository = Get.find<OrderRepository>();

    Get.lazyPut(() => CreateOrder(orderRepository));
    Get.lazyPut(() => GetOrders(orderRepository));
    Get.lazyPut(() => ChangeOrderStatus(orderRepository));
    Get.lazyPut(() => UploadDeliveryProof(orderRepository));
    Get.lazyPut(() => SubmitRating(orderRepository));
    Get.lazyPut(() => SelectDuelWinner(orderRepository));
    Get.lazyPut(() => RaiseDispute(orderRepository));
    Get.lazyPut(() => GetDisputes(orderRepository));
    Get.lazyPut(() => SubmitDisputeProof(orderRepository));

  }

  static void _injectProfileUsecases() {
    final profileRepository = Get.find<ProfileRepository>();

    Get.lazyPut(() => GetProfile(profileRepository));
    Get.lazyPut(() => GetRatings(profileRepository));
    Get.lazyPut(() => GetDuel(profileRepository));
    Get.lazyPut(() => AddFunds(profileRepository));
    Get.lazyPut(() => VerifyPayment(profileRepository));
    Get.lazyPut(() => FollowUnfollow(profileRepository));
    Get.lazyPut(() => UpdateSocialLinks(profileRepository));
    Get.lazyPut(() => ProfileVerification(profileRepository));
    Get.lazyPut(() => AddBankDetails(profileRepository));
    Get.lazyPut(() => GetBankDetails(profileRepository));
    Get.lazyPut(() => WithdrawMoney(profileRepository));
    Get.lazyPut(() => GetWalletTransactions(profileRepository));
    Get.lazyPut(() => GetPaymentTransactions(profileRepository));
    Get.lazyPut(() => GetFollowers(profileRepository));
    Get.lazyPut(() => SubmitFeedback(profileRepository));
  }

}