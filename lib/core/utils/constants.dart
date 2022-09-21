import 'environment.dart';

class ApiEndpoints{

  static String baseURL = Environment.apiBaseUrl;


  /// Auth APIs ///
  static const String signup = "/signup";
  static const String login = "/login";
  static const String socialLogin = "/social-login";
  static const String getCountries = "/get-country-list";
  static const String getStates = "/get-state-list";
  static const String getCities = "/get-city-list";
  static const String getProfileTags = "/get-profile-tags";
  static const String updateProfile = "/edit-user-profile";
  static const String checkUsername = "/check-user-name-availability";


  /// Home APIs ///
  static const String getCategories = "/get-all-categories";
  static const String getGames = "/get-all-games";
  static const String getCategoryGames = "/get-category-games";
  static const String getNotifications = "/get-notifications";
  static const String deleteNotification = "/delete-notification";
  static const String getUnreadNotificationCount = "/get-unread-notification-count";



  /// Order APIs ///
  static const String createOrder = "/create-user-order";
  static const String getOrders = "/get-all-user-order";
  static const String changeOrderStatus = "/change-order-status";
  static const String uploadDeliveryProof = "/add-delivery-proof";
  static const String submitRating = "/add-ratings";
  static const String selectDuelWinner = "/select-winner-duel";




  /// Listing APIs ///
  static const String getConfigurations = "/get-congfiguration";
  static const String createListing = "/create-listing-for-user-game-service";
  static const String getBuyerListings = "/get-all-game-service-listing-buyer";
  static const String reportListing = "/report-listing-user";


  /// Chat APIs ///
  static const String getChats = "/get-all-contacts";
  static const String getMessages = "/get-messages";
  static const String sendMessage = "/send-message";
  static const String getUnreadMessageCount = "/get-unread-message-count";



  /// Profile APIs ///
  static const String getProfile = "/user-profile";
  static const String getOtherProfile = "/user-profile-visible-to-other";
  static const String followUnfollow = "/follow-unfollow-user";
  static const String getRatings = "/get-all-ratings";
  static const String getDuel = "/get-duel-details";
  static const String addFunds = "/create-order-id";
  static const String verifyPayment = "/verify-payment";
  static const String updateSocialLinks = "/add-social-links";
  static const String profileVerification = "/request-profile-verification";
  static const String addBankDetails = "/add-bank-details-user";
  static const String getBankDetails = "/get-bank-details-user";
  static const String withdrawMoney = "/request-settlement";










}