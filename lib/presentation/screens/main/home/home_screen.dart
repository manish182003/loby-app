import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/presentation/getx/controllers/home_controller.dart';
import 'package:loby/presentation/screens/main/home/widgets/game_list_card.dart';
import 'package:loby/presentation/widgets/body_padding_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../services/routing_service/routes_name.dart';
import '../../../widgets/GlobleSearchFieldWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.getCategories();
    homeController.getGames();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Column(
          children: [
            Container(
              color: backgroundBalticSeaColor,
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: 4.h,
                  ),
                  Image.asset(
                    "assets/icons/app_icon.png",
                    height: 80,
                    width: 80,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: GlobalSearchFieldWidget(onTap: () {
                      context.pushNamed(searchScreenPage);
                    }),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Column(
              children: [
                // GlobalSearchFieldWidget(onTap: () {
                //   context.pushNamed(searchScreenPage);
                // }),
                // SizedBox(height: 3.h,),
                Text('Categories',
                    style: textTheme.displaySmall
                        ?.copyWith(color: textWhiteColor)),
                SizedBox(
                  height: 3.h,
                ),
                BodyPaddingWidget(child: _buildCategories(textTheme)),
                SizedBox(
                  height: 3.h,
                ),
                Padding(
                    padding: EdgeInsets.all(2.h),
                    child: Text('Top Games',
                        style: textTheme.displaySmall
                            ?.copyWith(color: textWhiteColor))),
                Container(
                    decoration: const BoxDecoration(
                      color: textFieldColor,
                      // borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      children: [
                        // Padding(
                        //     padding: EdgeInsets.all(2.h),
                        //     child: Text('Top Games', style: textTheme.headline3?.copyWith(color: textWhiteColor))),
                        _buildTopGames(textTheme),
                      ],
                    )),
              ],
            ),
            // ),
          ],
        ),
      ),
    );
  }

  _buildCategories(TextTheme textTheme) {
    return Obx(() {
      if (homeController.isCategoryFetching.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.5,
            mainAxisSpacing: 15,
            crossAxisSpacing: 30,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: homeController.categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  debugPrint('Buddy $index');
                  FocusManager.instance.primaryFocus?.unfocus();
                  context.pushNamed(gameCategoriesPage, extra: {
                    'categoryId':
                        homeController.categories[index].id.toString(),
                    'catName': homeController.categories[index].name
                  });
                },
                child: Container(
                  height: 2.h,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: textFieldColor,
                    // border: bor,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    homeController.categories[index].name!,
                    style: textTheme.headlineMedium?.copyWith(
                      color: aquaGreenColor,
                      // fontSize: 11.spa,
                    ),
                  ),
                ));
          },
        );
      }
    });
  }

  _buildTopGames(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 17.h,
        child: Obx(() {
          if (homeController.isGamesFetching.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: homeController.games.take(10).length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => SizedBox(
                height: 166,
                width: 120,
                child: Center(
                  child: GameCard(
                    game: homeController.games[index],
                  ),
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
