import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:sizer/sizer.dart';

class MyDropDownWidget extends StatefulWidget {
  final String? hintTxt;
  const MyDropDownWidget({Key? key, this.hintTxt}) : super(key: key);

  @override
  State<MyDropDownWidget> createState() => _MyDropDownWidgetState();
}

class _MyDropDownWidgetState extends State<MyDropDownWidget> {
  final items = ['Select', 'Two', 'Three', 'Four'];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
        constraints: const BoxConstraints(
          minHeight: 45, minWidth: double.infinity,),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
        decoration: BoxDecoration(
            color: textFieldColor, borderRadius: BorderRadius.circular(10)),

        // dropdown below..
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              isDense: false,
              hint: Container(
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
                  ],
                ),
              ),
              // Reduces the dropdowns height by +/- 50%
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: textLightColor,
              ),
              value: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value as String;
                });
              },
              items: items
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: aquaGreenColor,
                            borderRadius: BorderRadius.circular(1.5.h),
                          ),
                          child: Text(
                            item,
                            style: textTheme.headline4
                                ?.copyWith(color: textLightColor),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ));
  }
}
