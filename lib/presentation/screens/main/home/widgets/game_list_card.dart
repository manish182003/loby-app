import 'package:flutter/material.dart';
import 'package:loby/domain/entities/home/game.dart';
import 'package:sizer/sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../../core/theme/colors.dart';

class GameCard extends StatelessWidget {
  final Game game;

  const GameCard({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
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
              Padding(
                padding:  const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 36,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(36),
                    child: CachedNetworkImage(
                      imageUrl: game.image!,
                      fit: BoxFit.cover,
                      height: 110,
                      width: 110,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.white,)),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
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
                style: textTheme.headline6
                    ?.copyWith(color: textWhiteColor), //Textstyle
              ), //Text
              SizedBox(
                height: 0.5.h,
              ), //SizedBoxe
            ],
          ), //Column
        ), //Padding
      ), //SizedBox
    );
  }
}
