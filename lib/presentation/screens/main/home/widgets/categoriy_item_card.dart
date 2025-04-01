import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/domain/entities/home/game.dart';
import 'package:loby/services/routing_service/routes_name.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../widgets/custom_cached_network_image.dart';

class CategoryItemCard extends StatelessWidget {
  final int index;
  final int categoryId;
  final int gameId;
  final String gameName;
  final String? images;
  final Game game;

  const CategoryItemCard(
      {super.key,
      required this.index,
      this.images,
      required this.categoryId,
      required this.gameId,
      required this.gameName,
      required this.game});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        context.pushNamed(gamePage, extra: {
          'categoryId': '$categoryId',
          'gameId': '$gameId',
          'gameName': gameName
        });
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
              padding: const EdgeInsets.all(0.0),
              child: CircleAvatar(
                radius: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CustomCachedNetworkImage(
                    imageUrl: images!,
                    placeHolder:
                        Image.asset("assets/images/listing_placeholder.jpg"),
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
                  style: textTheme.titleLarge?.copyWith(color: textWhiteColor)),
            ),
            // SizedBox(height: 0.5.h,),
            Text("${game.listingCount} Listings",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: textTheme.titleLarge?.copyWith(color: lavaRedColor)),
          ],
        ),
      ),
    );
  }
}
