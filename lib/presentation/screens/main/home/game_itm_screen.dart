import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loby/presentation/screens/main/home/widgets/ItemList.dart';
import 'package:loby/presentation/screens/main/home/widgets/filter_bottom_sheet_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/colors.dart';
import '../../../widgets/custom_chip.dart';
import '../../../widgets/drop_down_with_divider.dart';

class GameItemScreen extends StatefulWidget {
  String name;

  GameItemScreen({Key? key, required this.name}) : super(key: key);

  @override
  State<GameItemScreen> createState() => _GameItemScreenState();
}

class _GameItemScreenState extends State<GameItemScreen> {
  final int _selectedIndex = 0;
  final List<String> items = [
    'Top Rated',
    'Most Recent',
    'Low to High Price',
    'High to Low Price',
  ];
  String? selectedValue = 'Top Rated';

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.name);
    final textTheme = Theme.of(context).textTheme;
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
              mainAxisAlignment: MainAxisAlignment.start,
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
                  width: MediaQuery.of(context).size.width * 0.7,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 8.0),
                    child: Text(
                      'Battlegrounds Mobile',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style:
                          textTheme.headline2?.copyWith(color: aquaGreenColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildCategories(textTheme),
          const SizedBox(height: 8),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  constraints: const BoxConstraints(
                    minHeight: 45,
                    minWidth: 45,
                  ),
                  decoration: BoxDecoration(
                    color: textFieldColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.13,
                        child: SvgPicture.asset(
                          'assets/icons/search_icon.svg',
                          color: iconWhiteColor,
                          width: 18,
                          height: 18,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextField(
                          style: textTheme.headline4
                              ?.copyWith(color: textWhiteColor),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: textTheme.headline4
                                ?.copyWith(color: textWhiteColor),
                            hintText: 'Search',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4.0),
                SizedBox(
                  height: 45,
                  width: 66,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: backgroundBalticSeaColor,
                    onPressed: () {
                      _showDialog(context, textTheme);
                    },
                    child: SvgPicture.asset(
                      'assets/icons/filter_icon.svg',
                      color: iconTintColor,
                      height: 18,
                      width: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Text(
                    "124 Result",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: textTheme.headline6?.copyWith(color: textWhiteColor),
                  ),
                ),
                const SizedBox(width: 4.0),
                DropDownDivider(),
              ],
            ),
          ),
          const SizedBox(height: 4.0),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            child: Divider(
              color: dividerColor,
              height: 4,
              thickness: 2,
              endIndent: 0,
            ),
          ),
          const SizedBox(height: 10.0),
          _buildGames(textTheme),
        ],
      ),
    );
  }

  final List<String> bubbles = [
    'Accounts',
    'Buddy',
    'Rank Push',
    'In-Game Currency',
    'In-Game Items',
    'Coach',
    'Duel',
  ];

  _buildCategories(TextTheme textTheme) {
    return CustomChip(
      labelName: bubbles,
    );
  }

  _buildGames(TextTheme textTheme) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 6.0 / 9,
        mainAxisSpacing: 0.1.h,
        crossAxisSpacing: 0.1.h,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ItemList(name: 'hello $index'),
        );
      },
    );
  }

  void _showDialog(BuildContext context, TextTheme textTheme) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.3,
          maxChildSize: 0.3,
          minChildSize: 0.3,
          builder: (context, scrollController) {
            return Column(
              children: <Widget>[
                Expanded(
                    child: Container(
                  decoration: const BoxDecoration(
                    color: backgroundBalticSeaColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: FilterBottomSheet(controller: scrollController),
                )),
              ],
            );
          },
        );
      },
    );
  }
}
