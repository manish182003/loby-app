import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';

class HoursDropDownDivider extends StatefulWidget {
  const HoursDropDownDivider({Key? key}) : super(key: key);

  @override
  State<HoursDropDownDivider> createState() => _HoursDropDownDividerState();
}

class _HoursDropDownDividerState extends State<HoursDropDownDivider> {

  final List<String> items = [
    'Hour',
    'Quantity',
    'Session',
    'Match',
  ];
  String? selectedValue = 'Hour';

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
          color: backgroundBalticSeaColor,
        ),
        buttonHeight: 40,
        buttonWidth: 140,
        itemHeight: 40,
        itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      ),
    );
  }
}