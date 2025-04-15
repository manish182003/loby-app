import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  RxInt currentIndex = 0.obs;
  CarouselSliderController controller = CarouselSliderController();
  final List<String> imageList = [
    'assets/images/home_crousel.png',
    'assets/images/home_crousel.png',
    'assets/images/home_crousel.png',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.getAllBanners();
    homeController.getCategories();
    homeController.getGames();
  }

  /// Helper method for menu items
  PopupMenuItem _buildMenuItem(String title, String? iconPath, bool isEnabled,
      String? icon, double? width, double? height) {
    return PopupMenuItem(
      enabled: isEnabled,
      child: Row(
        children: [
          if (iconPath != null) ...[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: aquaGreenColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(iconPath, height: 20, width: 20),
                    SizedBox(width: 10),
                    Text(title,
                        style: TextStyle(
                            color: isEnabled ? Colors.white : Colors.grey)),
                  ],
                ),
              ),
            ),
          ] else ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SvgPicture.asset(icon!, height: height, width: width),
                SizedBox(width: 18),
                Text(
                  title,
                  style: TextStyle(
                    color: isEnabled ? Colors.white : Color(0xFFD9D9D9),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (!isEnabled)
                  Text("  Coming Soon",
                      style: TextStyle(
                        color: Color(0xFFE94F31),
                        fontSize: 6,
                        fontWeight: FontWeight.w200,
                      )),
              ],
            )
          ]
        ],
      ),
    );
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
                    height: 1.h,
                  ),
                  Image.asset(
                    "assets/icons/app_icon.png",
                    height: 80,
                    width: 80,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: GlobalSearchFieldWidget(onTap: () {
                      context.pushNamed(searchScreenPage);
                    }),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  GestureDetector(
                    onTapDown: (TapDownDetails details) async {
                      final selected = await showMenu(
                        context: context,
                        color: Color(0xFF33343B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        position: RelativeRect.fromDirectional(
                          textDirection: TextDirection.ltr,
                          start: 50,
                          top: 220,
                          end: 20,
                          bottom: 0,
                        ),
                        items: [
                          _buildMenuItem('Marketplace',
                              'assets/icons/Marketplace.svg', true, null, 0, 0),
                          _buildMenuItem('Clans / Teams', null, false,
                              'assets/icons/1.svg', 20, 15),
                          _buildMenuItem('Tournaments', null, false,
                              'assets/icons/2.svg', 16, 20),
                          _buildMenuItem('Web3', null, false,
                              'assets/icons/3.svg', 20, 20),
                        ],
                      );
                    },
                    child: Container(
                      constraints: const BoxConstraints(
                        minHeight: 55,
                        minWidth: 55,
                      ),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: textFieldColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/Marketplace.svg',
                        height: 30,
                        width: 30,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Stack(
              children: [
                Obx(() {
                  return CarouselSlider.builder(
                    itemCount: homeController.homeBanners.isEmpty
                        ? imageList.length
                        : homeController.homeBanners.length,
                    carouselController: controller,
                    itemBuilder: (context, index, realIndex) {
                      var img = homeController.homeBanners.isEmpty
                          ? imageList[index]
                          : homeController.homeBanners[index].imageUrl ?? '';
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: img.contains('http') || img.contains('https')
                              ? Image.network(
                                  img,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                )
                              : Image.asset(
                                  img,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 20.h,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        currentIndex.value = index;
                      },
                    ),
                  );
                }),
                Positioned(
                  right: 40.w,
                  bottom: 1.h,
                  child: Row(
                    children: imageList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => {
                          controller.animateToPage(entry.key)
                        }, // you can add slide jump here
                        child: Obx(
                          () => Container(
                            width: currentIndex.value == entry.key ? 12.0 : 8,
                            height: currentIndex.value == entry.key ? 12.0 : 8,
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: textWhiteColor,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
            // SizedBox(
            //   width: double.infinity,
            //   height: 20.h,
            //   child: CarouselView(
            //     itemExtent: 100.w,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     scrollDirection: Axis.horizontal,
            //     itemSnapping: true,
            //     padding: EdgeInsets.symmetric(horizontal: 20),
            //     children: [
            //       Image.asset(
            //         'assets/images/home_crousel.png',
            //         fit: BoxFit.cover,
            //       ),
            //       Image.asset(
            //         'assets/images/home_crousel.png',
            //         fit: BoxFit.cover,
            //       ),
            //     ],
            //   ),
            // ),

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
                    padding: EdgeInsets.all(2.h).copyWith(bottom: 1.h),
                    child: Text('Top Games',
                        style: textTheme.displaySmall
                            ?.copyWith(color: textWhiteColor))),
                Container(
                    decoration: const BoxDecoration(
                        // color: textFieldColor,
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
            childAspectRatio: 3.5,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 8),
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
                  // padding:
                  //     const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: textFieldColor,
                    // border: bor,
                    border: Border.all(
                      color: Color(0xFF7B7B7B),
                    ),
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
