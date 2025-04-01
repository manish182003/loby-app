import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:loby/core/utils/helpers.dart';

import '../../../core/theme/colors.dart';

class BuildDropdown extends StatefulWidget {
  final ValueChanged<dynamic>? onChanged;
  final dynamic defaultValue, selectedValue, dropdownHint;
  final List<DropdownMenuItem<dynamic>>? itemsList;
  final double? height;
  final double? width;
  final bool isRequired;
  final bool isMultiple;
  final List? selectedItemList;
  const BuildDropdown(
      {super.key,
      this.itemsList,
      this.defaultValue,
      this.dropdownHint,
      this.onChanged,
      this.height,
      this.selectedValue,
      this.width,
      this.isRequired = false,
      this.isMultiple = false,
      this.selectedItemList});

  @override
  State<BuildDropdown> createState() => _BuildDropdownState();
}

class _BuildDropdownState extends State<BuildDropdown> {
  final String _value = '';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DropdownButtonFormField2(
      value: _value.isEmpty ? widget.defaultValue : _value,
      isExpanded: true,
      hint: Text(
        widget.dropdownHint ?? 'Select',
        style: textTheme.headlineMedium?.copyWith(color: textLightColor),
        overflow: TextOverflow.ellipsis,
      ),
      iconStyleData: IconStyleData(
        iconSize: 20,
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: iconWhiteColor,
        ),
      ),
      buttonStyleData: ButtonStyleData(
        height: 55,
        padding: const EdgeInsets.only(left: 10, right: 10),
      ),
      items: widget.itemsList,
      onChanged: widget.onChanged,
      validator: (dynamic value) {
        if (widget.isRequired) {
          if (widget.isMultiple) {
            if (widget.selectedItemList!.isEmpty) {
              return Helpers.validateField(value.toString());
            } else {
              return null;
            }
          } else {
            return Helpers.validateField(value.toString());
          }
        }
        return null;
      },

      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: shipGreyColor,
        ),
      ),
      // dropdownDecoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(14),
      //   color: shipGreyColor,
      // ),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        contentPadding: EdgeInsets.zero,
        fillColor: textFieldColor,
        hintStyle:
            textTheme.headlineMedium?.copyWith(color: textInputTitleColor),
        labelStyle: textTheme.headlineMedium!.copyWith(color: textWhiteColor),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.isMultiple ? textFieldColor : aquaGreenColor,
              width: widget.isMultiple ? 0 : 0.5),
          borderRadius: widget.isMultiple
              ? widget.selectedItemList!.isNotEmpty
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0))
                  : BorderRadius.circular(8.0)
              : BorderRadius.circular(8.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: textFieldColor, width: widget.isMultiple ? 0 : 0.5),
          borderRadius: widget.isMultiple
              ? widget.selectedItemList!.isNotEmpty
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0))
                  : BorderRadius.circular(8.0)
              : BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: textFieldColor, width: widget.isMultiple ? 0 : 0.5),
          borderRadius: widget.isMultiple
              ? widget.selectedItemList!.isNotEmpty
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0))
                  : BorderRadius.circular(8.0)
              : BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: textErrorColor, width: 0.5),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: textErrorColor, width: 0.5),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
