import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/presentation/screens/auth/create_profile_screen.dart';
import 'package:loby/presentation/screens/auth/sign_up_screen.dart';
import 'package:loby/presentation/screens/main/chat/chat_page.dart';
import 'package:loby/presentation/screens/main/profile/my_disputes/create_new_dispute_screen.dart';
import 'package:loby/presentation/screens/main/profile/faqs.dart';
import 'package:loby/presentation/screens/main/profile/terms_conditions/legal_options.dart';
import 'package:loby/presentation/screens/main/profile/terms_conditions/static_terms.dart';
import 'package:loby/presentation/screens/main/profile/wallet/settlement_request_history.dart';
import 'package:loby/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:loby/services/routing_service/routes.dart';
import 'package:loby/services/routing_service/routing_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/screens/auth/sign_in_screen.dart';
import '../../presentation/screens/main/home/category_item_screen.dart';
import '../../presentation/screens/main/profile/my_disputes/disputes_screen.dart';
import '../../presentation/screens/main/home/game_details_screen.dart';
import '../../presentation/screens/main/home/game_itm_screen.dart';
import '../../presentation/screens/main/profile/user_profile/followers/followers_screen.dart';
import '../../presentation/screens/main/profile/user_profile/user_profile_screen.dart';
import '../../presentation/screens/main/home/search_screen.dart';
import '../../presentation/screens/main/main_screen.dart';
import '../../presentation/screens/main/profile/feedback_screen.dart';
import '../../presentation/screens/main/profile/my_listing/my_listing_screen.dart';
import '../../presentation/screens/main/profile/my_order/my_order_screen.dart';
import '../../presentation/screens/main/profile/profile_verification_screen.dart';
import '../../presentation/screens/main/profile/wallet/add_wallet_screen.dart';
import '../../presentation/screens/main/profile/wallet/my_wallet_screen.dart';
import '../../presentation/screens/main/profile/wallet/paymnet_transaction_history.dart';
import '../../presentation/screens/main/profile/wallet/wallet_transaction_history.dart';
import '../../presentation/screens/main/profile/wallet/withdraw_funds_screen.dart';
import '../firebase_dynamic_link.dart';
import 'routes_name.dart';

class MyRouter {
  Future<GoRouter> appRouter({required PendingDynamicLinkData? initialLink}) async {
    // final token = await Helpers.getApiToken();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final router = GoRouter(
        redirect: (context, state)async{
          bool? isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
          bool? onBoardingDone = prefs.getBool('onBoardingDone') ?? false;
          String? token = prefs.getString('apiToken');
          debugPrint("Api Token $token");


          final isLogging = state.location == loginRoute;
          final onBoarding = state.location == onBoardingRoute;


          if(initialLink != null){
            return null;
          }else if(!onBoardingDone && !onBoarding){
            return onBoardingRoute;
          }else if(onBoardingDone && !isLoggedIn && !isLogging){
            return loginRoute;
          }else{
            return null;
          }
        },
        debugLogDiagnostics: true,
        routes: [

          GoRoute(
            name: initialPage,
            path: initialRoute,
            pageBuilder: (context, state) {
              return CupertinoPage(
                key: state.pageKey,
                child: RoutingService(initialLink: initialLink),
              );
            },
          ),
          GoRoute(
              name: loginPage,
              path: loginRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                  key: state.pageKey,
                  child: const SignInScreen(),
                );
              }),
          GoRoute(
            name: onBoardingPage,
            path: onBoardingRoute,
            pageBuilder: (context, state) {
              return CupertinoPage(
                key: state.pageKey,
                child: const OnBoardingScreen(),
              );
            },
          ),
          GoRoute(
              name: signUpScreenPage,
              path: signUpScreenRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                  key: state.pageKey,
                  child: const SignUpScreen(),
                );
              }),

          GoRoute(
              name: createProfilePage,
              path: createProfileRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                  key: state.pageKey,
                  child: const CreateProfileScreen(),
                );
              }),

          GoRoute(
              name: mainPage,
              path: mainRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                  key: state.pageKey,
                  child: const MainScreen(),
                );
              }),
          GoRoute(
              name: gameCategoriesPage,
              path: gameCategoriesRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                  key: state.pageKey,
                  child: CategoryItemScreen(
                    categoryId: int.tryParse(state.queryParams['categoryId']!),
                  ),
                );
              }),
          GoRoute(
              name: gamePage,
              path: gameRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                  key: state.pageKey,
                  child: GameItemScreen(
                    categoryId: int.tryParse(state.queryParams['categoryId']!)!,
                    gameId: int.tryParse(state.queryParams['gameId']!)!,
                    gameName: state.queryParams['gameName']!,
                  ),
                );
              }),
          GoRoute(
              name: gameDetailPage,
              path: gameDetailRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                  key: state.pageKey,
                  child: GameDetailScreen(serviceListingId: int.tryParse(state.queryParams['serviceListingId']!)!, from: state.queryParams['from'],),
                );
              }),

          GoRoute(
              name: userProfilePage,
              path: userProfileRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                  key: state.pageKey,
                  child: UserProfileScreen(userId: int.tryParse(state.queryParams['userId']!)!, from: state.queryParams['from']!, ),
                );
              }),

          GoRoute(
              name: followerPage,
              path: followerRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                  key: state.pageKey,
                  child: const FollowersScreen(),
                );
              }),

          //my profile routes
          GoRoute(
              name: myWalletPage,
              path: myWalletRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                  key: state.pageKey,
                  child: const MyWalletScreen(),
                );
              }),

          GoRoute(
              name: myOrderPage,
              path: myOrderRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                  key: state.pageKey,
                  child: const MyOrderScreen(),
                );
              }),

          GoRoute(
              name: myListingPage,
              path: myListingRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                  key: state.pageKey,
                  child: const MyListingScreen(),
                );
              }),

          GoRoute(
              name: myDisputePage,
              path: myDisputeRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                  key: state.pageKey,
                  child: const DisputeScreen(),
                );
              }),

          GoRoute(
              name: profileVerificationPage,
              path: profileVerificationRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                  key: state.pageKey,
                  child: const ProfileVerificationScreen(),
                );
              }),

          GoRoute(
              name: feedbackScreenPage,
              path: feedbackScreenRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                  key: state.pageKey,
                  child: const FeedbackScreen(),
                );
              }),

          GoRoute(
              name: addFundScreenPage,
              path: addFundScreenRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                  key: state.pageKey,
                  child: const AddFundsScreen(),
                );
              }),

          GoRoute(
              name: withdrawFundScreenPage,
              path: withdrawFundScreenRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                  key: state.pageKey,
                  child: const WithdrawFundsScreen(),
                );
              }),

          GoRoute(
              name: createNewDisputePage,
              path: createNewDisputeRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                  key: state.pageKey,
                  child: CreateNewDispute(disputeId: int.tryParse(state.queryParams['disputeId']!)!,),
                );
              }),

          GoRoute(
              name: paymentTransactionPage,
              path: paymentTransactionRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                  key: state.pageKey,
                  child: const PaymentTransactionHistory(),
                );
              }),
          GoRoute(
              name:walletTransactionPage,
              path: walletTransactionRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                  key: state.pageKey,
                  child: const WalletTransactionHistory(),
                );
              }),

          
          GoRoute(
              name: searchScreenPage,
              path: searchScreenRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                  key: state.pageKey,
                  child: const SearchScreen(),
                );
              }),
          GoRoute(
              name: faqPage,
              path: faqRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                  key: state.pageKey,
                  child: const FAQs(),
                );
              }),
          GoRoute(
              name: legalTermsPage,
              path: legalTermsRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                  key: state.pageKey,
                  child: const LegalOptions()
                );
              }),
          GoRoute(
              name: staticContentPage,
              path: staticContentRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                    key: state.pageKey,
                    child: StaticTerms(termName: state.queryParams['termName']!)
                );
              }),
          GoRoute(
              name: messagePage,
              path: messageRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                  key: state.pageKey,
                  child: ChatPage(
                    chatId: int.tryParse(state.queryParams['chatId']!)!,
                    senderId: int.tryParse(state.queryParams['senderId']!)!,
                    receiverId: int.tryParse(state.queryParams['receiverId']!)!,
                  )
                  // MessagePage(chatId: int.tryParse(state.queryParams['chatId']!)!, name: state.queryParams['name']!,),
                );
              }),
          GoRoute(
              name: settlementRequestHistoryPage,
              path: settlementRequestHistoryRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                    key: state.pageKey,
                    child: const SettlementRequestHistory()
                );
              }),
        ]);
    return router;
  }
}
