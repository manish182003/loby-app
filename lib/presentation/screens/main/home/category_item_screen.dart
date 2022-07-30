import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loby/presentation/screens/main/home/widgets/categoriy_item_card.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/colors.dart';
import '../../../widgets/drop_down.dart';

class CategoryItemScreen extends StatefulWidget {
  String name;

  CategoryItemScreen({Key? key, required this.name}) : super(key: key);

  @override
  State<CategoryItemScreen> createState() => _CategoryItemScreenState();
}

class _CategoryItemScreenState extends State<CategoryItemScreen> {
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
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 7.h,
                  height: 7.h,
                  child: MaterialButton(
                    shape: const CircleBorder(),
                    color: backgroundBalticSeaColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset(
                      'assets/icons/back_icon.svg',
                      color: whiteColor,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 8.0),
                    child: Text(
                      name,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.headline2
                          ?.copyWith(color: aquaGreenColor),
                    ),
                  ),
                ),
                SizedBox(
                  width: 7.h,
                  height: 7.h,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: backgroundBalticSeaColor,
                    onPressed: () {
                      debugPrint("Click Search");
                    },
                    child: SvgPicture.asset(
                      'assets/icons/search_icon.svg',
                      color: whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal:16.0),
            child: MyDropDownWidget(),
          ),
          _buildCategories(textTheme),
        ],
      ),
    );
  }

  _buildCategories(TextTheme textTheme) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 6.0 / 8.0,
        mainAxisSpacing: 0.1.h,
        crossAxisSpacing: 0.1.h,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: CategoryItemCard(index: index),
        );
      },
    );
  }
}
