import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/domain/entities/home/game.dart';
import 'package:loby/presentation/getx/controllers/home_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../services/routing_service/routes_name.dart';

class GameCard extends StatelessWidget {
  final Game game;

  const GameCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    HomeController homeController = Get.find<HomeController>();
    return GestureDetector(
      onTap: () {
        context.pushNamed(gamePage, extra: {
          'categoryId': '${homeController.categories.first.id}',
          'gameId': '${game.id}',
          'gameName': game.name!
        });
      },
      child: Card(
        elevation: 0,
        shadowColor: Colors.black,
        color: Colors.transparent,
        child: SizedBox(
          width: 150,
          height: 166,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: aquaGreenColor,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(36),
                      child: CachedNetworkImage(
                        imageUrl: game.image!,
                        fit: BoxFit.cover,
                        height: 110,
                        width: 110,
                        // placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.white,)),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.5.h,
                ), //CircleAvatar//SizedBox
                Text(
                  game.name!,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: textTheme.titleLarge
                      ?.copyWith(color: textWhiteColor), //Textstyle
                ), //Text
                SizedBox(
                  height: 0.5.h,
                ), //SizedBoxe
              ],
            ), //Column
          ), //Padding
        ), //SizedBox
      ),
    );
  }
}
