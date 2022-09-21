import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/services/routing_service/routes_name.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../services/routing_service/routes.dart';
import '../game_itm_screen.dart';

class CategoryItemCard extends StatelessWidget {
  final int index;
  final int categoryId;
  final int gameId;
  final String gameName;
  final String? images;

  const CategoryItemCard({Key? key, required this.index, this.images, required this.categoryId, required this.gameId, required this.gameName}) : super(key: key);

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
            AspectRatio(
              aspectRatio: 18.0 / 16.0,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: aquaGreenColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      imageUrl: images!,
                      fit: BoxFit.cover,
                      height: 110,
                      width: 110,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.white,)),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
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
                  style:
                  textTheme.headline6?.copyWith(color: textWhiteColor)),
            ),
          ],
        ),
      ),
    );
  }
}
