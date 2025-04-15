import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/domain/entities/profile/rating.dart';
import 'package:loby/domain/entities/profile/user.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../widgets/star_rating.dart';

class UserReviewRatingWidget extends StatefulWidget {
  final User user;

  const UserReviewRatingWidget({super.key, required this.user});

  @override
  State<UserReviewRatingWidget> createState() => _UserReviewRatingWidgetState();
}

class _UserReviewRatingWidgetState extends State<UserReviewRatingWidget> {
  ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.getRatings(userId: widget.user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (profileController.isRatingsFetching.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return ListView.builder(
          itemCount: profileController.ratings.length,
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 8),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return RatingTile(
              user: widget.user,
              rating: profileController.ratings[index],
            );
          },
        );
      }
    });
  }
}

class RatingTile extends StatelessWidget {
  final User user;
  final Rating rating;

  const RatingTile({super.key, required this.rating, required this.user});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      color: textFieldColor,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(rating.user!.displayName!,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.headlineSmall
                        ?.copyWith(color: textWhiteColor)),
                SizedBox(
                  width: 2.h,
                ),
                StarRating(
                  rating: rating.star?.toDouble() ?? 0,
                  color: saffronMangoOrangeColor,
                  onRatingChanged: (double rating) {},
                )
              ],
            ),
            SizedBox(height: 1.h),
            Text(
              rating.comments ?? '',
              softWrap: true,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: textTheme.titleLarge?.copyWith(color: textLightColor),
            ),
          ],
        ),
      ),
    );
  }
}
