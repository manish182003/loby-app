import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/presentation/screens/main/home/widgets/game_list_card.dart';
import 'package:sizer/sizer.dart';

import '../../../../services/routing_service/routes_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: body(),
      ),
    );
  }

  Widget body() {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(color: backgroundBalticSeaColor),
              child: Padding(
                padding: EdgeInsets.all(2.h),
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 9.h,
                    child: Image.asset(
                      "assets/icons/app_icon.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 3.h,
            ),
            _buildSearchField(textTheme),
            SizedBox(
              width: double.infinity,
              height: 3.h,
            ),
            Text('Categories',
                style: textTheme.headline4?.copyWith(color: textWhiteColor)),
            SizedBox(
              width: double.infinity,
              height: 3.h,
            ),
            _buildCategories(textTheme),
            SizedBox(
              width: double.infinity,
              height: 3.h,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: textFieldColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.all(1.h),
                          child: Text('Top Games',
                              style: textTheme.headline4
                                  ?.copyWith(color: textWhiteColor))),
                      _buildTopGames(textTheme),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  _buildSearchField(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: textFieldColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: TextField(
          style: textTheme.headline4?.copyWith(color: textWhiteColor),
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: EdgeInsets.all(16.0),
              child: SvgPicture.asset(
                'assets/icons/search_icon.svg',
                color: iconWhiteColor,
              ),
            ),
            border: InputBorder.none,
            hintStyle: textTheme.headline4?.copyWith(color: textWhiteColor),
            hintText: 'Search',
          ),
        ),
      ),
    );
  }

  _buildCategories(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3.0,
          mainAxisSpacing: 1.h,
          crossAxisSpacing: 1.h,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                debugPrint('Buddy $index');
                FocusManager.instance.primaryFocus?.unfocus();
                context.pushNamed(gameCategoriesPage);
                /* Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        CategoryItemScreen(name: 'Buddy $index')));*/
              },
              child: Container(
                decoration: BoxDecoration(
                  color: textFieldColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Buddy $index',
                      style:
                          textTheme.headline5?.copyWith(color: aquaGreenColor),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }

  _buildTopGames(TextTheme textTheme) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        itemCount: 7,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            debugPrint('Battlegrounds Mobile India $index');
            FocusManager.instance.primaryFocus?.unfocus();
            context.pushNamed(gamePage);
            /*Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    GameItemScreen(name: 'Battlegrounds Mobile $index')));*/
          },
          child: SizedBox(
            height: 150,
            width: 150,
            child: Center(
              child: GameCard(index: index),
            ),
          ),
        ),
      ),
    );
  }
}
