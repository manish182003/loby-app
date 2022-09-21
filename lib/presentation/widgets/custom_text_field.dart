import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'responsive.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({Key key,
    this.input,
    this.hintText,
    this.length,
    this.onTap,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.preFilledValue,
    this.onFieldSubmitted,
    this.editable,
    this.onChanged,
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction,
    this.enabled,
    this.textSize,
    this.errorText,
    this.maxLines = 1,
    this.textCapitalization,
    this.borderRadius = 4,
    this.borderColor = Colors.grey,
    this.focusedBorderColor = Colors.grey,
    this.enabledBorderColor = Colors.grey,
    this.onEditingComplete,
    this.focusNode,
    this.iconButton
  }) : super(key: key);
  final TextEditingController input;
  final String hintText, labelText, helperText, preFilledValue, errorText;
  final TextInputAction textInputAction;
  final int length, maxLines;
  final Function onTap;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final Function onEditingComplete;
  final bool editable, enabled;
  final double textSize;
  final Function onChanged;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter> inputFormatters;
  final double borderRadius;
  final Color borderColor, focusedBorderColor, enabledBorderColor;
  final FocusNode focusNode;
  final IconButton iconButton;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TextFormField(
      focusNode: widget.focusNode,
      controller: widget.input,
      onTap: widget.onTap,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      onEditingComplete: widget.onEditingComplete,
      onChanged: widget.onChanged,
      initialValue: widget.preFilledValue,
      enabled: widget.enabled,
      readOnly: widget.editable,
      maxLength: widget.length,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      textCapitalization: widget.textCapitalization,
      // maxLengthEnforced: true,
      style: textTheme.headline3.copyWith(fontSize: 14, color: Colors.black),
      decoration: InputDecoration(
          suffixIcon: widget.iconButton,
        isDense: true,
        counterText: '',
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffC2C2C2)),
            borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius))),

        border:  OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffC2C2C2)),
            borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius))
        ),

        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffC2C2C2)),
            borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius))),

        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius))),

        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius))),
        labelStyle: textTheme.headline4.copyWith(fontSize: Responsive.isDesktop(context)
            ? 15 : 12, color: Colors.black.withOpacity(0.6),),
        errorStyle: const TextStyle(
          color: Colors.red,fontSize: 10.0
        ),
        hintText: widget.hintText,
        errorText: widget.errorText,
        hintStyle: textTheme.headline4.copyWith(color: Colors.black.withOpacity(0.6), fontSize: Responsive.isDesktop(context)
            ? 15 : 12),
        labelText: widget.labelText,
        helperText: widget.helperText
      ),
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType
    );
  }
}










