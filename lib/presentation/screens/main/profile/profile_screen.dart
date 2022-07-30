import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/services/routing_service/routes_name.dart';
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
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundColor: aquaGreenColor,
                    radius: 35,
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/img.png'),
                        radius: 35,
                      ),
                    ), //CircleAvatar
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mukesh Kumar Patel",
                            style: textTheme.subtitle1?.copyWith(
                                fontSize: 18.sp, color: textWhiteColor),
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
                          name: "App Setting",
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const RatingDialog(
                                    title: "Review & Rating",
                                    descriptions:
                                        "Congratulations on sucessfully getting your service delivered. Kindly rate thus seller & its service to help us serve you better",
                                    text: "OK",
                                  );
                                });
                          }),
                      ProfileOptionsWidget(
                          name: "Terms & Conditions",
                          onTap: () {
                            debugPrint('check data');
                          }),
                      ProfileOptionsWidget(
                          name: "Logout",
                          onTap: () {
                            debugPrint('check data');
                          }),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01.h,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Version Beta 1.0',
                  textAlign: TextAlign.center,
                  style: textTheme.subtitle2?.copyWith(color: textWhiteColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
