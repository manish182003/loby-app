import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/domain/entities/profile/user.dart';
import 'package:loby/presentation/getx/controllers/home_controller.dart';
import 'package:loby/presentation/screens/main/profile/user_profile/widgets/user_about_widget.dart';
import 'package:loby/presentation/screens/main/profile/user_profile/widgets/user_duels_widget.dart';
import 'package:loby/presentation/screens/main/profile/user_profile/widgets/user_listing_widget.dart';
import 'package:loby/presentation/screens/main/profile/user_profile/widgets/user_review_rating_widget.dart';
import 'package:loby/presentation/screens/main/profile/user_profile/widgets/user_social_widgets.dart';
import 'package:loby/presentation/widgets/body_padding_widget.dart';

import '../../../../../widgets/custom_chip.dart';

class UserInfo extends StatelessWidget {
  final User user;
  final String from;

  UserInfo({super.key, required this.user, required this.from});

  final List<String> bubbles = [
    'Listing',
    'About',
    'Socials',
    'Duels',
    'Review & Ratings',
  ];

  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return BodyPaddingWidget(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomChip(
            labelName: bubbles,
            spacing: 16,
            onChanged: (index) {
              homeController.profileSelectedOptionIndex.value = index;
            },
          ),
          Obx(() {
            final index = homeController.profileSelectedOptionIndex.value;
            switch (index) {
              case 0:
                return UserListingWidget(user: user, from: from);
              case 1:
                return UserAboutWidget(user: user);
              case 2:
                return UserSocialWidget(
                  user: user,
                  from: from,
                );
              // if(from == "other"){
              //   return UserSocialWidget(user: user);
              // }else{
              //   return MySocialWidget(user: user);
              // }
              case 3:
                return UserDuelsWidget(user: user);
              case 4:
                return UserReviewRatingWidget(user: user);
              default:
                return UserListingWidget(user: user, from: from);
            }
          }),
        ],
      ),
    );
  }
}
