import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loby/presentation/screens/main/home/widgets/categoriy_item_card.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/colors.dart';
import '../../../widgets/SearchFieldWidget.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/drop_down.dart';

class CategoryItemScreen extends StatefulWidget {
  String name;

  CategoryItemScreen({Key? key, required this.name}) : super(key: key);

  @override
  State<CategoryItemScreen> createState() => _CategoryItemScreenState();
}

class _CategoryItemScreenState extends State<CategoryItemScreen> {

  List<String> images = [
    'assets/images/bgmi.png',
    'assets/images/cod_game.png',
    'assets/images/free_fire_game.png',
    'assets/images/bgmi.png',
    'assets/images/cod_game.png',
    'assets/images/free_fire_game.png'
  ];

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.name);
    return SafeArea(
      child: Scaffold(
        body: body(widget.name),
      ),
    );
  }

  Widget body(String name) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        CustomAppBar(
          appBarName: "Accounts",
          txtColor: aquaGreenColor
        ),
        const SearchFieldWidget(textHint: 'Search Game'),
        _buildCategories(textTheme),
      ],
    );
  }

  _buildCategories(TextTheme textTheme) {
    return Flexible(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 6.0 / 7.5,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: images.length,
            itemBuilder: (context, index) {
              return CategoryItemCard(index: index, images: images[index],);
            },
          ),
        ),
      ),
    );
  }
}
