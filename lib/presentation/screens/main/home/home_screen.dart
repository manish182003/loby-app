import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  const HomeScreen({Key? key}) : super(key: key);

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

    return SafeArea(
      child: Scaffold(
        body: BodyPaddingWidget(
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Column(
                children: [
                  SizedBox(height: 4.h,),
                  GlobalSearchFieldWidget(onTap: () {
                    context.pushNamed(searchScreenPage);
                  }),
                  SizedBox(height: 3.h,),
                  Text('Categories', style: textTheme.headline3?.copyWith(color: textWhiteColor)),
                  SizedBox(height: 3.h,),
                  _buildCategories(textTheme),
                  SizedBox(height: 3.h,),
                  Container(
                      decoration: BoxDecoration(
                        color: textFieldColor,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.all(2.h),
                              child: Text('Top Games', style: textTheme.headline3?.copyWith(color: textWhiteColor))),
                          _buildTopGames(textTheme),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  _buildCategories(TextTheme textTheme) {
    return Obx(() {
      if (homeController.isCategoryFetching.value) {
        return const Center(child: CircularProgressIndicator(),);
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
                  context.pushNamed(gameCategoriesPage, queryParams: {'categoryId' : homeController.categories[index].id.toString()});
                },
                child: Container(
                  height: 2.h,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: textFieldColor,
                    border: Border.all(color: textLightColor, width: 1),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    homeController.categories[index].name!,
                    style: textTheme.headline4?.copyWith(color: aquaGreenColor),
                  ),
                ));
          },
        );
      }
    });
  }

  _buildTopGames(TextTheme textTheme) {
    return SizedBox(
      height: 20.h,
      child: Obx(() {
        if(homeController.isGamesFetching.value){
          return const Center(child: CircularProgressIndicator(),);
        }else {
          return ListView.builder(
            itemCount: homeController.games.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) =>
                GestureDetector(
                  onTap: () {
                    debugPrint('Battlegrounds Mobile India $index');
                    FocusManager.instance.primaryFocus?.unfocus();
                    context.pushNamed(gamePage);
                    /*Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    GameItemScreen(name: 'Battlegrounds Mobile $index')));*/
                  },
                  child: SizedBox(
                    height: 166,
                    width: 120,
                    child: Center(
                      child: GameCard(game: homeController.games[index]),
                    ),
                  ),
                ),
          );
        }
      }),
    );
  }
}
