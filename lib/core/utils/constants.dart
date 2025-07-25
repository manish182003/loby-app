import 'environment.dart';

class ApiEndpoints {
  static String baseURL = Environment.apiBaseUrl;

  /// Auth APIs ///
  static const String signup = "/signup";
  static const String login = "/loginV2";
  static const String delete = "/delete-account-user-side";
  static const String socialLogin = "/social-login";
  static const String getCountries = "/get-country-list";
  static const String getStates = "/get-state-list";
  static const String getCities = "/get-city-list";
  static const String getProfileTags = "/get-profile-tags";
  static const String updateProfile = "/edit-user-profile";
  static const String checkUsername = "/check-user-name-availability";
  static const String addFCMToken = "/add-user-fcm-token";
  static const String sendOTP = "/send-otp-email";
  static const String verifyOTP = "/verify-otp";
  static const String forgotPassword = "/forgot-password";
  static const String resetPassword = "/reset-password";

  /// Home APIs ///
  static const String getCategories = "/get-all-categories";
  static const String getGames = "/get-all-games";
  static const String getCategoryGames = "/get-category-games";
  static const String getNotifications = "/get-notifications";
  static const String deleteNotification = "/delete-notification";
  static const String getUnreadNotificationCount =
      "/get-unread-notification-count";
  static const String getStaticData = "/get-static-content";
  static const String getAllFaqsData = "/get-static-faqs";
  static const String getAllbanners = "/get-dashboard-banners";

  /// Order APIs ///
  static const String createOrder = "/create-user-order";
  static const String getOrders = "/get-all-user-order";
  static const String changeOrderStatus = "/change-order-status";
  static const String uploadDeliveryProof = "/add-delivery-proof";
  static const String submitRating = "/add-ratings";
  static const String selectDuelWinner = "/select-winner-duel";
  static const String raiseDispute = "/raise-dispute";
  static const String getDisputes = "/get-disputes";
  static const String submitDeliveryProof = "/add-dispute-proof";

  /// Listing APIs ///
  static const String getConfigurations = "/get-congfiguration";
  static const String createListing = "/create-listing-for-user-game-service";
  static const String editListing = "/edit-user-game-service";
  static const String getBuyerListings = "/get-all-game-service-listing-buyer";
  static const String getSelfListings = "/get-all-game-service-listing";
  static const String reportListing = "/report-listing-user";
  static const String changeListingStatus =
      "/change-user-game-service-listing-status";
  static const String deleteListing = "/delete-user-game-service";
  static const String deleteListingImage = "/delete-s3-object";

  /// Chat APIs ///
  static const String getChats = "/get-all-contacts";
  static const String getMessages = "/get-messages";
  static const String sendMessage = "/send-message";
  static const String getUnreadMessageCount = "/get-unread-message-count";
  static const String messageCapability = "/message-capability";

  /// Slots APIs ///
  static const String addSlots = "/add-slots";
  static const String addSlotsForAllDays = "/copy-to-all-days";
  static const String getSlots = "/get-slots";
  static const String getSlotsForSeller = "/get-slots-for-seller";
  static const String deleteSlot = "/delete-slots";
  static const String editSlot = "/change-order-slot";

  /// Kyc APIs ///
  static const String getKycToken = "/get-kyc-token";
  static const String sendKycOtp = "/send-kyc-otp";
  static const String verifyKycOtp = "/verify-aadhar-otp";

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
  static const String getPaymentTransactions = "/get-transaction-history";
  static const String getWalletTransactions = "/get-wallet-transactions";
  static const String getEarningTransactions = "/get-earning-history";
  static const String getFollowers = "/get-followers-users";
  static const String getFollowing = "/get-following-users";
  static const String submitFeedback = "/submit-feedback";
  static const String getSettlementRequests = "/get-settlement-request";
  static const String getTotalEarning = "/total-earning";
}

class ConditionalConstants {
  static const String otherProfile = "other";
  static const String myProfile = "myProfile";
  static const String fromMyListing = "myListing";
}

class ListingPageRedirection {
  static const String search = "search";
  static const String home = "home";
  static const String profile = "profile";
  static const String order = "order";
}
