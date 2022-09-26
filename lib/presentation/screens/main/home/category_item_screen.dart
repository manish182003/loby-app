import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loby/presentation/getx/controllers/home_controller.dart';
import 'package:loby/presentation/getx/controllers/listing_controller.dart';
import 'package:loby/presentation/screens/main/home/widgets/categoriy_item_card.dart';
import 'package:loby/presentation/widgets/body_padding_widget.dart';
import 'package:loby/presentation/widgets/custom_loader.dart';
import 'package:loby/presentation/widgets/text_fields/auto_complete_field.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/colors.dart';
import '../../../widgets/SearchFieldWidget.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/drop_down.dart';
import '../../../widgets/text_fields/text_field_widget.dart';

class CategoryItemScreen extends StatefulWidget {
  final int? categoryId;

  const CategoryItemScreen({Key? key, required this.categoryId}) : super(key: key);

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

    return Scaffold(
      appBar: appBar(context: context, appBarName: "Accounts"),
        body: Column(
          children: [
            BodyPaddingWidget(
              child: TextFieldWidget(
                textEditingController: search,
                hint: "Search...",
                onChanged: (value){
                  homeController.getCategoryGames(categoryId: widget.categoryId, search: value);
                },
              ),
            ),
            Obx(() {
              if(homeController.isCategoryGamesFetching.value){
                return const CustomLoader();
              }else{
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 6.0 / 7.5,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
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
                            images: game.image);
                      },
                    ),
                  ),
                );
              }

            }),
          ],
        ),
    );
  }
}
