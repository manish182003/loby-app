import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({Key? key,
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
  final TextEditingController? input;
  final String? hintText, labelText, helperText, preFilledValue, errorText;
  final TextInputAction? textInputAction;
  final int? length, maxLines;
  final Function? onTap;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final Function? onEditingComplete;
  final bool? editable, enabled;
  final double? textSize;
  final Function? onChanged;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final double? borderRadius;
  final Color? borderColor, focusedBorderColor, enabledBorderColor;
  final FocusNode? focusNode;
  final IconButton? iconButton;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      focusNode: widget.focusNode,
      controller: widget.input,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      initialValue: widget.preFilledValue,
      enabled: widget.enabled,
      maxLength: widget.length,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType
    );
  }
}










