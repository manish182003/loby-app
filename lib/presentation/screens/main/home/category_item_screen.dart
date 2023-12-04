import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/presentation/getx/controllers/home_controller.dart';
import 'package:loby/presentation/screens/main/home/widgets/categoriy_item_card.dart';
import 'package:loby/presentation/widgets/body_padding_widget.dart';
import 'package:loby/presentation/widgets/custom_loader.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:sizer/sizer.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/text_fields/text_field_widget.dart';

class CategoryItemScreen extends StatefulWidget {
  final int? categoryId;
  final String? catName;

  const CategoryItemScreen({Key? key, required this.categoryId, required this.catName})
      : super(key: key);

  @override
  State<CategoryItemScreen> createState() => _CategoryItemScreenState();
}

class _CategoryItemScreenState extends State<CategoryItemScreen> {
  HomeController homeController = Get.find<HomeController>();
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.getCategoryGames(categoryId: widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        // appBar: PreferredSize(
        //   preferredSize: const Size(double.infinity, 70),
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 18),
        //     child: AppBar(
              
        //       backgroundColor: Colors.transparent,
        //       elevation: 0,
        //       leading: 
        //           GestureDetector(
                    
        //               onTap: () {
        //                 Navigator.pop(context);
        //               },
        //               child: Container(
        //                 height: 10,
        //                 width: 10,
        //                 decoration: BoxDecoration(
        //                   color: textCharcoalBlueColor,
        //                   borderRadius: BorderRadius.circular(50)
        //                 ),
        //                 child: Center(child: const Icon(Icons.arrow_back_ios, size: 13, color: Colors.white,)),
        //               ),
        //             ),
        //           title: Text("${widget.catName}", style: textTheme.headline1?.copyWith(color: aquaGreenColor),),
        //           centerTitle: true,
                  
        //           actions: [
        //             GestureDetector(
                    
        //               onTap: () {
        //                 context.pushNamed(searchScreenPage);
        //               },
        //               child: Container(
        //                 height: 40,
        //                 width: 40,
        //                 decoration: BoxDecoration(
        //                   color: textCharcoalBlueColor,
        //                   borderRadius: BorderRadius.circular(10)
        //                 ),
        //                 child: const Icon(CupertinoIcons.search, size: 23, color: Colors.white,),
        //               ),
        //             ),
        //           ],
        //     ),
        //   ),
        // ),
        // appBar(
        //     context: context, appBarName: widget.catName, txtColor: aquaGreenColor),
        // appBar: AppBar(),
        body: Column(
          children: [
             Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                  width: 42,
                  height: 42,
                  child: MaterialButton(
                    shape: const CircleBorder(),
                    color: textCharcoalBlueColor,
                    onPressed: () {
                        Navigator.pop(context);
                      
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text("${widget.catName}", style: textTheme.headline2?.copyWith(color: aquaGreenColor),),
                      GestureDetector(
                    onTap: () {
                      context.pushNamed(searchScreenPage);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: textCharcoalBlueColor,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Icon(CupertinoIcons.search, size: 23, color: Colors.white,),
                    ),
                  ),
                    ],
                  ),
                
                ),
              )),
              SizedBox(height: 2.h,),
            BodyPaddingWidget(
              child: TextFieldWidget(
                textEditingController: search,
                hint: "Select Game (Dropdown + searchfree)",
                
                onChanged: (value) {
                  homeController.getCategoryGames(
                      categoryId: widget.categoryId, search: value,);
                },
              ),
            ),
            Obx(() {
              if (homeController.isCategoryGamesFetching.value) {
                return const CustomLoader();
              } else {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 6.0 / 7.75,
                        mainAxisSpacing: 1,
                        // crossAxisSpacing: 1,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: homeController.categoryGames.length,
                      itemBuilder: (context, index) {
                        final game = homeController.categoryGames[index].game;
                        return CategoryItemCard(
                          categoryId: widget.categoryId!,
                          gameId: game!.id!,
                          index: index,
                          gameName: game.name!,
                          images: game.image,
                          game: game,
                        );
                      },
                    ),
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
