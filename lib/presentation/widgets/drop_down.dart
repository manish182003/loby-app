import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:sizer/sizer.dart';

class MyDropDownWidget extends StatefulWidget {
  final String? hintTxt;
  final Color? hintColor;

  const MyDropDownWidget({Key? key, this.hintTxt, this.hintColor}) : super(key: key);

  @override
  State<MyDropDownWidget> createState() => _MyDropDownWidgetState();
}

class _MyDropDownWidgetState extends State<MyDropDownWidget> {
  final items = ['One', 'Two', 'Three', 'Four'];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
        constraints: const BoxConstraints(
          minHeight: 45,
          minWidth: double.infinity,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
        decoration: BoxDecoration(
            color: textFieldColor, borderRadius: BorderRadius.circular(10)),

        // dropdown below..
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              customButton: Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(widget.hintTxt??
                          'Select',
                        style: textTheme.headline4
                            ?.copyWith(color: textLightColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: textLightColor,
                    ),
                  ],
                ),
              ),
              customItemsIndexes: const [2],
              customItemsHeight: 8,
              items: [
                ...MenuItems.firstItems.map(
                      (item) =>
                      DropdownMenuItem<MenuItem>(
                        value: item,
                        child: MenuItems.buildItem(item),
                      ),
                ),
              ],
              onChanged: (value) {
                MenuItems.onChanged(context, value as MenuItem);
              },
              itemHeight: 48,
              itemPadding: const EdgeInsets.only(left: 16, right: 16),
              dropdownWidth: 160,
              dropdownPadding: const EdgeInsets.symmetric(vertical: 2),
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: backgroundBalticSeaColor,
              ),
              dropdownElevation: 8,
              offset: const Offset(0, 8),
            ),
          ),
        ),
    );
  }

  List<DropdownMenuItem<String>> _addDividersAfterItems(
      List<String> items, TextTheme textTheme) {
    List<DropdownMenuItem<String>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item,
                style: textTheme.headline6?.copyWith(color: textWhiteColor),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(
                color: dividerColor,
              ),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<int> _getDividersIndexes() {
    List<int> _dividersIndexes = [];
    for (var i = 0; i < (items.length * 2) - 1; i++) {
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        _dividersIndexes.add(i);
      }
    }
    return _dividersIndexes;
  }
}

class MenuItem {
  final String text;

  const MenuItem({
    required this.text,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [home, share];

  static const home = MenuItem(text: 'Home',);
  static const share = MenuItem(text: 'Share',);

  static Widget buildItem(MenuItem item) {
    return Container(
      decoration: BoxDecoration(
        color: textFieldColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: double.infinity,
              child: Text(
                textAlign: TextAlign.center,
                item.text,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.home:
      //Do something
        break;
      case MenuItems.share:
      //Do something
        break;
    }
  }
}

