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

  const InputTextWidget({Key? key, required this.hintName, this.maxLines, this.validator, this.keyboardType, this.txtHintColor, this.verticalHeight, this.controller, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      constraints: const BoxConstraints(
          minHeight: 45, minWidth: double.infinity,),
      decoration: BoxDecoration(
        color: textFieldColor,
        borderRadius: BorderRadius.circular(1.5.h),
      ),
      child: TextFormField(
        validator: validator,
        style: textTheme.headline4?.copyWith(color: textWhiteColor),
        maxLines: maxLines?? 1,
        cursorColor: whiteColor,
        cursorHeight: 20.0,
        controller: controller,
        keyboardType: keyboardType?? TextInputType.name,
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 23.0, vertical: verticalHeight?? 0.0),
          focusedBorder:OutlineInputBorder(
            borderSide: const BorderSide(color: aquaGreenColor, width: 0.5),
            borderRadius: BorderRadius.circular(1.5.h),
          ),
          border: InputBorder.none,
          hintStyle:
              textTheme.headline4?.copyWith(color: txtHintColor??textInputTitleColor),
          hintText: hintName,
        ),
      ),
    );
  }
}
