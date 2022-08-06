import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../core/theme/colors.dart';

class DropDownDivider extends StatefulWidget {
  const DropDownDivider({Key? key}) : super(key: key);

  @override
  State<DropDownDivider> createState() => _DropDownDividerState();
}

class _DropDownDividerState extends State<DropDownDivider> {
  final List<String> items = [
    'Top Rated',
    'Most Recent',
    'Low to High Price',
    'High to Low Price',
  ];
  String? selectedValue = 'Top Rated';

  List<DropdownMenuItem<String>> _addDividersAfterItems(
      List<String> items, TextTheme textTheme) {
    List<DropdownMenuItem<String>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    item,
                    style: textTheme.headline6?.copyWith(color: textWhiteColor),
                  ),
                ],
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(
                  color: footerColor,
                ),
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

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        // Reduces the dropdowns height by +/- 50%
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: iconWhiteColor,
        ),
        items: _addDividersAfterItems(items, textTheme),
        customItemsIndexes: _getDividersIndexes(),
        customItemsHeight: 4,
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
          });
        },
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: shipGreyColor,
        ),
        buttonHeight: 40,
        buttonWidth: 150,
        itemHeight: 40,
        itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      ),
    );
  }
}
