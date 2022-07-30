import 'package:flutter/material.dart';
import 'package:loby/presentation/screens/main/home/other_user_profile/widgets/user_about_widget.dart';
import 'package:loby/presentation/screens/main/home/other_user_profile/widgets/user_duels_widget.dart';
import 'package:loby/presentation/screens/main/home/other_user_profile/widgets/user_listing_widget.dart';
import 'package:loby/presentation/screens/main/home/other_user_profile/widgets/user_review_rating_widget.dart';
import 'package:loby/presentation/screens/main/home/other_user_profile/widgets/user_social_widgets.dart';
import '../../../../../widgets/custom_chip.dart';

class UserInfo extends StatelessWidget {
  UserInfo({Key? key}) : super(key: key);

  final List<String> bubbles = [
    'Listing',
    'About',
    'Socials',
    'Review & Ratings',
    'In-Game Items',
    'Duels',
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildCategories(textTheme),
                // UserListingWidget(),
               //  UserAboutWidget(),
               // const UserReviewRatingWidget(),
                  UserDuelsWidget(),
                //  const UserSocialWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildCategories(TextTheme textTheme) {
    return CustomChip(
      labelName: bubbles,
    );
  }
}
