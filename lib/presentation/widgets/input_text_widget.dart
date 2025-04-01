import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/theme/colors.dart';

class InputTextWidget extends StatelessWidget {
  final String hintName;
  final int? maxLines;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final Color? txtHintColor;
  final double? verticalHeight;
  final TextEditingController? controller;
  final dynamic onChanged;
  final TextAlign? textAlign;
  final double? minimumHeight;
  final void Function(String)? onEditingComplete;

  const InputTextWidget(
      {Key? key,
      required this.hintName,
      this.maxLines,
      this.validator,
      this.keyboardType,
      this.txtHintColor,
      this.verticalHeight,
      this.controller,
      this.onChanged,
      this.textAlign,
      this.minimumHeight,
      this.onEditingComplete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Stack(
      children: [
        Container(
          constraints: BoxConstraints(
            minHeight: minimumHeight ?? 6.5.h,
            minWidth: double.infinity,
          ),
          decoration: BoxDecoration(
            color: textFieldColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        TextFormField(
          textAlign: textAlign ?? TextAlign.start,
          validator: validator,
          style: textTheme.headlineMedium?.copyWith(color: textWhiteColor),
          maxLines: maxLines ?? 1,
          cursorColor: whiteColor,
          cursorHeight: 20.0,
          controller: controller,
          keyboardType: keyboardType ?? TextInputType.name,
          onChanged: onChanged,
          onFieldSubmitted: onEditingComplete,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: 23.0, vertical: verticalHeight ?? 0.0),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: aquaGreenColor, width: 0.5),
              borderRadius: BorderRadius.circular(8.0),
            ),
            border: InputBorder.none,
            hintStyle: textTheme.headlineMedium
                ?.copyWith(color: txtHintColor ?? textInputTitleColor),
            hintText: hintName,
          ),
        ),
      ],
    );
  }
}
