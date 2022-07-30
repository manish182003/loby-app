import 'package:flutter/material.dart';
import 'package:loby/core/theme/colors.dart';

class CustomCheckbox extends StatefulWidget {
  double? size;
  double? iconSize;
  Function onChange;
  Color? backgroundColor;
  Color? iconColor;
  Color? borderColor;
  IconData? icon;
  bool isChecked;

  CustomCheckbox({
    Key? key,
    this.size,
    this.iconSize,
    required this.onChange,
    this.backgroundColor,
    this.iconColor,
    this.icon,
    this.borderColor,
    required this.isChecked,
  }) : super(key: key);

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
          widget.onChange(isChecked);
        });
      },
      child: AnimatedContainer(
          height: widget.size ?? 28,
          width: widget.size ?? 28,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: isChecked
                  ? widget.backgroundColor ?? aquaGreenColor
                  : Colors.transparent,
              border: Border.all(color: widget.borderColor ?? Colors.black)),
          child: isChecked
              ? Icon(
            widget.icon ?? Icons.check,
            color: widget.iconColor ?? Colors.white,
            size: widget.iconSize ?? 20,
          )
              : null),
    );
  }
}