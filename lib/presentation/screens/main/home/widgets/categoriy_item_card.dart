import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/domain/entities/home/game.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../services/routing_service/routes.dart';
import '../../../../widgets/custom_cached_network_image.dart';
import '../game_itm_screen.dart';

class CategoryItemCard extends StatelessWidget {
  final int index;
  final int categoryId;
  final int gameId;
  final String gameName;
  final String? images;
  final Game game;

  const CategoryItemCard({Key? key, required this.index, this.images, required this.categoryId, required this.gameId, required this.gameName, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        context.pushNamed(gamePage, queryParams: {'categoryId' : '$categoryId', 'gameId' : '$gameId', 'gameName' : gameName});
      },
      child: Card(
        color: Colors.transparent,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding:  const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 36,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(36),
                  child: CustomCachedNetworkImage(
                    imageUrl: images!,
                    placeHolder: Image.asset("assets/images/listing_placeholder.jpg"),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
              child: Text(gameName,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: textTheme.headline6?.copyWith(color: textWhiteColor)),

            ),
            SizedBox(height: 1.h,),
            Text("${game.listingCount} Listings",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: textTheme.headline6?.copyWith(color: lavaRedColor)),
          ],
        ),
      ),
    );
  }
}
