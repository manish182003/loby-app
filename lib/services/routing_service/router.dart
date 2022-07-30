import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/presentation/screens/main/home/disputes/create_new_dispute_screen.dart';
import 'package:loby/services/routing_service/routes.dart';

import '../../presentation/screens/auth/sign_in_screen.dart';
import '../../presentation/screens/main/home/category_item_screen.dart';
import '../../presentation/screens/main/home/disputes/disputes_screen.dart';
import '../../presentation/screens/main/home/game_details_screen.dart';
import '../../presentation/screens/main/home/game_itm_screen.dart';
import '../../presentation/screens/main/home/other_user_profile/follower_following_screen/followers_screen.dart';
import '../../presentation/screens/main/home/other_user_profile/other_user_profile_screen.dart';
import '../../presentation/screens/main/main_screen.dart';
import '../../presentation/screens/main/profile/feedback_screen.dart';
import '../../presentation/screens/main/profile/my_listing/my_listing_screen.dart';
import '../../presentation/screens/main/profile/my_order/my_order_screen.dart';
import '../../presentation/screens/main/profile/profile_verification_screen.dart';
import '../../presentation/screens/main/profile/wallet/add_wallet_screen.dart';
import '../../presentation/screens/main/profile/wallet/my_wallet_screen.dart';
import '../../presentation/screens/main/profile/wallet/transaction_history_screen.dart';
import '../../presentation/screens/main/profile/wallet/withdraw_funds_screen.dart';
import 'routes_name.dart';

class MyRouter {
  Future<GoRouter> appRouter() async {
    final router = GoRouter(
        urlPathStrategy: UrlPathStrategy.path,
        debugLogDiagnostics: true,
        initialLocation: initialRoute,
        routes: [
          GoRoute(
            name: initialPage,
            path: initialRoute,
            pageBuilder: (context, state) {
              return CupertinoPage(
                key: state.pageKey,
                child: const SignInScreen(),
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
                    name: 'Test',
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
                    name: 'Test',
                  ),
                );
              }),
          GoRoute(
              name: gameDetailPage,
              path: gameDetailRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                  key: state.pageKey,
                  child: const GameDetailScreen(),
                );
              }),

          GoRoute(
              name: otherUserPage,
              path: otherUserRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                  key: state.pageKey,
                  child: const OtherUserProfileScreen(),
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
                  child: const CreateNewDispute(),
                );
              }),

          GoRoute(
              name: transactionHistoryPage,
              path: transactionHistoryRoute,
              pageBuilder: (context, state) {
                return CupertinoPage(
                  key: state.pageKey,
                  child: const TransactionHistoryScreen(),
                );
              }),
        ]);
    return router;
  }
}
