import 'package:flutter/material.dart';
import 'package:loby/presentation/screens/main/home/other_user_profile/widgets/user_duels_widget.dart';
import 'package:loby/presentation/screens/main/home/other_user_profile/widgets/user_review_rating_widget.dart';

import '../../../../../widgets/custom_chip.dart';
import 'my_social_widgets.dart';
import 'my_user_about_widget.dart';
import 'my_user_listing_widget.dart';

class MyInfo extends StatelessWidget {
  MyInfo({Key? key}) : super(key: key);

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
    return Column(
      children: <Widget>[
        _buildCategories(textTheme),
        Container(
          padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                MyUserListingWidget(),
                MyUserAboutWidget(),
                UserReviewRatingWidget(),
                UserDuelsWidget(),
                MySocialWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildCategories(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: CustomChip(
        labelName: bubbles,
      ),
    );
  }
}
