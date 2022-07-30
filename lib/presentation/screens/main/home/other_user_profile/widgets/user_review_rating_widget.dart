import 'package:flutter/material.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../widgets/star_rating.dart';

class UserReviewRatingWidget extends StatefulWidget {
  const UserReviewRatingWidget({Key? key}) : super(key: key);

  @override
  State<UserReviewRatingWidget> createState() => _UserReviewRatingWidgetState();
}

class _UserReviewRatingWidgetState extends State<UserReviewRatingWidget> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return _buildWidget(textTheme);
  }

  _buildWidget(TextTheme textTheme) {
    double rating = 3.5;
    return Column(
      children: <Widget>[
        Card(
          color: textFieldColor,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("rahulsingh",
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.headline5
                            ?.copyWith(color: textWhiteColor)),
                    const SizedBox(
                      width: 16,
                    ),
                    StarRating(
                      rating: rating,
                      color: saffronMangoOrangeColor,
                      onRatingChanged: (rating) =>
                          setState(() => rating = rating),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  child: Text("Good service. Fast delivery. Trusted seller. ",
                      softWrap: true,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style:
                          textTheme.headline6?.copyWith(color: textLightColor)),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
