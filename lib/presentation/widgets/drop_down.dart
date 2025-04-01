// import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:loby/core/theme/colors.dart';

class MyDropDownWidget extends StatefulWidget {
  final String? hintTxt;
  final Color? hintColor;

  const MyDropDownWidget({super.key, this.hintTxt, this.hintColor});

  @override
  State<MyDropDownWidget> createState() => _MyDropDownWidgetState();
}

class _MyDropDownWidgetState extends State<MyDropDownWidget> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      constraints: const BoxConstraints(
        minHeight: 49,
        minWidth: double.infinity,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
      decoration: BoxDecoration(
          color: textFieldColor, borderRadius: BorderRadius.circular(10)),

      // dropdown below..
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          // Reduces the dropdowns height by +/- 50%
          hint: Container(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: Text(
                      widget.hintTxt ?? 'Select',
                      style: textTheme.headlineMedium
                          ?.copyWith(color: textLightColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
          iconStyleData: IconStyleData(
            icon: const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: iconWhiteColor,
              ),
            ),
          ),

          items: _addDividersAfterItems(items, textTheme),
          // customItemsIndexes: _getDividersIndexes(),
          // customItemsHeight: 4,
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
            });
          },
          dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: shipGreyColor,
          )),
          buttonStyleData: ButtonStyleData(
              height: 40,
              width: 140,
              padding: const EdgeInsets.symmetric(horizontal: 8.0)),
          // buttonHeight: 40,
          // buttonWidth: 140,
          // itemHeight: 40,
          // itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _addDividersAfterItems(
      List<String> items, TextTheme textTheme) {
    List<DropdownMenuItem<String>> menuItems = [];
    for (var item in items) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item,
                style:
                    textTheme.headlineMedium?.copyWith(color: textWhiteColor),
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
    return menuItems;
  }

  List<int> _getDividersIndexes() {
    List<int> dividersIndexes = [];
    for (var i = 0; i < (items.length * 2) - 1; i++) {
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        dividersIndexes.add(i);
      }
    }
    return dividersIndexes;
  }
}

class MenuItem {
  final String text;

  const MenuItem({
    required this.text,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [home, share, settings];

  static const home = MenuItem(
    text: 'Home',
  );
  static const share = MenuItem(
    text: 'Share',
  );
  static const settings = MenuItem(
    text: 'Settings',
  );

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.home:
        //Do something
        break;
      case MenuItems.settings:
        //Do something
        break;
      case MenuItems.share:
        //Do something
        break;
    }
  }
}
