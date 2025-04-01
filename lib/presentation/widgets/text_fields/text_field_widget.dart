import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/widgets/custom_text_field.dart';
import 'package:sizer/sizer.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController textEditingController;
  final String type;
  final String? title;
  final String? hint;
  final int? maxLines;
  final int? length;
  final bool isNumber;
  final ValueChanged<String>? onChanged;
  final bool isRequired;
  final TextInputAction? textInputAction;
  final String? icon;
  final Function()? onTap;
  final bool isReadableOnly;
  final double? scrollBottomPadding;
  final Color? titleColor;
  final String? prefix;
  const TextFieldWidget(
      {super.key,
      required this.textEditingController,
      this.type = 'normal',
      this.hint,
      this.maxLines,
      this.isNumber = false,
      this.onChanged,
      this.isRequired = false,
      this.textInputAction,
      this.icon,
      this.onTap,
      this.length,
      this.title,
      this.isReadableOnly = false,
      this.scrollBottomPadding,
      this.prefix,
      this.titleColor});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool isVisible = false;

  DateTime selectedDate = DateTime.now();
  DateTime date = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title == null
            ? const SizedBox()
            : Text(
                widget.title ?? "",
                style: textTheme.headlineSmall
                    ?.copyWith(color: widget.titleColor ?? textInputTitleColor),
              ),
        SizedBox(
          height: widget.title == null ? 0.h : 2.h,
        ),
        CustomTextField(
          validator: (value) {
            if (widget.isRequired) {
              switch (widget.type) {
                case 'normal':
                  return Helpers.validateField(value!);
                case 'email':
                  return Helpers.validateEmail(value!);
                case 'phone':
                  return Helpers.validatePhone(value!);
                case 'password':
                  return Helpers.validatePassword(value!);
                case 'withdraw':
                  return Helpers.validateWalletWithdraw(value!,
                      Get.find<ProfileController>().profile.walletMoney!);
                case 'add':
                  return Helpers.validateWalletAdd(value!);
                case 'link':
                  return Helpers.validateLink(value!);
                case 'optionalLink':
                  return Helpers.validateOptionalLink(value!);
                case 'token':
                  return Helpers.validateTokenLimit(value!);
                case 'stock':
                  return Helpers.validateStockLimit(value!);
                default:
                  return Helpers.validateField(value!);
              }
            }
            return null;
          },
          onTap: () async {
            if (widget.type == "date") {
              FocusScope.of(context).requestFocus(FocusNode());
              await _selectDate(context);
              widget.textEditingController.text =
                  DateFormat('dd/MM/yyyy').format(date);
            }
          },
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          inputFormatters: widget.isNumber
              ? [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ]
              : widget.type == "username"
                  ? [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ]
                  : null,
          input: widget.textEditingController,
          obscureText: widget.type == 'password' ? !isVisible : isVisible,
          hintText: widget.hint,
          textCapitalization: TextCapitalization.none,
          length: widget.length,
          keyboardType: widget.isNumber
              ? TextInputType.number
              : widget.type == 'email'
                  ? TextInputType.emailAddress
                  : widget.textInputAction == TextInputAction.newline
                      ? TextInputType.multiline
                      : TextInputType.name,
          textInputAction: widget.textInputAction ?? TextInputAction.next,
          isReadableOnly: widget.isReadableOnly,
          maxLines: widget.maxLines ?? 1,
          scrollBottomPadding: widget.scrollBottomPadding ??
              MediaQuery.of(context).viewInsets.bottom,
          iconButton: widget.type == 'password'
              ? IconButton(
                  padding: const EdgeInsets.all(0.0),
                  icon: Icon(
                    isVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: iconTintColor,
                    size: 15,
                  ),
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                )
              : widget.icon != null
                  ? IconButton(
                      padding: const EdgeInsets.all(0.0),
                      icon: SvgPicture.asset(
                        widget.icon!,
                      ),
                      onPressed: widget.onTap,
                      color: Colors.black,
                    )
                  : null,
        ),
      ],
    );
  }
}
