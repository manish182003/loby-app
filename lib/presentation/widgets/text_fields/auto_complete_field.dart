import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sizer/sizer.dart';

import '../../../core/theme/colors.dart';
import '../../../core/utils/helpers.dart';

class AutoCompleteField extends StatefulWidget {
  final List? suggestions;
  final String? hint;
  final String? title;
  final String? icon;
  final double? height;
  final bool readOnly;
  final TextEditingController? selectedSuggestion;
  final ValueChanged<String>? onChanged;
  final FutureOr<List<dynamic>?> Function(String)? suggestionsCallback;
  final Function(dynamic)? onSuggestionSelected;
  final bool isRequired;
  final bool isMultiple;
  final List? selectedValuesList;

  const AutoCompleteField(
      {super.key,
      this.suggestions,
      this.selectedSuggestion,
      this.onChanged,
      this.hint,
      this.icon,
      this.height,
      this.suggestionsCallback,
      this.onSuggestionSelected,
      this.selectedValuesList,
      this.isRequired = false,
      this.isMultiple = false,
      this.title,
      this.readOnly = false});

  @override
  State<AutoCompleteField> createState() => _AutoCompleteFieldState();
}

class _AutoCompleteFieldState extends State<AutoCompleteField> {
  final SuggestionsController _suggestionsController = SuggestionsController();
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
                widget.title ?? '',
                style: textTheme.headlineSmall
                    ?.copyWith(color: textInputTitleColor),
              ),
        SizedBox(height: widget.title == null ? 0.h : 2.h),
        TypeAheadField(
          builder: (context, controller, focusNode) {
            return TextFormField(
              controller: controller,
              focusNode: focusNode,
              enableSuggestions: true,
              readOnly: widget.readOnly,
              onTap: () {
                if (widget.readOnly) {
                  controller.clear(); // Let user reselect even same value
                  focusNode.requestFocus();
                  _suggestionsController.open();
                }
              },
              scrollPadding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom * 1.5),
              style: textTheme.headlineMedium!.copyWith(color: textWhiteColor),
              decoration: InputDecoration(
                hintText: widget.hint,

                filled: true,
                fillColor: textFieldColor,

                // label: Text(hint),
                hintStyle: textTheme.headlineMedium
                    ?.copyWith(color: textInputTitleColor),
                labelStyle:
                    textTheme.headlineMedium!.copyWith(color: textWhiteColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          widget.isMultiple ? textFieldColor : aquaGreenColor,
                      width: widget.isMultiple ? 0 : 0.5),
                  borderRadius: widget.isMultiple
                      ? widget.selectedValuesList!.isNotEmpty
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0))
                          : BorderRadius.circular(8.0)
                      : BorderRadius.circular(8.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: textFieldColor,
                      width: widget.isMultiple ? 0 : 0.5),
                  borderRadius: widget.isMultiple
                      ? widget.selectedValuesList!.isNotEmpty
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0))
                          : BorderRadius.circular(8.0)
                      : BorderRadius.circular(8.0),
                ),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: textFieldColor,
                      width: widget.isMultiple ? 0 : 0.5),
                  borderRadius: widget.isMultiple
                      ? widget.selectedValuesList!.isNotEmpty
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0))
                          : BorderRadius.circular(8.0)
                      : BorderRadius.circular(8.0),
                ),

                errorBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: textErrorColor, width: 0.5),
                  borderRadius: BorderRadius.circular(8.0),
                ),

                focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: textErrorColor, width: 0.5),
                  borderRadius: BorderRadius.circular(8.0),
                ),

                suffixIcon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: whiteColor,
                  size: 20,
                ),
              ),
              cursorColor: whiteColor,
              validator: (value) {
                if (widget.isRequired) {
                  if (widget.isMultiple) {
                    if (widget.selectedValuesList!.isEmpty) {
                      return Helpers.validateField(value!);
                    } else {
                      return null;
                    }
                  } else {
                    return Helpers.validateField(value!);
                  }
                }
                return null;
              },
            );
          },
          // validator: (value) {
          //   if (isRequired) {
          //     if (isMultiple) {
          //       if (selectedValuesList!.isEmpty) {
          //         return Helpers.validateField(value!);
          //       } else {
          //         return null;
          //       }
          //     } else {
          //       return Helpers.validateField(value!);
          //     }
          //   }
          //   return null;
          // },

          itemBuilder: (context, item) => ListTile(
              title: Text(
            item.toString(),
            style: textTheme.headlineMedium!.copyWith(color: textWhiteColor),
          )),
          decorationBuilder: (context, child) {
            return Material(
              color: shipGreyColor,
              borderRadius: BorderRadius.circular(20),
              textStyle: TextStyle(
                color: textWhiteColor,
              ),
              child: child,
            );
          },
          suggestionsController: _suggestionsController,
          suggestionsCallback: (search) async {
            if (widget.suggestionsCallback != null) {
              return await widget.suggestionsCallback!(search);
            }
            return [];
          },

          onSelected: (value) {
            if (widget.onSuggestionSelected != null) {
              widget.onSuggestionSelected!(value);
            }

            widget.selectedSuggestion?.text = value;
          },
          //    getImmediateSuggestions: false,
          // hideSuggestionsOnKeyboardHide: true,
          controller: widget.selectedSuggestion,

          // onSuggestionSelected: onSuggestionSelected ??
          //     (value) {
          //       selectedSuggestion!.text = value.toString();
          //       onChanged!(value.toString());
          //     },

          // suggestionsBoxDecoration: SuggestionsBoxDecoration(
          //     borderRadius: BorderRadius.circular(14),
          //     color: shipGreyColor,
          //     constraints: BoxConstraints(
          //       minHeight: 10.h,
          //     )),

          hideOnEmpty: false,
          // keepSuggestionsOnSuggestionSelected: false,
          // noItemsFoundBuilder: (context) => Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     'No Item Found',
          //     style: textTheme.headlineMedium!
          //         .copyWith(color: textInputTitleColor),
          //   ),
          // ),

          // textFieldConfiguration: TextFieldConfiguration(
          // scrollPadding: EdgeInsets.only(
          //     bottom: MediaQuery.of(context).viewInsets.bottom * 1.5),
          // style: textTheme.headlineMedium!.copyWith(color: textWhiteColor),
          // decoration: InputDecoration(
          //   hintText: hint,
          //   filled: true,
          //   fillColor: textFieldColor,
          //   // label: Text(hint),
          //   hintStyle: textTheme.headlineMedium
          //       ?.copyWith(color: textInputTitleColor),
          //   labelStyle:
          //       textTheme.headlineMedium!.copyWith(color: textWhiteColor),
          //   focusedBorder: OutlineInputBorder(
          //     borderSide: BorderSide(
          //         color: isMultiple ? textFieldColor : aquaGreenColor,
          //         width: isMultiple ? 0 : 0.5),
          //     borderRadius: isMultiple
          //         ? selectedValuesList!.isNotEmpty
          //             ? const BorderRadius.only(
          //                 topLeft: Radius.circular(8.0),
          //                 topRight: Radius.circular(8.0))
          //             : BorderRadius.circular(8.0)
          //         : BorderRadius.circular(8.0),
          //   ),
          //   border: OutlineInputBorder(
          //     borderSide: BorderSide(
          //         color: textFieldColor, width: isMultiple ? 0 : 0.5),
          //     borderRadius: isMultiple
          //         ? selectedValuesList!.isNotEmpty
          //             ? const BorderRadius.only(
          //                 topLeft: Radius.circular(8.0),
          //                 topRight: Radius.circular(8.0))
          //             : BorderRadius.circular(8.0)
          //         : BorderRadius.circular(8.0),
          //   ),

          //   enabledBorder: OutlineInputBorder(
          //     borderSide: BorderSide(
          //         color: textFieldColor, width: isMultiple ? 0 : 0.5),
          //     borderRadius: isMultiple
          //         ? selectedValuesList!.isNotEmpty
          //             ? const BorderRadius.only(
          //                 topLeft: Radius.circular(8.0),
          //                 topRight: Radius.circular(8.0))
          //             : BorderRadius.circular(8.0)
          //         : BorderRadius.circular(8.0),
          //   ),

          //   errorBorder: OutlineInputBorder(
          //     borderSide: const BorderSide(color: textErrorColor, width: 0.5),
          //     borderRadius: BorderRadius.circular(8.0),
          //   ),

          //   focusedErrorBorder: OutlineInputBorder(
          //     borderSide: const BorderSide(color: textErrorColor, width: 0.5),
          //     borderRadius: BorderRadius.circular(8.0),
          //   ),

          //   suffixIcon: const Icon(
          //     Icons.keyboard_arrow_down,
          //     color: whiteColor,
          //     size: 20,
          //   ),
          // ),
          // controller: selectedSuggestion,
          // cursorColor: whiteColor,
        ),
      ],
    );
  }
}
