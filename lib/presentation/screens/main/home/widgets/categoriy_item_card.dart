import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/services/routing_service/routes_name.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../services/routing_service/routes.dart';
import '../game_itm_screen.dart';

class CategoryItemCard extends StatelessWidget {
  int index;
  CategoryItemCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        context.pushNamed(gamePage);
        /*Navigator.of(context).push(MaterialPageRoute(builder: (context) => GameItemScreen(name: 'Battlegrounds Mobile $index')));*/
      },
      child: Card(
        color: Colors.transparent,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: Image.asset(
                    "assets/images/img.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Lvl 78 Account on SA",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style:
                      textTheme.headline6?.copyWith(color: textWhiteColor)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
