import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/domain/entities/profile/rating.dart';
import 'package:loby/domain/entities/profile/user.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/widgets/body_padding_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../widgets/star_rating.dart';

class UserReviewRatingWidget extends StatefulWidget {
  final User user;

  const UserReviewRatingWidget({Key? key, required this.user})
      : super(key: key);

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
    final textTheme = Theme
        .of(context)
        .textTheme;
    return Obx(() {
      if(profileController.isRatingsFetching.value){
        return const Center(child: CircularProgressIndicator(),);
      }else{
        return ListView.builder(
          itemCount: profileController.ratings.length,
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 8),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return RatingTile(user: widget.user, rating: profileController.ratings[index],);
          },
        );
      }
    });
  }
}

class RatingTile extends StatelessWidget {
  final User user;
  final Rating rating;

  const RatingTile({Key? key, required this.rating, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    return Column(
      children: <Widget>[
        Card(
          color: textFieldColor,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: BodyPaddingWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(user.name!,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.headline5?.copyWith(
                            color: textWhiteColor)),
                    const SizedBox(
                      width: 16,
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
                  "Good service. Fast delivery. Trusted seller. ",
                  softWrap: true,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.headline6?.copyWith(color: textLightColor),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

