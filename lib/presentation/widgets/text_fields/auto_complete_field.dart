import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sizer/sizer.dart';

import '../../../core/theme/colors.dart';
import '../../../core/utils/helpers.dart';

class AutoCompleteField extends StatelessWidget {
  final List? suggestions;
  final String? hint;
  final String? title;
  final String? icon;
  final double? height;
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
      this.title});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title == null
            ? const SizedBox()
            : Text(
                title ?? '',
                style: textTheme.headlineSmall
                    ?.copyWith(color: textInputTitleColor),
              ),
        SizedBox(height: title == null ? 0.h : 2.h),
        TypeAheadField(
          builder: (context, controller, focusNode) {
            return TextFormField(
              controller: controller,
              focusNode: focusNode,
              enableSuggestions: true,
              scrollPadding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom * 1.5),
              style: textTheme.headlineMedium!.copyWith(color: textWhiteColor),
              decoration: InputDecoration(
                hintText: hint,

                filled: true,
                fillColor: textFieldColor,

                // label: Text(hint),
                hintStyle: textTheme.headlineMedium
                    ?.copyWith(color: textInputTitleColor),
                labelStyle:
                    textTheme.headlineMedium!.copyWith(color: textWhiteColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: isMultiple ? textFieldColor : aquaGreenColor,
                      width: isMultiple ? 0 : 0.5),
                  borderRadius: isMultiple
                      ? selectedValuesList!.isNotEmpty
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0))
                          : BorderRadius.circular(8.0)
                      : BorderRadius.circular(8.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: textFieldColor, width: isMultiple ? 0 : 0.5),
                  borderRadius: isMultiple
                      ? selectedValuesList!.isNotEmpty
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0))
                          : BorderRadius.circular(8.0)
                      : BorderRadius.circular(8.0),
                ),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: textFieldColor, width: isMultiple ? 0 : 0.5),
                  borderRadius: isMultiple
                      ? selectedValuesList!.isNotEmpty
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
                if (isRequired) {
                  if (isMultiple) {
                    if (selectedValuesList!.isEmpty) {
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
          suggestionsController: SuggestionsController(),
          suggestionsCallback: (search) async {
            if (suggestionsCallback != null) {
              return await suggestionsCallback!(search);
            }
            return [];
          },

          onSelected: (value) {
            if (onSuggestionSelected != null) {
              onSuggestionSelected!(value);
            }

            selectedSuggestion?.text = value;
          },
          //    getImmediateSuggestions: false,
          // hideSuggestionsOnKeyboardHide: true,
          controller: selectedSuggestion,

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
