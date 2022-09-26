import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/presentation/getx/controllers/listing_controller.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/widgets/custom_loader.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/colors.dart';
import '../../../widgets/rating_dialog.dart';
import '../profile/widgets/profile_options.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  ProfileController profileController = Get.find<ProfileController>();
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
    final textTheme = Theme
        .of(context)
        .textTheme;
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          if(profileController.isProfileFetching.value){
            return const CustomLoader();
          }else{
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                  child: GestureDetector(
                    onTap: () {
                      context.pushNamed(otherUserPage, queryParams: {'userId': "${profileController.profile.id}", 'from': 'my'});
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: aquaGreenColor,
                          radius: 35,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(35),
                              child: CachedNetworkImage(
                                imageUrl: profileController.profile.image ?? "",
                                fit: BoxFit.cover,
                                height: 110,
                                width: 110,
                                placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.white,)),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                          ), //CircleAvatar
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context).size.width * 0.55),
                                      child: Text(profileController.profile.displayName ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          style: textTheme.headline3
                                              ?.copyWith(
                                              color: textWhiteColor)),
                                    ),
                                    const SizedBox(width: 8.0),
                                    profileController.profile.verifiedProfile ?? false ? SvgPicture.asset(
                                      'assets/icons/verified_user_bedge.svg',
                                      height: 15,
                                      width: 15,
                                    ) : const SizedBox(),
                                  ],
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  "View Profile",
                                  style: textTheme.subtitle2?.copyWith(
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
                              name: "Payment Transaction",
                              onTap: () {
                                context.pushNamed(paymentTransactionPage);
                              }),
                          ProfileOptionsWidget(
                              name: "FAQs",
                              onTap: () {
                                context.pushNamed(faqPage);
                              }),
                          ProfileOptionsWidget(
                              name: "App Setting",
                              onTap: () {
                                SmartDialog.showLoading();
                                // showDialog(
                                //     context: context,
                                //     builder: (BuildContext context) {
                                //       return RatingDialog(
                                //         title: "Review & Rating",
                                //         descriptions: "Congratulations on sucessfully getting your service delivered. Kindly rate thus seller & its service to help us serve you better",
                                //         text: "OK",
                                //         onChanged: (rating){
                                //           rating = rating;
                                //         },
                                //         onSubmit: () {
                                //
                                //         },
                                //       );
                                //     });
                              }),
                          ProfileOptionsWidget(
                              name: "Terms & Conditions",
                              onTap: () {
                                debugPrint('check data');
                              }),
                          ProfileOptionsWidget(
                              name: "Logout",
                              onTap: _logout
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.01.h,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Version Beta 1.0',
                      textAlign: TextAlign.center,
                      style: textTheme.subtitle2?.copyWith(color: textWhiteColor),
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

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('apiToken');
    await prefs.remove('isLoggedIn');

    context.goNamed(loginPage);
  }
}
