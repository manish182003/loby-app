import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class BuildDropdown extends StatefulWidget {

  final ValueChanged<String> onChanged;
  final String defaultValue, selectedValue, dropdownHint;
  final List<String> itemsList;
  final double height;
  final double width;

  const BuildDropdown({Key key, this.itemsList, this.defaultValue, this.dropdownHint, this.onChanged, this.height, this.selectedValue, this.width}) : super(key: key);

  @override
  State<BuildDropdown> createState() => _BuildDropdownState();
}

class _BuildDropdownState extends State<BuildDropdown> {

  String _value;


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DropdownButtonFormField2(
      value: _value ?? widget.defaultValue,
      decoration:
      InputDecoration(
        //Add isDense true and zero Padding.
        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        //Add more decoration as you want here
        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
      ),
      isExpanded: true,
      hint: Text(
        widget.dropdownHint,
        style: textTheme.headline3,
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
        color:Colors.black45,
      ),
      iconSize: 20,
      buttonHeight: widget.height ?? 35,
      buttonWidth:  widget.height ?? 35,
      buttonPadding: const EdgeInsets.only(left: 10, right: 10),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      items: widget.itemsList.map((item) =>
          DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: textTheme.headline3
            ),
          ))
          .toList(),
      // validator: (value) {
      //   if (value == null) {
      //     return 'Account Type';
      //   }
      // },
      onChanged: (value) {
        setState(() {
          _value = value.toString();
        });
        widget.onChanged(value);
        //Do something when changing the item if you want.
      },
      onSaved: (value) {
        setState(() {
          _value = value.toString();
          
        });
        widget.onChanged(value);
      },
    );
  }
}
