import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';

class HoursDropDownDivider extends StatefulWidget {
  const HoursDropDownDivider({super.key});

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
    List<DropdownMenuItem<String>> menuItems = [];
    for (var item in items) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                item,
                style: textTheme.titleLarge?.copyWith(color: textWhiteColor),
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

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        iconStyleData: IconStyleData(
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: iconWhiteColor,
          ),
        ),
        // Reduces the dropdowns height by +/- 50%

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
            color: backgroundBalticSeaColor,
          ),
        ),
        // dropdownDecoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(14),
        //   color: backgroundBalticSeaColor,
        // ),
        buttonStyleData: ButtonStyleData(
          height: 40,
          width: 150,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
        ),
        // buttonHeight: 40,
        // buttonWidth: 150,
        // itemHeight: 40,
        // itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      ),
    );
  }
}
