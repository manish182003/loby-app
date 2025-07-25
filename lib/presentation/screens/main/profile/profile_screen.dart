import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/di/injection.dart';
import 'package:loby/main.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/widgets/custom_loader.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/colors.dart';
import '../../../widgets/profile_picture.dart';
import '../profile/widgets/profile_options.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = Get.find<ProfileController>();
  AuthController authController = Get.find<AuthController>();
  double rating = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          if (profileController.isProfileFetching.value) {
            return const CustomLoader();
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(8.w, 30, 20, 30),
                  child: GestureDetector(
                    onTap: () {
                      context.pushNamed(userProfilePage, extra: {
                        'userId': "${profileController.profile.id}",
                        'from': 'myProfile'
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ProfilePicture(profile: profileController.profile),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.55),
                                      child: Row(
                                        children: [
                                          Text(
                                              profileController
                                                      .profile.displayName ??
                                                  "",
                                              overflow: TextOverflow.ellipsis,
                                              style: textTheme.displaySmall
                                                  ?.copyWith(
                                                      color: textWhiteColor)),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          profileController.profile.kycverify ==
                                                  "Y"
                                              ? const Image(
                                                  image: AssetImage(
                                                      "assets/images/sheild.png"),
                                                  height: 20,
                                                )
                                              : const SizedBox()
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                  ],
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  "View Profile",
                                  style: textTheme.titleSmall?.copyWith(
                                      fontSize: 10.sp, color: textWhiteColor),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row(

                          // )
                          ProfileOptionsWidget(
                              name: "Wallet",
                              onTap: () {
                                context.pushNamed(myWalletPage);
                              }),
                          ProfileOptionsWidget(
                              name: "My Listings",
                              onTap: () {
                                context.pushNamed(myListingPage);
                              }),
                          ProfileOptionsWidget(
                              name: "My Orders",
                              onTap: () {
                                context.pushNamed(myOrderPage);
                              }),
                          ProfileOptionsWidget(
                              name: "My Disputes",
                              onTap: () {
                                context.pushNamed(myDisputePage);
                              }),
                          ProfileOptionsWidget(
                              name: "My Time Slots",
                              onTap: () {
                                context.pushNamed(sellerTimeSlotScreen);
                              }),
                          ProfileOptionsWidget(
                              name: "Profile Verification",
                              onTap: () {
                                context.pushNamed(profileVerificationPage);
                              }),
                          ProfileOptionsWidget(
                              name: "Feedback/Suggestions",
                              onTap: () {
                                context.pushNamed(feedbackScreenPage);
                              }),
                          ProfileOptionsWidget(
                              name: "PG Transactions",
                              onTap: () {
                                context.pushNamed(paymentTransactionPage);
                              }),
                          ProfileOptionsWidget(
                              name: "FAQs",
                              onTap: () {
                                context.pushNamed(faqPage);
                              }),
                          // ProfileOptionsWidget(
                          //     name: "Seller Time Slots",
                          //     onTap: () {
                          //       context.pushNamed(sellerTimeSlotScreen);
                          //     }),
                          // ProfileOptionsWidget(
                          // name: "buyer Time slots",
                          // onTap: () {
                          //   context.pushNamed(buyerTimeSlotScreen);
                          // }),
                          // ProfileOptionsWidget(
                          //     name: "App Setting",
                          //     onTap: () {
                          //       SmartDialog.showLoading();
                          //       // showDialog(
                          //       //     context: context,
                          //       //     builder: (BuildContext context) {
                          //       //       return RatingDialog(
                          //       //         title: "Review & Rating",
                          //       //         descriptions: "Congratulations on sucessfully getting your service delivered. Kindly rate thus seller & its service to help us serve you better",
                          //       //         text: "OK",
                          //       //         onChanged: (rating){
                          //       //           rating = rating;
                          //       //         },
                          //       //         onSubmit: () {
                          //       //
                          //       //         },
                          //       //       );
                          //       //     });
                          //     }),
                          ProfileOptionsWidget(
                              name: "Terms & Conditions",
                              onTap: () {
                                context.pushNamed(legalTermsPage);
                              }),
                          ProfileOptionsWidget(
                            name: "Settings",
                            onTap: () {
                              context.pushNamed(settingsPage);
                            },
                          ),
                          ProfileOptionsWidget(
                            name: "Logout",
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return showAlertDialog();
                                },
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01.h,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Version Beta 1.0',
                      textAlign: TextAlign.center,
                      style:
                          textTheme.titleSmall?.copyWith(color: textWhiteColor),
                    ),
                  ),
                )
              ],
            );
          }
        }),
      ),
    );
  }

  Widget showAlertDialog() {
    return AlertDialog(
      backgroundColor: textTunaBlueColor,
      titlePadding: EdgeInsets.symmetric(
        horizontal: 14.w,
      ).copyWith(top: 2.h),
      title: Text(
        'Logout Your Account',
        style: TextStyle(
          color: textWhiteColor,
          fontSize: 14.spa,
          fontWeight: FontWeight.w500,
        ),
      ),
      alignment: Alignment.center,
      content: Text(
        'Do you really want to log out? We\'ll miss you!',
        style: TextStyle(
          color: textWhiteColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        ElevatedButton(
          onPressed: () {
            _logout();
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color>(textErrorColor),
          ),
          child: Text(
            'Logout',
            style: TextStyle(
              color: textWhiteColor,
              fontSize: 13.spa,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            contextKey.currentContext?.pop();
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color>(aquaGreenColor),
          ),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: textWhiteColor,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // authController.clearProfileDetails();
    await prefs.remove('searchHis');

    await prefs.remove('apiToken');
    await prefs.remove('isLoggedIn');

    Get.deleteAll();
    DependencyInjector.inject();
    context.goNamed(loginPage);
  }
}
